SRCS_DIR = srcs
SRCS = $(wildcard $(SRCS_DIR)/*.s)

OBJS_DIR = objs
OBJS = $(SRCS:$(SRCS_DIR)/%.s=$(OBJS_DIR)/%.o)

NASM = nasm
NASM_FLAGS = -felf64

NAME = libasm.a

RM = rm -rf

CC = gcc
CFLAGS = -pie -Wall -Wextra -Werror -Wpedantic -g

MAIN = main.c
OUTPUT = output 
LIB = -L. -lasm

all: $(NAME)
.PHONY: all

$(OBJS_DIR):
	mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS_DIR) $(OBJS)
	ar rcs $(NAME) $(OBJS)
	ranlib $(NAME)

$(OBJS_DIR)/%.o:	$(SRCS_DIR)/%.s
	$(NASM) $(NASM_FLAGS) $< -o $@

clean:
	$(RM) $(OBJS)
.PHONY: clean

fclean: clean cclean
	$(RM) $(OBJS_DIR)
	$(RM) $(NAME)
	
.PHONY: fclean

re: fclean all
.PHONY: re

main: all
	$(CC) $(CFLAGS) -c main.c -o $(OBJS_DIR)/main.o
	$(CC) -o $(OUTPUT) $(OBJS_DIR)/main.o $(LIB)
.PHONY: main

cclean:
	$(RM) $(OBJS_DIR)/main.o
	$(RM) output
.PHONY: cclean

remain:	re main
.PHONY: remain
