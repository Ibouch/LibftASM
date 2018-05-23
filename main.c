
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include "include/libfts.h"

static size_t	ft_udigitlen(uintmax_t c, uint8_t base)
{
	size_t	ret;

	ret = 0;
	if (c == 0)
		return (1);
	while (c > 0)
	{
		c /= base;
		++ret;
	}
	return (ret);
}

static void		print_digit_addr(size_t p, uint8_t base)
{
	const char	*s;

	s = "0123456789abcdef";
	if (p > 0)
	{
		print_digit_addr(p / base, base);
		write(1, &(s[(p % base)]), 1);
	}
}

static void		show_digit_addr(size_t addr, uint8_t base, uint8_t n_char)
{
	size_t	len;
	size_t	addr_len;

	addr_len = ft_udigitlen(addr, base);
	len = (addr_len > n_char) ? 0 : n_char - addr_len;
	len = (addr == 0) ? len + 1 : len;
	while (len--)
		write(1, "0", 1);
	print_digit_addr(addr, base);
}

static void		ft_hexdump(void *ptr, size_t len, uint8_t base)
{
	uint64_t	i;

	i = 0;
	while (i < len)
	{
		if ((i % base) == 0)
		{
			write(1, "\n", 1);
			show_digit_addr((size_t)ptr + i, base, 16);
			write(1, "\t", 1);
		}
		show_digit_addr(*((unsigned char *)((size_t)ptr + i)), base, (base == 16) ? 2 : 3);
		++i;
		(i == len) ? write(1, "\n", 1) : write(1, " ", 1);
	}
}

int				main(int ac, const char **av)
{
	void	*ptr = malloc(14);

	(void)ac;
	(void)av;
	//ft_bzero(ptr, 2048);
	printf("ret isalpha : [%d]\n", ft_isalpha(100));
	printf("ret isdigit : [%d]\n", ft_isdigit(9));
	printf("ret isalnum : [%d]\n", ft_isalnum('['));
	printf("ret toupper : [%d]\n", ft_toupper('A'));
	printf("ret strncpy : [%s]\n", ft_strncpy(ptr, "HELLO WORLD\0", 2));
	//ft_hexdump(ptr, 128, 16);
	return (0);
}
