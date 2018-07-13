
SECTION	.text
		global _ft_strdup
		extern _ft_strlen
		extern _malloc
		extern _ft_memcpy

_ft_strdup:

	_INIT_:
					push rbp
					mov rbp, rsp
					push rbx		; Save rbx register
					push r8			; Save r8 register

	Get_strlen:
					mov rbx, rdi	; Store origanl string
					call _ft_strlen

	Call_malloc:
					mov rdi, rax	; Prepare malloc call of ft_strlen bytes
					mov r8, rax		; Store strlen
					call _malloc
			
	Check_malloc:
					test rax, rax	; Check if the malloc failed
					jz malloc_failed

	Call_memcpy:
					mov rsi, rbx	; Move original in rsi
					mov rdi, rax	; Move pointer returned by malloc in rdi
					mov rdx, r8		; Move strlen in 3nd arg (rdx)
					call _ft_memcpy
	Return:
					pop r8
					pop rbx
					leave
					ret

malloc_failed:
					mov rax, 0x00
					pop r8
					pop rbx
					leave
					ret