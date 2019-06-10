
%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define READ				3
%define WRITE				4
%define B_SIZE				2048

SECTION	.bss
buffer:	resb	B_SIZE								; reserve 2048 bytes

SECTION	.text
				global _ft_cat
				extern _ft_bzero

_ft_cat:
				push	rbp							; Save a copy of old stackframe
				mov 	rbp, rsp					; Move stack pointer in rbp
				push	rsi							; Caller-save register
				push	rdx							; Caller-save register
				push	rax							; Caller-save register
				push	r8							; Caller-save register
				mov		r8, rdi						; Store file descriptor in r8 register
_read_fd_loop:
				lea		rdi, [rel buffer]			; ft_bzero(&buffer, ..)
				mov		rsi, B_SIZE					; ft_bzero(&buffer, B_SIZE)
				call	_ft_bzero					; Call ft_bzero with rdi, rsi

				mov		rdi, r8						; read(fd, .., ..)
				lea		rsi, [rel buffer]			; read(fd, &buffer, ..)
				mov		rdx, B_SIZE					; read(fd, &buffer, B_SIZE)
				mov		rax, MACH_SYSCALL(READ)		; Store the syscall identifier in rax
				syscall								; Read syscall interruption
				cmp		rax, 0x00					; if (!(rax > 0))
				jng		_read_EOF					; Then jump to _read_EOF label
_write_buffer:
				mov		rdi, STDOUT					; write(STDOUT, &buffer, ..)
				mov 	rdx, rax					; write(STDOUT, &buffer, rax)
				mov 	rax, MACH_SYSCALL(WRITE)	; Store the syscall identifier in rax
				syscall								; Write syscall interruption
				jmp		_read_fd_loop				; Jump to _ead_fd_loop label
_read_EOF:
				pop		r8							; Restore caller-save register
				pop		rax							; Restore caller-save register
				pop		rdx							; Restore caller-save register
				pop		rsi							; Restore caller-save register
				leave								; Mov rsp, rbp and pop rbp
				ret									; Return
