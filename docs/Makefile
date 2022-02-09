help:
	@echo "make css-watch - Watch and build CSS file(Tailwind CSS)"
	@echo "make css-build - Build CSS file(Tailwind CSS)"
	@echo "make site-build - Build the NanoC site"
	@echo "make site-build-prod - Build the NanoC site and CSS"
	@echo "make site-view - Serve the site"

css-watch:
	npx tailwindcss -i ./layouts/input.css -o ./content/stylesheet.css --watch

css-build:
	npx tailwindcss -i ./layouts/input.css -o ./content/stylesheet.css

site-build:
	bundle exec nanoc

site-build-prod: css-build
	bundle exec nanoc

site-view:
	bundle exec nanoc view -L
