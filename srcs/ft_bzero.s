
;	void	ft_bzero(void *s, size_t n)
;	{
;		while (n--)
;			((unsigned char *)s)[n] = 0;
;	}

SECTION		.text
			global _ft_bzero
			extern _ft_memset

_ft_bzero:

	_INIT_:
					push rbp
					mov rbp, rsp
					push rdx
					push rsi
	Memset_zero:
					mov rdx, rsi
					xor rsi, rsi
					call _ft_memset
	Return:
					pop rsi
					pop rdx
					leave
					ret
