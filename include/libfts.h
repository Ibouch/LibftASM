#ifndef LIBFTS_H
# define LIBFTS_H

#include <string.h>

int		ft_tolower(int c);
int		ft_toupper(int c);
void	ft_bzero(void *s, size_t n);
char	*ft_strcat(char *s1, const char *s2);
int		ft_isalpha(int c);
int		ft_isdigit(int c);
int		ft_isalnum(int c);
int		ft_isascii(int c);
int		ft_isprint(int c);
char	*ft_strncpy(char * dst, const char * src, size_t len);
char	*ft_strcpy(char * dst, const char * src);
size_t  ft_strlen(const char *s);
size_t	ft_strnlen(const char *s, size_t maxlen);
void	*ft_memset(void *b, int c, size_t len);
void	*ft_memcpy(void *restrict dst, const void *restrict src, size_t n);
int		ft_puts(const char *s);
char	*ft_strdup(const char *s1);
void	ft_cat(int fd);

#endif
