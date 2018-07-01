
;	void	ft_bzero(void *s, size_t n)
;	{
;		while (n--)
;			((unsigned char *)s)[n] = 0;
;	}

SECTION		.text
			global _ft_bzero
			extern _ft_memset

_ft_bzero:
			push rbp
			mov rbp, rsp
			mov rdx, rsi
			xor rsi, rsi	; 2nd arg = 0
			call _ft_memset
			leave
			ret
