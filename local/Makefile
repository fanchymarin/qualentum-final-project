GREEN = \033[0;32m
CYAN = \033[0;36m
BLUE = \033[0;34m
BOLD = \033[1m
RESET = \033[0m

PROJECT_NAME = local

all: list

list:
	@echo
	@printf "${BLUE}${BOLD}Available recipes:\n"
	@printf "  ${GREEN}${BOLD}up      ${CYAN}- Build and run the environment using Docker Compose\n"
	@printf "  ${GREEN}${BOLD}down    ${CYAN}- Stop the environment\n"
	@printf "  ${GREEN}${BOLD}test    ${CYAN}- Run the tests\n"
	@printf "  ${GREEN}${BOLD}clean   ${CYAN}- Remove the database volume\n"
	@printf "  ${GREEN}${BOLD}fclean  ${CYAN}- Remove the database volume and all used images\n"
	@printf "  ${GREEN}${BOLD}re      ${CYAN}- Rebuild the environment (clean + up)\n"
	@echo

up:
	docker compose --project-name=${PROJECT_NAME} up -d --build

down:
	docker compose --project-name=${PROJECT_NAME} down

test:
	docker compose --project-name=${PROJECT_NAME} --profile test up -d --wait
	-docker compose --project-name=${PROJECT_NAME} exec web pytest --cov=app
	docker compose rm -s -f -v db-test

clean: down
	docker volume rm -f ${PROJECT_NAME}_db-data

fclean: clean
	docker rmi -f postgres:17.2 fanchymarin/qualentum-web:latest

re: clean up

.PHONY: all list up down test clean fclean re