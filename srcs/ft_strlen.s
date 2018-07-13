
SECTION	.text
		global _ft_strlen

_ft_strlen:

	_INIT_:
						push rbp
						mov rbp, rsp
						push rcx					; Save rcx register
						push r8						; Save r8 register
	Loop_statement:
						mov rcx, 0xffffffffffffffff	; Maximum number of bytes
						mov r8, rcx					; Store initial value
						xor al, al					; al = 0x00
						repne scasb					; while (rdi != al && rcx != 0)
	Get_length_diff:
						sub r8, rcx					; r8 = initial_value - rcx
						dec r8						; Substract '\0' char
	Return:
						mov rax, r8					; Store the length in return's register
						pop r8
						pop rcx
						leave
						ret
