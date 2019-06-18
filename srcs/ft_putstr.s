# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_putstr.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/14 15:56:49 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/14 15:56:50 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; void	ft_putstr(char const *s)

%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define WRITE				4

SECTION	.text
		global _ft_putstr
		extern _ft_strlen

_ft_putstr:
			push	rbp							; Save a copy of old stackframe
			mov		rbp, rsp					; Move stack pointer in rbp
			push	rsi							; Caller-save register
			push	rdx							; Caller-save register
			push	rax							; Caller-save register
			lea		rsi, [rel rdi]				; write(.., rdi, ..)
			call	_ft_strlen					; ft_strlen(rdi)
			mov		rdi, STDOUT					; write(STDOUT, rdi, ..)
			mov		rdx, rax					; write(STDOUT, rdi, rax)
			mov		rax, MACH_SYSCALL(WRITE)	; Store the syscall identifier in rax
			syscall								; Write syscall interruption
_return:
			pop		rax							; Restore caller-save register
			pop		rdx							; Restore caller-save register
			pop		rsi							; Restore caller-save register
			leave								; Mov rsp, rbp and pop rbp
			ret									; Return
