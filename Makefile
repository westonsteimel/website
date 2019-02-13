.PHONY: serve deploy

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

deploy: ## Deploy to GitHub Pages
	@$(CURDIR)/deploy.sh

serve: ## Serve a local development copy
	hugo serve -D
