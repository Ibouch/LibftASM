
SECTION	.text
		global _ft_memcpy

_ft_memcpy:
				push	rbp				; Save a copy of old stackframe
				mov		rbp, rsp		; Move stack pointer in rbp

				test	rdi, rdi		; if (dst != NULL)
				jnz		_cnd_success	; Then jump to _cnd_success label
				test	rsi, rsi		; if (src != NULL)
				jnz		_cnd_success	; Then jump to _cnd_success label
_NULL:
				mov		rax, rdi		; Returns the original value of dst
				leave					; Mov rsp, rbp and pop rbp
				ret						; Return
_cnd_success:
				push	rbx				; Caller-save register
				push	rcx				; Caller-save register
				lea		rbx, [rel rdi]	; Store rdi original address in rbx
				mov		rcx, rdx		; Store the number of iterations
				cld						; (Clear Direction Flag, DF = 0) to make the operation left to right
				rep		movsb			; Repeat while rcx > 0 {*rdi = *rsi; ++rdi; ++rsi; --rcx}
_return:
				mov		rax, rbx		; Return rdi original address
				pop		rcx				; Restore caller-save register
				pop		rbx				; Restore caller-save register
				leave					; Mov rsp, rbp and pop rbp
				ret						; Return