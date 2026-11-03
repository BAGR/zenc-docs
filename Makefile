# Preview the website with this checkout's documentation, at http://localhost:1111/docs/.
#
#   make serve                    WEB defaults to a checkout of the website next to this one
#   make serve WEB=../zenc-web PORT=8080
#
# It copies the website to .preview/, syncs the documentation into it as sync-docs.yml does,
# and syncs it again whenever a file changes. Needs Zola 0.18.0 or Docker.

WEB ?= ../zenc-lang-ce.github.io
PORT ?= 1111

.PHONY: serve clean

serve:
	scripts/preview_site.sh "$(WEB)" "$(PORT)"

clean:
	rm -rf .preview
