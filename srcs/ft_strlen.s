

SECTION	.text
	global _ft_strlen

_ft_strlen:
			cld
			mov rcx, 42
		;	mov rdi, 
			;mov rdi, 1,
			;mov rsi, msg
		;	mov rdx, 1
			; start = ptr
			; while (*ptr != 0)
			;	++ptr
			; return (ptr - start)