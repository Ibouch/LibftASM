
SECTION	.text
		global _ft_memcpy

_ft_memcpy:
			cld
			lea r8, [rdi]
			mov rcx, rdx
