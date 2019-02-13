.PHONY: serve deploy test shellcheck

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

deploy: ## Deploy to GitHub Pages
	@$(CURDIR)/deploy.sh

serve: ## Serve a local development copy
	docker run --rm -i $(DOCKER_FLAGS) \
    	--net host \
		-v $(CURDIR):/site \
		-p 1313:1313 \
    	--workdir /site \
    	--name hugo-website-serve \
    	"westonsteimel/hugo" serve -D

test: shellcheck serve

shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
        --name website-shellcheck \
        -v $(CURDIR):/usr/src:ro \
        --workdir "/usr/src" \
        "westonsteimel/shellcheck:alpine" ./shellcheck.sh
