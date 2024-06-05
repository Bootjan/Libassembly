#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <stddef.h>
#include <errno.h>

typedef struct list_s {
	void*			data;
	struct list_s*	next;
}	list_t;

size_t		ft_strlen(const char* s);
char*		ft_strcpy(char* dest, const char* src);
int			ft_strcmp(const char* s1, const char* s2);
char*		ft_strdup(const char* str);
int			ft_write(int fd, const void* buff, size_t count);
int			ft_read(int fd, void* buf, size_t count);
int			ft_list_size(list_t* begin_list);
void		ft_list_push_front(list_t** begin_list, void* data);
void		ft_list_sort(list_t** begin_list, int (*cmp)());
void		ft_list_remove_if(list_t **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

bool	test_str_ft_strlen(const char* str)
{
	return (ft_strlen(str) == strlen(str));
}

void	test_ft_strlen()
{
	printf("\n\n");
	if (!test_str_ft_strlen("hallo"))
		printf("Ft_strlen failed\n");
	if (!test_str_ft_strlen("h"))
		printf("Ft_strlen failed\n");
	if (!test_str_ft_strlen(""))
		printf("Ft_strlen failed\n");
}

bool	test_str_strcmp(const char* str1, const char* str2)
{
	int	ret_ft = ft_strcmp(str1, str2);
	int	ret_std = strcmp(str1, str2);

	printf("Ret_fd: %i,\tRet_std: %i\n", ret_ft, ret_std);
	if (ret_ft < 0 && ret_std < 0)
		return true;
	if (ret_ft > 0 && ret_std > 0)
		return true;
	if (ret_ft == 0 && ret_std == 0)
		return true;
	return false;
}

void	test_strcmp()
{
	printf("\n\n");
	if (!test_str_strcmp("h", ""))
		printf("Ft_strcmp failed1\n");
	if (!test_str_strcmp("h", "h"))
		printf("Ft_strcmp failed2\n");
	if (!test_str_strcmp("", ""))
		printf("Ft_strcmp failed3\n");
	if (!test_str_strcmp("as", "ds"))
		printf("Ft_strcmp failed4\n");
	if (!test_str_strcmp("hallo", "hallo"))
		printf("Ft_strcmp failed5\n");
	if (!test_str_strcmp("hallo123", "hallo124"))
		printf("Ft_strcmp failed6\n");
}

bool	test_strcpy_str(const char* src)
{
	char*	dest = malloc(strlen(src) + 1);
	if (!dest)
		return (false);
	
	ft_strcpy(dest, src);
	bool	ret = strcmp(dest, src) == 0 && dest[strlen(src)] == '\0';
	free(dest);
	return (ret);
}

void	test_strcpy()
{
	printf("\n\n");
	if (!test_strcpy_str(""))
		printf("Ft_strcpy failed1\n");
	if (!test_strcpy_str("a"))
		printf("Ft_strcpy failed2\n");
	if (!test_strcpy_str("as"))
		printf("Ft_strcpy failed3\n");
	if (!test_strcpy_str("dsa"))
		printf("Ft_strcpy failed4\n");
	if (!test_strcpy_str("dsafdsgreafdjwferwjfbrew"))
		printf("Ft_strcpy failed5\n");
}

bool	test_strdup_str(const char* src)
{
	char*	dest = ft_strdup(src);
	if (!dest)
		return (printf("Malloc in ft_strdup failed\n"), false);
	
	if (strcmp(dest, src) != 0)
		printf("Strings don't match: %s != %s\n", dest, src);
	if (dest[strlen(src)] != '\0')
		printf("String not terminated\n");
	bool	ret = (strcmp(dest, src) == 0 && dest[strlen(src)] == '\0');
	free(dest);
	return ret;
}

void	test_strdup()
{
	printf("\n\n");
	if (!test_strdup_str(""))
		printf("Ft_strdup failed1\n");
	if (!test_strdup_str("a"))
		printf("Ft_strdup failed2\n");
	if (!test_strdup_str("as"))
		printf("Ft_strdup failed3\n");
	if (!test_strdup_str("dsa"))
		printf("Ft_strdup failed4\n");
	if (!test_strdup_str("dsafdsgreafdjwferwjfbrew"))
		printf("Ft_strdup failed5\n");
}

void	test_write()
{
	printf("\n\n");
	if (ft_write(STDOUT_FILENO, "hallo\n", 6) != 6)
		printf("Write failed1\n");
	if (ft_write(STDOUT_FILENO, "hallo\n", 1) != 1)
		printf("Write failed3\n");
	if (ft_write(-1, "hallo", 1) == -1)
	{
		printf("Write failed3 successfully\n");
		perror("Error");
	}
	if (ft_write(STDOUT_FILENO, NULL, 1) == -1)
	{
		printf("Write failed4 successfully\n");
		perror("Error");
	}
}

void	test_read()
{
	printf("\n\n");
	char*	buff = malloc(500);
	if (!buff)
		return;
	int	r = 0;
	if ((r = ft_read(STDIN_FILENO, buff, 50)) == -1)
		printf("Read failed1\n");
	buff[r] = '\0';
	printf("Result: %s\n", buff);
	if (ft_read(-1, buff, 50) == -1)
	{
		printf("Read failed successfully2\n");
		perror("Error");
	}
	if (ft_read(STDIN_FILENO, NULL, 50) == -1)
	{
		printf("Read failed successfully3\n");
		perror("Error");
	}
	free(buff);
}

void	test_push_front()
{
	list_t*	head = NULL;

	int	a, b, c;
	a = 1;
	ft_list_push_front(&head, &a);
	printf("a: %i\n\n", *(int *)(head->data));
	if (ft_list_size(head) != 1)
		printf("List_size failed1\n");
	b = 69;
	ft_list_push_front(&head, &b);
	printf("b: %i\n", *(int *)(head->data));
	printf("a: %i\n\n", *(int *)(head->next->data));
	c = 42;
	ft_list_push_front(&head, &c);
	printf("c: %i\n", *(int *)(head->data));
	printf("b: %i\n", *(int *)(head->next->data));
	printf("a: %i\n\n", *(int *)(head->next->next->data));
	if (ft_list_size(head) != 3)
		printf("List_size failed1\n");
	list_t*	next = NULL;
	while (head)
	{
		next = head->next;
		free(head);
		head = next;
	}
}

void	test_list_size()
{
	printf("\n\n");
	if (ft_list_size(NULL) != 0)
		printf("List_size failed1\n");
}

void	print_list(list_t* head)
{
	for (int i = 0; head; i++)
	{
		printf("%i:\t%i\n", i, *(int *)(head->data));
		head = head->next;
	}
}

int	int_cmp(void* x, void* y)
{
	int	a = *(int *)x;
	int	b = *(int *)y;
	return (a == b ? 0 : 1);
}

void	int_free(void* x)
{
	(void)x;
}

void	free_list(list_t* head)
{
	list_t*	next = NULL;

	while (head)
	{
		next = head->next;
		free(head);
		head = next;
	}
}

void	test_list_remove_if()
{
	int	a, b, c, d, e;

	a = 5;
	b = 1;
	c = 9;
	d = 5;
	e = 0;
	list_t*	head = NULL;
	ft_list_push_front(&head, &b);
	ft_list_push_front(&head, &c);
	ft_list_push_front(&head, &d);
	ft_list_push_front(&head, &e);
	ft_list_push_front(&head, &a);

	print_list(head);

	printf("\n\n");
	int	f = 5;
	// printf("%p\t%p\t%p\t%p\n", &head, head, &a, &f);
	ft_list_remove_if(&head, &f, &int_cmp, &int_free);

	print_list(head);

	free_list(head);
}

void	test_list_sort()
{
	int	a, b, c, d, e;

	a = 5;
	b = 1;
	c = 9;
	d = 5;
	e = 0;
	list_t*	head = NULL;
	ft_list_push_front(&head, &b);
	ft_list_push_front(&head, &c);
	ft_list_push_front(&head, &d);
	ft_list_push_front(&head, &e);
	ft_list_push_front(&head, &a);

	print_list(head);

	printf("\n\n");
	ft_list_sort(&head, &int_cmp);

	print_list(head);

	free_list(head);
}

int	main(void)
{
	// test_strcmp();
	// test_ft_strlen();
	// test_strcpy();
	// test_strdup();
	// test_write();
	// test_read();
	// test_list_size();
	// test_push_front();
	// test_list_sort(); Not working just yet
	return (EXIT_SUCCESS);
}
