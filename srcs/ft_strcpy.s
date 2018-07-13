
SECTION	.text
		global _ft_strcpy
		extern _ft_memcpy
		extern _ft_strlen

_ft_strcpy:
			push rbp
			mov rbp, rsp
			push rdx
			push rdi

			mov rdi, rsi
			call _ft_strlen
			pop rdi
			
			mov rdx, rax
			call _ft_memcpy
			pop rdx

			leave
			ret