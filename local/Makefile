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
	@printf "  ${GREEN}${BOLD}up      ${CYAN}- Build, run and test the environment using Docker Compose\n"
	@printf "  ${GREEN}${BOLD}down    ${CYAN}- Stop the environment\n"
	@printf "  ${GREEN}${BOLD}clean   ${CYAN}- Remove the the database volume\n"
	@printf "  ${GREEN}${BOLD}fclean  ${CYAN}- Remove the the database volume, the web Docker image and all build cache and \n"
	@printf "  ${GREEN}${BOLD}re      ${CYAN}- Rebuild the environment\n"
	@echo

up:
	docker compose --project-name=${PROJECT_NAME} up -d
	docker compose --project-name=${PROJECT_NAME} exec web pytest --cov=app

down:
	docker compose --project-name=${PROJECT_NAME} down

clean: down
	docker volume rm -f ${PROJECT_NAME}_db-data

fclean: clean
	docker rmi -f ${PROJECT_NAME}-web
	docker builder prune -f

re: clean up

.PHONY: all list up down clean fclean re