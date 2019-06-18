# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/12/17 12:21:30 by ibouchla          #+#    #+#              #
#    Updated: 2016/04/14 22:29:55 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libfts.a

INC_PATH = -I include

SRC_PATH = srcs

SRC_NAME =	ft_bzero.s \
			ft_strcat.s \
			ft_isalpha.s \
			ft_isdigit.s \
			ft_isalnum.s \
			ft_isascii.s \
			ft_isprint.s \
			ft_toupper.s \
			ft_tolower.s \
			ft_puts.s \
			ft_strlen.s \
			ft_memset.s \
			ft_memcpy.s \
			ft_strdup.s \
			ft_cat.s \
			ft_strcpy.s \
			ft_strncpy.s \
			ft_strnlen.s \
			ft_putstr.s \
			ft_isspace.s

CREATE_LIB = ar rc $(NAME) $(OBJET)

ID_LIB = ranlib $(NAME)

CC_FLAGS = nasm -f macho64

SRC = $(addprefix $(SRC_PATH)/,$(SRC_NAME))

OBJET = $(SRC:.s=.o)

RED = \033[1;31m

BLUE = \033[1;34m

GREEN = \033[0;32m

YELLOW = \033[1;33m

all: $(NAME)

$(NAME): $(OBJET)
	@echo "$(BLUE)Compilation of object files in libft directory is complete.\n"
	@echo "$(YELLOW)Creation of the library in progress.."
	@$(CREATE_LIB)
	@echo "$(BLUE)Creation of the library is complete.\n"
	@echo "$(YELLOW)Indexing of the library in process.."
	@$(ID_LIB)
	@echo "$(BLUE)Indexing of the library is complete.\n"

%.o: %.s
	@$(CC_FLAGS) $< $(INC_PATH) -o $@
	@echo "\033[1;32mCompilation of object file from the library source file : $(GREEN)Success"
clean:
	@echo "\n$(RED)Deleting object files of the library"
	@$(RM) $(OBJET)

fclean: clean
	@echo "$(RED)Remove the library\n"
	@$(RM) $(NAME)

re: fclean all
