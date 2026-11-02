#!/usr/bin/env bash
# Copies this repository's documentation into a checkout of the website repository
# (zenc-lang-ce/zenc-lang-ce.github.io), as the site expects it: the language reference split
# into the Tour pages, the standard library, the Getting Started pages, the migration guides and
# the Rosetta examples, with Zola front matter and the GitHub alerts turned into the site's
# alert shortcode.
#
# Usage: scripts/sync_to_site.sh WEBSITE_DIR
# .github/workflows/sync-docs.yml runs it before committing to the website repository, and
# `make serve` runs it to preview the site locally.
set -euo pipefail

docs=$(cd "$(dirname "$0")/.." && pwd)
site=$(cd "$1" && pwd)/docs.zenc-lang.org

# split_reference.py rewrites reference/: run it on a copy, so this checkout stays as it is
src=$(mktemp -d)
trap 'rm -rf "$src"' EXIT
rsync -a --exclude .git --exclude .preview "$docs/" "$src/"
(cd "$src" && python3 scripts/split_reference.py --force > /dev/null)

# Shortcodes (e.g., misra_table.html: self-contained, no external data file)
mkdir -p "$site/templates/shortcodes/"
rsync -a "$src/site/templates/shortcodes/" "$site/templates/shortcodes/"

# Standard library (localized), with each README as the _index page of its section
mkdir -p "$site/content/docs/std/"
rsync -a --delete --exclude='_index*.md' "$src/std/" "$site/content/docs/std/"
find "$site/content/docs/std/" -name "README*.md" | while read -r file; do
    mv "$file" "${file/README/_index}"
done

# Language Tour (the split reference)
mkdir -p "$site/content/docs/tour/"
rsync -a --delete --exclude='_index.md' "$src/reference/" "$site/content/docs/tour/"

# Getting Started pages (English only), shown as plain documents, with their GitHub alerts
# (> [!WARNING]) turned into the site's alert shortcode, as in the Tour
for name in install changelog editors; do
    title=$(grep -m 1 "^# " "$src/$name.md" | sed 's/^# //')
    {
        printf '+++\ntitle = "%s"\ntemplate = "plain.html"\n+++\n\n' "$title"
        python3 -c 'import sys; sys.path.insert(0, sys.argv[2]); from split_reference import convert_alerts; sys.stdout.write(convert_alerts(open(sys.argv[1]).read()))' \
            "$src/$name.md" "$src/scripts"
    } > "$site/content/docs/$name.md"
done

# Migration guides (English only): one page per release, shown as plain documents
mkdir -p "$site/content/docs/migrations/"
rsync -a --delete --exclude='_index*.md' "$src/migrations/" "$site/content/docs/migrations/"
printf '+++\ntitle = "Migrations"\nsort_by = "title"\npage_template = "plain.html"\n+++\n' \
    > "$site/content/docs/migrations/_index.md"

# Rosetta examples, with each README as the _index page of its section
mkdir -p "$site/content/docs/examples/rosetta/"
rsync -a --delete --exclude='_index*.md' "$src/rosetta/" "$site/content/docs/examples/rosetta/"
find "$site/content/docs/examples/rosetta/" -name "README*.md" | while read -r file; do
    mv "$file" "${file/README/_index}"
done

# Section guard: every section needs an _index.<lang>.md for each language, or Zola fails
langs="es pt it de ru zh-cn zh-tw"
find "$site/content/docs/" -name "_index.md" | while read -r index_file; do
    dir=$(dirname "$index_file")
    for lang in $langs; do
        if [ ! -f "$dir/_index.$lang.md" ]; then
            cp "$index_file" "$dir/_index.$lang.md"
        fi
    done
done

# Every page needs front matter, titled after its first heading; the Rosetta templates
# ({{trans|...}}) are dropped. One perl for every file: one process per file took most of the time.
find "$site/content/docs/" -name "*.md" -exec perl -i -0777 -pe '
    s/\{\{trans\|.*\}\}//g;
    unless (/\A\+\+\+/) {
        my ($title) = /^# (.*)$/m;
        $title = "Documentation" unless defined $title;
        $title =~ s/"/\\"/g;
        $_ = "+++\ntitle = \"$title\"\n+++\n\n$_";
    }
' {} +
