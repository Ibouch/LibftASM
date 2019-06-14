#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "include/libfts.h"
#include <fcntl.h>
#include <ctype.h>
#include <stdbool.h>

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

static void		show_header(char *name)
{
	printf("\n************************\n");
	printf("**** ft_%s ****\n", name);
	printf("************************\n");
}

static void		show_result(uint8_t test)
{
	fflush(stdout);
	printf("\n==== Result ==== : %s\033[0m\n", (test ? "\033[1;92mOK" : "\033[1;91mKO"));
}

/*
**	Part 1 - Fonctions simples de la libc
*/

void	test_bzero(void)
{
	size_t	size = 64;
	size_t	s2 = size / 2;
	void	*p1 = malloc(size);

	show_header("bzero");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> bzero(%p, %zu)\n", p1, size);
	memset(p1, 0x42, size);
	bzero(p1, size);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> bzero(%p, %zu)\n", p1, size);
	memset(p1, 0x42, size);
	bzero(p1, size);
	ft_hexdump(p1, size, 16);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> bzero(%p, %zu)\n", p1, s2);
	memset(p1, 0x42, size);
	bzero(p1, s2);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> bzero(%p, %zu)\n", p1, s2);
	memset(p1, 0x42, size);
	bzero(p1, s2);
	ft_hexdump(p1, size, 16);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> bzero(%p, %d)\n", p1, 0);
	memset(p1, 0x42, size);
	bzero(p1, (0));
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> bzero(%p, %d)\n", p1, 0);
	memset(p1, 0x42, size);
	bzero(p1, (0));
	ft_hexdump(p1, size, 16);

	free((void *)p1);
}

void	test_strcat(void)
{
	size_t	l1 = 12;
	size_t	l2 = (100 * 2) + 1;
	char	*s1 = "Hello";
	char	*s2 = "World";
	char	*s3 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c";
	char	*p = (char *)malloc(l1);
	char	*p2 = (char *)malloc(l2);

	show_header("strcat");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strcat(%s, %s)\n", s1, s2);
	bzero(p, l1);
	char *r1 = strdup(ft_strcat(ft_strcat(ft_strcat(p, s1), " "), s2));
	ft_hexdump(p, l1, 16);
	printf("\n---- Unix function ----\n==> strcat(%s, %s)\n", s1, s2);
	bzero(p, l1);
	char *r2 = strdup(strcat(strcat(strcat(p, s1), " "), s2));
	ft_hexdump(p, l1, 16);
	show_result(((strcmp(r1, r2)) == 0));

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strcat(\"Hello World\", \"\")\n");
	bzero(p, l1);
	char *r5 = strdup(ft_strcat(r2, ""));
	ft_hexdump(r5, l1, 16);
	printf("\n---- Unix function ----\n==> strcat(\"Hello World\", \"\")\n");
	bzero(p, l1);
	char *r6 = strdup(strcat(r2, ""));
	ft_hexdump(r6, l1, 16);
	show_result(((strcmp(r5, r6)) == 0));

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strcat(ascii.printable, ascii.printable)\n");
	bzero(p2, l2);
	char *r3 = strdup(ft_strcat(ft_strcat(p2, s3), s3));
	ft_hexdump(p2, l2, 16);
	printf("\n---- Unix function ----\n==> strcat(ascii.printable, ascii.printable)\n");
	bzero(p2, l2);
	char *r4 = strdup(strcat(strcat(p2, s3), s3));
	ft_hexdump(p2, l2, 16);
	show_result(((strcmp(r3, r4)) == 0));

	free((void *)p);
	free((void *)p2);
}

void	test_isalpha(void)
{
	int	valid = true;

	show_header("isalpha");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_isalpha(i) != isalpha(i))
			valid = false;
	}
	show_result(valid);
}

void	test_isdigit(void)
{
	int	valid = true;

	show_header("isdigit");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_isdigit(i) != isdigit(i))
			valid = false;
	}
	show_result(valid);
}

void	test_isalnum(void)
{
	int	valid = true;

	show_header("isalnum");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_isalnum(i) != isalnum(i))
			valid = false;
	}
	show_result(valid);
}

void	test_isascii(void)
{
	int	valid = true;

	show_header("isascii");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_isascii(i) != isascii(i))
			valid = false;
	}
	show_result(valid);
}

void	test_isprint(void)
{
	int	valid = true;

	show_header("isprint");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_isprint(i) != isprint(i))
			valid = false;
	}
	show_result(valid);
}

void	test_toupper(void)
{
	int	valid = true;

	show_header("toupper");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_toupper(i) != toupper(i))
			valid = false;
	}
	show_result(valid);
}

void	test_tolower(void)
{
	int	valid = true;

	show_header("tolower");

	for (uint16_t i = 0; i < 256; i++)
	{
		if (ft_tolower(i) != tolower(i))
			valid = false;
	}
	show_result(valid);
}

void	test_puts(void)
{
	char	*s1 = strdup("Hello World");
	char	*s2 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");

	show_header("puts");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_puts(\"Hello World\")\n");
	int r1 = ft_puts(s1);
	printf("\n---- Unix function ----\n==> puts(\"Hello World\")\n");
	int r2 = puts(s1);
	show_result(r1 == r2);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_puts(long text..)\n");
	int r3 = ft_puts(s2);
	printf("\n---- Unix function ----\n==> puts(long text..)\n");
	int r4 = puts(s2);
	show_result(r3 == r4);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_puts(ascii.printable)\n");
	int r5 = ft_puts(s3);
	printf("\n---- Unix function ----\n==> puts(ascii.printable)\n");
	int r6 = puts(s3);
	show_result(r5 == r6);

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_puts(NULL)\n");
	int r7 = ft_puts(NULL);
	printf("\n---- Unix function ----\n==> puts(NULL)\n");
	int r8 = puts(NULL);
	show_result(r7 == r8);

	/* Start test [05] */
	printf("\nStart Test [05] :\n");
	printf("\n---- My function ----\n==> ft_puts(\"\")\n");
	int r9 = ft_puts("");
	printf("---- Unix function ----\n==> puts(\"\")\n");
	int r10 = puts("");
	show_result(r9 == r10);

	free((void *)s1);
	free((void *)s2);
	free((void *)s3);
}

/*
**	Part 2 - Fonctions simples mais un peu moins de la libc
*/

void	test_strlen(void)
{
	char	*s1 = "";
	char	*s2 = strdup("Hello World\0\nDo you catch this ?..");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");
	char	*s4 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");

	show_header("strlen");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strlen(\"\"))\n");
	size_t r1 = ft_strlen(s1);
	printf("\n---- Unix function ----\n==> strlen(\"\"))\n");
	size_t r2 = strlen(s1);
	show_result(r1 == r2);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strlen(\"%s\"))\n", s2);
	size_t r3 = ft_strlen(s2);
	printf("\n---- Unix function ----\n==> strlen(\"%s\"))\n", s2);
	size_t r4 = strlen(s2);
	show_result(r3 == r4);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strlen(ascii.printable))\n");
	size_t r5 = ft_strlen(s3);
	printf("\n---- Unix function ----\n==> strlen(ascii.printable))\n");
	size_t r6 = strlen(s3);
	show_result(r5 == r6);

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_strlen(long text..))\n");
	size_t r7 = ft_strlen(s4);
	printf("\n---- Unix function ----\n==> strlen(long text..))\n");
	size_t r8 = strlen(s4);
	show_result(r7 == r8);

	free((void *)s2);
	free((void *)s3);
	free((void *)s4);
}

void	test_memset(void)
{
	size_t	size = 64;
	void	*p1 = malloc(size);
	void	*p2 = malloc(size);

	show_header("memset");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_memset(%p, %x, %zu)\n", p1, 0x42, size);
	ft_memset(p1, 0x42, size);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memset(%p, %x, %zu)\n", p2, 0x42, size);
	memset(p2, 0x42, size);
	ft_hexdump(p2, size, 16);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_memset(%p, %x, %zu)\n", p1, 0x00, size / 2);
	ft_memset(p1, 0x00, size / 2);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memset(%p, %x, %zu)\n", p2, 0x00, size / 2);
	memset(p2, 0x00, size / 2);
	ft_hexdump(p2, size, 16);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_memset(%p, %x, %zu)\n", (p1 + (size / 2)), 0xff, size / 2);
	ft_memset(p1 + (size / 2), 0xff, size / 2);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memset(%p, %x, %zu)\n", (p2 + (size / 2)), 0xff, size / 2);
	memset(p2 + (size / 2), 0xff, size / 2);
	ft_hexdump(p2, size, 16);

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_memset(%p, %x, %d)\n", p1, 0xff, 0);
	ft_memset(p1, 0xff, 0);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memset(%p, %x, %d)\n", p2, 0xff, 0);
	memset(p2, 0xff, (0));
	ft_hexdump(p2, size, 16);

	free(p1);
	free(p2);
}

void	test_memcpy(void)
{
	size_t	size = 64;
	void	*p1 = calloc(1, size);
	void	*p2 = calloc(1, size);
	char	*s1 = strdup("Hello World\0\nDo you catch this ?..");

	show_header("memcpy");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_memcpy(%p, %s, %zu)\n", p1, s1, strlen(s1));
	p1 = ft_memcpy(p1, s1, strlen(s1));
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memcpy(%p, %s, %zu)\n", p2, s1, strlen(s1));
	memcpy(p2, s1, strlen(s1));
	ft_hexdump(p2, size, 16);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_memcpy(%p, %s, %zu)\n", p1 + 53, s1, strlen(s1));
	ft_memcpy(p1 + 53 , p1, strlen(s1));
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memcpy(%p, %s, %zu)\n", p2 + 53, s1, strlen(s1));
	memcpy(p2 + 53, p2, strlen(s1));
	ft_hexdump(p2, size, 16);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_memcpy(%p, %s, %d)\n", p1 + 48, s1, 5);
	ft_memcpy(p1 + 48 , p1, 5);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memcpy(%p, %s, %d)\n", p2 + 48, s1, 5);
	memcpy(p2 + 48, p2, 5);
	ft_hexdump(p2, size, 16);

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_memcpy(%p, %s, %d)\n", p1 + 16, s1, 0);
	ft_memcpy(p1 + 16 , p1, 0);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memcpy(%p, %s, %d)\n", p2 + 16, s1, 0);
	memcpy(p2 + 16, p2, 0);
	ft_hexdump(p2, size, 16);

	/* Start test [05] */
	printf("\nStart Test [05] :\n");
	printf("\n---- My function ----\n==> ft_memcpy(%s, %s, %d)\n", NULL, NULL, 4096);
	ft_memcpy(NULL , NULL, 4096);
	ft_hexdump(p1, size, 16);
	printf("\n---- Unix function ----\n==> memcpy(%s, %s, %d)\n", NULL, NULL, 4096);
	memcpy(NULL, NULL, 4096);
	ft_hexdump(p2, size, 16);

	free(p1);
	free(p2);
	free((void *)s1);
}

void	test_strdup(void)
{
	char	*s1 = "";
	char	*s2 = strdup("Hello World\0\nDo you catch this ?..");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");
	char	*s4 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");

	show_header("strdup");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strdup(\"%s\")\n", s1);
	char *r1 = ft_strdup(s1);
	ft_hexdump(r1, strlen(s1), 16);
	printf("\n---- Unix function ----\n==> strdup(\"%s\")\n", s1);
	ft_hexdump(s1, strlen(s1), 16);
	show_result(((strcmp(s1, r1)) == 0));

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strdup(\"%s\")\n", s2);
	char *r2 = ft_strdup(s2);
	ft_hexdump(r2, strlen(s2), 16);
	printf("\n---- Unix function ----\n==> strdup(\"%s\")\n", s2);
	ft_hexdump(s2, strlen(s2), 16);
	show_result(((strcmp(s2, r2)) == 0));

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strdup(ascii.printable)\n");
	char *r3 = ft_strdup(s3);
	ft_hexdump(r3, strlen(s3), 16);
	printf("\n---- Unix function ----\n==> strdup(ascii.printable)\n");
	ft_hexdump(s3, strlen(s3), 16);
	show_result(((strcmp(s3, r3)) == 0));

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_strdup(long text..)\n");
	char *r4 = ft_strdup(s4);
	//ft_hexdump(r4, strlen(s4), 16);
	printf("\n---- Unix function ----\n==> strdup(long text..)\n");
	//ft_hexdump(s4, strlen(s4), 16);
	show_result(((strcmp(s4, r4)) == 0));

	free((void *)s2);
	free((void *)s3);
	free((void *)s4);
	free((void *)r1);
	free((void *)r2);
	free((void *)r3);
	free((void *)r4);
}

/*
**	 Part 3 - Cat
*/

void	test_cat(void)
{
	show_header("cat");

	int fd = open("./main.c", O_RDONLY);
	if (fd != -1)
	{
		ft_cat(fd);
		close(fd);
	}
}

/*
**	 Part Bonus
*/

void	test_strcpy(void)
{
	char	*s1 = "";
	char	*s2 = strdup("Hello World\0\nDo you catch this ?..");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");
	char	*s4 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");
	char	*d1 = calloc(1, 1024);
	char	*d2 = calloc(1, 1024);
	char	*d3 = calloc(1, 1024);
	char	*d4 = calloc(1, 1024);
	char	*d1_bis = calloc(1, 1024);
	char	*d2_bis = calloc(1, 1024);
	char	*d3_bis = calloc(1, 1024);
	char	*d4_bis = calloc(1, 1024);

	show_header("strcpy");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strcpy(%p, \"\"))\n", d1);
	char *r1 = ft_strcpy(d1, s1);
	ft_hexdump((void *)r1, 16, 16);
	printf("\n---- Unix function ----\n==>  strcpy(%p, \"\"))\n", d1_bis);
	char *r2 = strcpy(d1_bis, s1);
	ft_hexdump((void *)r2, 16, 16);
	show_result(((strcmp(r1, r2)) == 0));

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strcpy(%p, \"%s\"))\n", d2, s2);
	char *r3 = ft_strcpy(d2, s2);
	ft_hexdump((void *)r3, strlen(s2), 16);
	printf("\n---- Unix function ----\n==>  strcpy(%p, \"%s\"))\n", d2_bis, s2);
	char *r4 = strcpy(d2_bis, s2);
	ft_hexdump((void *)r4, strlen(s2), 16);
	show_result(((strcmp(r3, r4)) == 0));

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strcpy(%p, ascii.printable))\n", d3);
	char *r5 = ft_strcpy(d3, s3);
	ft_hexdump((void *)r5, strlen(s3), 16);
	printf("\n---- Unix function ----\n==>  strcpy(%p, ascii.printable))\n", d3_bis);
	char *r6 = strcpy(d3_bis, s3);
	ft_hexdump((void *)r6, strlen(s3), 16);
	show_result(((strcmp(r5, r6)) == 0));

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_strcpy(%p, long text..))\n", d4);
	char *r7 = ft_strcpy(d4, s4);
	ft_hexdump((void *)r7, strlen(s4), 16);
	printf("\n---- Unix function ----\n==>  strcpy(%p, long text..))\n", d4_bis);
	char *r8 = strcpy(d4_bis, s4);
	ft_hexdump((void *)r8, strlen(s4), 16);
	show_result(((strcmp(r7, r8)) == 0));
}

void	test_strncpy(void)
{
	char	*s1 = "";
	char	*s2 = strdup("Hello World\0\nDo you catch this ?..");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");
	char	*s4 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");
	char	*d1 = calloc(1, 1024);
	char	*d2 = calloc(1, 1024);
	char	*d3 = calloc(1, 1024);
	char	*d4 = calloc(1, 1024);
	char	*d1_bis = calloc(1, 1024);
	char	*d2_bis = calloc(1, 1024);
	char	*d3_bis = calloc(1, 1024);
	char	*d4_bis = calloc(1, 1024);

	show_header("strcpy");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strncpy(%p, \"\", 42))\n", d1);
	char *r1 = ft_strncpy(d1, s1, 42);
	ft_hexdump((void *)r1, 16, 16);
	printf("\n---- Unix function ----\n==>  strncpy(%p, \"\", 42))\n", d1_bis);
	char *r2 = strncpy(d1_bis, s1, 42);
	ft_hexdump((void *)r2, 16, 16);
	show_result(((strcmp(r1, r2)) == 0));

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strncpy(%p, \"%s\", strlen(s2)))\n", d2, s2);
	char *r3 = ft_strncpy(d2, s2, strlen(s2));
	ft_hexdump((void *)r3, strlen(s2), 16);
	printf("\n---- Unix function ----\n==>  strncpy(%p, \"%s\", strlen(s2)))\n", d2_bis, s2);
	char *r4 = strncpy(d2_bis, s2, strlen(s2));
	ft_hexdump((void *)r4, strlen(s2), 16);
	show_result(((strcmp(r3, r4)) == 0));

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strncpy(%p, ascii.printable, 10))\n", d3);
	char *r5 = ft_strncpy(d3, s3, 10);
	ft_hexdump((void *)r5, strlen(s3), 16);
	printf("\n---- Unix function ----\n==>  strncpy(%p, ascii.printable, 10))\n", d3_bis);
	char *r6 = strncpy(d3_bis, s3, 10);
	ft_hexdump((void *)r6, strlen(s3), 16);
	show_result(((strcmp(r5, r6)) == 0));

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_strncpy(%p, long text.., 4096))\n", d4);
	char *r7 = ft_strncpy(d4, s4, 4096);
	ft_hexdump((void *)r7, strlen(s4), 16);
	printf("\n---- Unix function ----\n==>  strncpy(%p, long text.., 4096))\n", d4_bis);
	char *r8 = strncpy(d4_bis, s4, 4096);
	ft_hexdump((void *)r8, strlen(s4), 16);
	show_result(((strcmp(r7, r8)) == 0));
}

void	test_strnlen(void)
{
	char	*s1 = "";
	char	*s2 = strdup("Hello World\0\nDo you catch this ?..");
	char	*s3 = strdup("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c");
	char	*s4 = strdup("In reasonable compliment favourable is connection dispatched in terminated. Do esteem object we called father excuse remove. So dear real on like more it. Laughing for two families addition expenses surprise the. If sincerity he to curiosity arranging. Learn taken terms be as. Scarcely mrs produced too removing new old. Affronting discretion as do is announcing. Now months esteem oppose nearer enable too six. She numerous unlocked you perceive speedily. Affixed offence spirits or ye of offices between. Real on shot it were four an as. Absolute bachelor rendered six nay you juvenile. Vanity entire an chatty to. Is post each that just leaf no. He connection interested so we an sympathize advantages. To said is it shed want do. Occasional middletons everything so to. Have spot part for his quit may. Enable it is square my an regard. Often merit stuff first oh up hills as he. Servants contempt as although addition dashwood is procured. Interest in yourself an do of numerous feelings cheerful confined. Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. And sir dare view but over man. So at within mr to simple assure. Mr disposing continued it offending arranging in we. Extremity as if breakfast agreement. Off now mistress provided out horrible opinions. Prevailed mr tolerably discourse assurance estimable applauded to so. Him everything melancholy uncommonly but solicitude inhabiting projection off. Connection stimulated estimating excellence an to impression. Dispatched entreaties boisterous say why stimulated. Certain forbade picture now prevent carried she get see sitting. Up twenty limits as months. Inhabit so perhaps of in to certain. Sex excuse chatty was seemed warmth. Nay add far few immediate sweetness earnestly dejection. Inhabit hearing perhaps on ye do no. It maids decay as there he. Smallest on suitable disposed do although blessing he juvenile in. Society or if excited forbade. Here name off yet she long sold easy whom. Differed oh cheerful procured pleasure securing suitable in. Hold rich on an he oh fine. Chapter ability shyness article welcome be do on service. Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition. Another journey chamber way yet females man. Way extensive and dejection get delivered deficient sincerity gentleman age. Too end instrument possession contrasted motionless. Calling offence six joy feeling. Coming merits and was talent enough far. Sir joy northward sportsmen education. Discovery incommode earnestly no he commanded if. Put still any about manor heard. Led ask possible mistress relation elegance eat likewise debating. By message or am nothing amongst chiefly address. The its enable direct men depend highly. Ham windows sixteen who inquiry fortune demands. Is be upon sang fond must shew. Really boy law county she unable her sister. Feet you off its like like six. Among sex are leave law built now. In built table in an rapid blush. Merits behind on afraid or warmly.");

	show_header("strnlen");

	/* Start test [01] */
	printf("\nStart Test [01] :\n");
	printf("\n---- My function ----\n==> ft_strnlen(\"\", 42))\n");
	size_t r1 = ft_strnlen(s1, 42);
	printf("\n---- Unix function ----\n==> strnlen(\"\", 42))\n");
	size_t r2 = strnlen(s1, 42);
	show_result(r1 == r2);

	/* Start test [02] */
	printf("\nStart Test [02] :\n");
	printf("\n---- My function ----\n==> ft_strnlen(\"%s\", 0))\n", s2);
	size_t r3 = ft_strnlen(s2, 0);
	printf("\n---- Unix function ----\n==> strnlen(\"%s\", 0))\n", s2);
	size_t r4 = strnlen(s2, 0);
	show_result(r3 == r4);

	/* Start test [03] */
	printf("\nStart Test [03] :\n");
	printf("\n---- My function ----\n==> ft_strnlen(ascii.printable, strlen(s3)))\n");
	size_t r5 = ft_strnlen(s3, strlen(s3));
	printf("\n---- Unix function ----\n==> strnlen(ascii.printable, strlen(s3)))\n");
	size_t r6 = strnlen(s3, strlen(s3));
	show_result(r5 == r6);

	/* Start test [04] */
	printf("\nStart Test [04] :\n");
	printf("\n---- My function ----\n==> ft_strnlen(long text.., -1))\n");
	size_t r7 = ft_strnlen(s4, -1);
	printf("\n---- Unix function ----\n==> strnlen(long text.., -1))\n");
	size_t r8 = strnlen(s4, -1);
	show_result(r7 == r8);

	free((void *)s2);
	free((void *)s3);
	free((void *)s4);
}

/*
**	 Main tests
*/

int		main(void)
{
/*
**	Part 1 - Fonctions simples de la libc
*/
	//test_bzero();
	//test_strcat();
	//test_isalpha();
	//test_isdigit();
	//test_isalnum();
	//test_isascii();
	//test_isprint();
	//test_toupper();
	//test_tolower();
	//test_puts();
/*
**	Part 2 - Fonctions simples mais un peu moins de la libc
*/
	//test_strlen();
	//test_memset();
	//test_memcpy();
	//test_strdup();
/*
**	 Part 3 - Cat
*/
	//test_cat();
/*
**	Part Bonus
*/
	test_strcpy();
	test_strncpy();
	test_strnlen();
	return (0);
}
