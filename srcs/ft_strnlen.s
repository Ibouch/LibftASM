
SECTION	.text
		global _ft_strnlen

_ft_strnlen:
			cld
			lea r8, [rdi]
			mov rcx, rsi
			xor al, al
			repne scasb
			sub rdi, r8
			cmp rcx, 0x00
			jg sub_null_char
			mov rax, rdi
			ret

sub_null_char:
			dec rdi
			mov rax, rdi
			ret
