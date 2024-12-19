CMD = docker-compose
SRC = ./srcs/docker-compose.yml

export VOLUMEPATH="/home/jonhan/data"

all :
	mkdir -p $(VOLUMEPATH)/wordpressDB
	mkdir -p $(VOLUMEPATH)/mariaDB
	$(CMD) -f $(SRC) up -d --build

clean :
	$(CMD) -f $(SRC) down --rmi "all" --volumes

fclean : clean
	sudo rm -rf $(VOLUMEPATH)

re : fclean all

stop :
	$(CMD) -f $(SRC) stop

start :
	$(CMD) -f $(SRC) start

status :
	$(CMD) -f $(SRC) ps