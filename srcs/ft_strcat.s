
SECTION	.text
	global _ft_strcat
	extern _ft_strlen

_ft_strcat:

	_INIT_:
					push rbp
					mov rbp, rsp
					push rbx				; Store rbx register
					push rcx				; Store rcx register
					push r8					; Store r8 register
	Get_offset:
					mov rbx, rdi			; Store original rdi
					call _ft_strlen			; Get rdi length
					mov r8, rax				; Store rdi length in r9 register
					mov rdi, rsi			; Move rsi in ft_strlen argument
					call _ft_strlen			; Get rsi length
					mov rdi, rbx			; Restore original rdi
					add rdi, r8				; Rdi = rdi + ft_strlen(rdi)
					mov rcx, rax			; Rcx = ft_strlen(rsi)
	Loop_statement:
					cld
					rep movsb
	Append_zero:
					mov byte [rdi], 0x00	; Append '\0' to rdi
	Return:
					mov rax, rbx			; Restore original rdi
					pop r8
					pop rcx
					pop rbx
					leave
					ret
