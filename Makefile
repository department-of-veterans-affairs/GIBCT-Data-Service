$stdout.sync = true
COMPOSE_DEV  := docker-compose
COMPOSE_TEST := docker-compose -f docker-compose.test.yml
BASH         := run --rm gibct bash --login
BASH_DEV     := $(COMPOSE_DEV) $(BASH) -c
BASH_TEST    := $(COMPOSE_TEST) $(BASH) -c

.PHONY: default
default: ci

.PHONY: bash
bash:
	@$(COMPOSE_DEV) $(BASH)

.PHONY: ci
ci:
	@$(BASH_TEST) "bundle exec rails yarn:install"
	@$(BASH_TEST) "bundle exec rails webpacker:install"
	@$(BASH_TEST) "bundle exec rails webpacker:install:react"
	@$(BASH_TEST) "bundle exec rails generate react:install"
	@$(BASH_TEST) "bundle exec rails webpacker:info"
	@$(BASH_TEST) "bundle exec rails webpacker:verify_install"
# 	@$(BASH_TEST) "PATH=/usr/local/bundle/bin:/srv/root/.nvm/versions/node/v10.17.0/bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin bin/rails assets:precompile"
	@$(BASH_TEST) "bundle exec rails db:setup db:migrate"
# 	@$(BASH_TEST) "PATH=/usr/local/bundle/bin:/srv/root/.nvm/versions/node/v10.17.0/bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin bin/rails assets:precompile"
	@$(BASH_TEST) "bundle exec rails ci"

.PHONY: console
console:
	@$(BASH_DEV) "bundle exec rails c"

.PHONY: db
db:
	@$(BASH_DEV) "bin/rails db:setup db:migrate"

.PHONY: guard
guard: db
	@$(BASH_DEV) "bundle exec guard"

.PHONY: lint
lint: db
	@$(BASH_DEV) "bin/rails lint"

.PHONY: security
security: db
	@$(BASH_DEV) "bin/rails security"

.PHONY: spec
spec: db
	@$(BASH_TEST) "bin/rails spec"

.PHONY: up
up: db
	@$(COMPOSE_DEV) up

.PHONY: rebuild
rebuild:
	@$(COMPOSE_DEV) down
	@$(COMPOSE_DEV) build

.PHONY: clean
clean:
	rm -r data || true
	$(COMPOSE_TEST) run gibct rm -r coverage log/* tmp || true
	$(COMPOSE_TEST) down
