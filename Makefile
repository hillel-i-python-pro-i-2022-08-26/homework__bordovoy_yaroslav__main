.PHONY: homework-i-run
# Run homework
homework-i-run:
	@python organize_output/organize_output__groups_and_humans.py

.PHONY: homework-i-purge
homework-i-purge:
	@echo The end

.PHONY: init-dev
init-dev:
	@pip install --upgrade pip && \
	pip install --requirement requirements.txt && \
	pre-commit install

.PHONY: pre-commit-run
# Run tools for files from commit.
pre-commit-run:
	@pre-commit run

.PHONY: pre-commit-run-all
# Run tools for all files.
pre-commit-run-all:
	@pre-commit run --all-files

.PHONY: d-homework-i-run
# Make all actions needed for run homework (docker).
d-homework-i-run:
	@make d-run

.PHONY: d-homework-i-purge
# Make all actions needed for purge homework related data.
d-homework-i-purge:
	@make d-purge

.PHONY: d-run
# Run docker
d-run:
	@COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
		docker-compose \
			up --build

.PHONY: d-purge
# Purge all data related with services
d-purge:
	@COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
		docker-compose \
			down --volumes --remove-orphans --rmi local --timeout 0