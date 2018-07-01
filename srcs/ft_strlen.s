

SECTION	.text
		global _ft_strlen

_ft_strlen:
			lea r8, [rdi]
			xor al, al
			repne scasb
			sub rdi, r8
			;cmp rdi, 0x00
			;jg sub_null_terminated_string
			;xor rax, rax
			sub rdi, 0x01
			mov rax, rdi
			ret

;sub_null_terminated_string:
;							sub rdi, 0x01
;							mov rax, rdi
;							ret
; SEGFAULT ON NULL RDI