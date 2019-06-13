# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_memset.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 18:20:35 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 18:20:39 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; void	*ft_memset(void *b, int c, size_t len)

SECTION .text
		global _ft_memset

_ft_memset:
			push	rbp				; Save a copy of old stackframe
			mov		rbp, rsp		; Move stack pointer in rbp
			push	rax				; Caller-save register
			push	rdi				; Caller-save register
			push	rcx				; Caller-save register
			mov		al, sil			; Move rsi lower 8 bits in rax lower 8 bits
			mov		rcx, rdx		; Store the number of iterations
			cld						; (Clear Direction Flag, DF = 0) to make the operation left to right
			rep		stosb			; Repeat while rcx > 0 {*rdi = al; ++rdi; --rcx}
_return:
			pop		rcx				; Restore caller-save register
			pop		rdi				; Restore caller-save register
			pop		rax				; Restore caller-save register
			lea		rax, [rel rdi]	; Store rdi original address in rax
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
