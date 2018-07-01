
SECTION .text
		global _ft_memset

_ft_memset:
			lea r8, [rdi]
			cld
			mov al, sil
			mov rcx, rdx
			rep stosb
			mov rax, r8
			ret