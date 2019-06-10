%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define WRITE				4

SECTION	.data
null_str:
		.content db "(null)", 10, 0
		.len equ $ - null_str.content
nl_char:
		.char db 10
		.len equ 0x1

SECTION	.text
		global _ft_puts
		extern _ft_strlen

_ft_puts:
			push rbp						; Save a copy of old stackframe
			mov rbp, rsp					; Move stack pointer in rbp

			push rsi						; Caller-save register
			push rdx						; Caller-save register

			test rdi, rdi					; if (rdi == NULL)
			jz _NULL						; Then jump to _NULL label

			lea rsi, [rel rdi]				; write(.., rdi, ..)
			call _ft_strlen					; ft_strlen(rdi)

			mov	rdi, STDOUT					; write(STDOUT, rdi, ..)
			mov	rdx, rax					; write(STDOUT, rdi, rax)
			mov	rax, MACH_SYSCALL(WRITE)	; Store the syscall identifier in rax
			syscall							; Write syscall interruption

			lea rsi, [rel nl_char.char]		; write(STDOUT, nl_char.char, ..)
			mov rdx, nl_char.len			; write(STDOUT, nl_char.char, nl_char.len)
			mov	rax, MACH_SYSCALL(WRITE)	; Store the syscall identifier in rax
			syscall							; Write syscall interruption
			jmp _return						; Jump to _return label
_NULL:
			mov rdi, STDOUT					; write(STDOUT, .., ..)
			lea rsi, [rel null_str.content]	; write(STDOUT, null_str.content, ..)
			mov rdx, null_str.len			; write(STDOUT, null_str.content, null_str.len)
			mov	rax, MACH_SYSCALL(WRITE)	; Store the syscall identifier in rax
			syscall							; Write syscall interruption
			jmp _return						; Jump to _return label
_return:
			pop rdx							; Restore caller-save register
			pop rsi							; Restore caller-save register
			mov rax, 0x0a					; Return (0x0a)
			leave							; Mov rsp, rbp and pop rbp
			ret								; Return
