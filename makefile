
bin:=$(shell yarn bin)
meta:=$(bin)/meta

$(meta):
	yarn
	
.PHONY: install
install: $(meta)
	@$(meta) git update

.PHONY: update
update: $(meta)
	@$(meta) exec "git status --porcelain && if git diff --quiet; then set -x && git remote update --prune && git merge --ff-only @{u}; fi"
