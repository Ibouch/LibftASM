
SECTION .text
		global _ft_memset

_ft_memset:
			push rbp
			mov rbp, rsp
			push rdi
			cld
			mov al, sil
			mov rcx, rdx
			rep stosb
			pop rdi
			mov rax, rdi
			leave
			ret