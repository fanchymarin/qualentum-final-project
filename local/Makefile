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
	@printf "  ${GREEN}${BOLD}clean   ${CYAN}- Remove the web Docker image and all build cache\n\n"
	@printf "  ${GREEN}${BOLD}fclean  ${CYAN}- Remove the web Docker image, all build cache and the database volume\n"
	@printf "  ${GREEN}${BOLD}re      ${CYAN}- Rebuild the environment\n"
	@echo

up:
	docker-compose --project-name=${PROJECT_NAME} up -d
	docker-compose --project-name=${PROJECT_NAME} exec web pytest

down:
	docker-compose --project-name=${PROJECT_NAME} down

clean: down
	docker rmi -f ${PROJECT_NAME}-web
	docker builder prune -f

fclean: clean
	docker volume rm -f ${PROJECT_NAME}_db-data

re: fclean up

.PHONY: all list up down clean fclean re