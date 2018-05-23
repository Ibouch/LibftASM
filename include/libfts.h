#ifndef LIBFTS_H
# define LIBFTS_H

#include <string.h>

void	ft_bzero(void *s, size_t n);
char	*ft_strcat(char *s1, const char *s2);
int		ft_isalpha(int c);
int		ft_isdigit(int c);
int		ft_isalnum(int c);
int		ft_isascii(int c);
int		ft_isprint(int c);
char	*ft_strncpy(char * dst, const char * src, size_t len);

#endif