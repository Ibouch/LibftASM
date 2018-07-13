%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define WRITE				4

SECTION	.data
nl_char:
		.char db 10
		.len equ 0x01

SECTION	.text
		global _ft_puts
		extern _ft_strlen

_ft_puts:
			push rbp
			mov rbp, rsp

			push rdi
			call _ft_strlen
			pop rdi

			mov	rdx, rax
			mov	rsi, rdi
			mov	rdi, STDOUT
			mov	rax, MACH_SYSCALL(WRITE)	; Call write syscall
			syscall

			mov rsi, nl_char.char
			mov rdx, nl_char.len
			mov	rax, MACH_SYSCALL(WRITE)	; Call write syscall
			syscall
			leave
			ret
