
%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define READ				3
%define WRITE				4
%define BUFF_SIZE			2048

SECTION	.bss
buffer:	resb	BUFF_SIZE						; reserve 2048 bytes

SECTION	.text
				global _ft_cat
				extern _ft_bzero

_ft_cat:
				push	rbp
				mov		rbp, rsp
				push	r8						; Save r8 register
				mov		r8, rdi
				jmp		read_fd_loop

read_fd_loop:
				mov		rdi, buffer
				mov		rsi, BUFF_SIZE
				call	_ft_bzero				; Fill buffer memory with 0

				mov		rdi, r8
				mov		rax, MACH_SYSCALL(READ)
				mov		rsi, buffer
				mov		rdx, BUFF_SIZE
				syscall							; Invoke operating system to do the read

				cmp		rax, 0x00
				jng		eof_label				; If read returns value is less or equal to 0
				jmp		write_buffer

write_buffer:
				mov 	rdx, rax				; Write N bytes that have been read
				mov 	rax, MACH_SYSCALL(WRITE)
				mov		rdi, STDOUT
				mov 	rsi, buffer
				syscall							; Invoke operating system to do the write
				jmp		read_fd_loop

eof_label:
				pop		r8
				leave
				ret