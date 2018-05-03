
;	void	ft_bzero(void *s, size_t n)
;	{
;		while (n--)
;			((unsigned char *)s)[n] = 0;
;	}

SECTION		.data
			

SECTION		.text
			global _ft_bzero
			extern printf

_ft_bzero:
			mov ecx, esp		;
			mov edx, [esp + 4]	;
			xor eax, eax		;
_debut:
			inc eax				;
			test eax, 2048		;
;			byte 0
;			jb debut			;
