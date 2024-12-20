DOCKER_COMPOSE := BUILDKIT_PROGRESS=plain docker-compose
DOCKER_COMPOSE_FILES := -f docker-compose.yml
##
# DOCKER
build:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} build $(c)
up:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} up -d $(c)
start:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} start $(c)
down:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} down $(c)
destroy:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} down -v $(c)
stop:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} stop $(c)
restart:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} stop $(c)
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} up -d $(c)
logs:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} logs --tail=100 -f $(c)
ps:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} ps

##
# API
api-logs:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} logs --tail=100 -f api
api-shell:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api /bin/ash
api-restart:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api touch tmp/restart.txt
api-console:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api bundle exec rails c
api-rubocop:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api bundle exec rubocop
api-rspec:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api bundle exec rspec
api-audit:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api bundle audit
api-swaggerize:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec api bundle exec rake rswag:specs:swaggerize

##
# FRONT
front-lintjs:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front yarn lint:js
front-linthbs:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front yarn lint:hbs
front-testember:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front yarn test:ember
front-test:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front yarn test
front-shell:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front ash
front-build:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec front yarn build
front-logs:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} logs --tail=100 -f front

##
# POSTGRES
postgres-shell:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_FILES} exec postgres psql -Upostgres
