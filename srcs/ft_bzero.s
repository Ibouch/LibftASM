
;	void	ft_bzero(void *s, size_t n)
;	{
;		while (n--)
;			((unsigned char *)s)[n] = 0;
;	}

SECTION		.text
			global _ft_bzero
			extern _ft_memset

_ft_bzero:
			push rbp		; Save a copy of old stackframe
			mov rbp, rsp	; Move stack pointer in rbp
 
			push rsi		; Caller-save register
			push rdx		; Caller-save register

			mov rdx, rsi	; Move caller-function rsi in rdx
			xor rsi, rsi	; Set rsi = 0
			call _ft_memset	; Call ft_memset(rdi, 0, rdx)
_return:
			pop rdx			; Restore caller-save register
			pop rsi			; Restore caller-save register
			leave			; Mov rsp, rbp and pop rbp
			ret				; Return
