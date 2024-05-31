#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int		ft_strlen(const char* s);
char*	ft_strcpy(char* dest, const char* src);
int		ft_strcmp(const char* s1, const char* s2);
int		ft_write(int fd, const char* buff, size_t len);

int	main(int ac, const char** av)
{
	if (ac != 2)
		return (printf("1 argument lul\n"), EXIT_FAILURE);
	printf("Size of: %s => %i\n", av[1], ft_strlen(av[1]));
	char *src = malloc(ft_strlen(av[1]) + 1);
	if (!src)
		return (EXIT_FAILURE);
	src = ft_strcpy(src, av[1]);
	int	ret = ft_write(STDOUT_FILENO, src, 6);
	ft_write(STDOUT_FILENO, "\n", 1);
	int	ret1 = write(STDOUT_FILENO, src, 6);
	ft_write(STDOUT_FILENO, "\n", 1);
	printf("Ret: %i\n", ret);
	printf("Ret: %i\n", ret1);
	printf("Result: %i\n", ft_strcmp(src, av[1]));
	printf("Result: %i\n", strcmp(src, av[1]));
	return (EXIT_SUCCESS);
}
