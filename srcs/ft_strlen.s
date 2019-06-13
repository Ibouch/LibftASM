# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 18:17:55 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 18:17:57 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; size_t	ft_strlen(const char *s)

SECTION	.text
		global _ft_strlen

_ft_strlen:
			push	rbp				; Save a copy of old stackframe
			mov		rbp, rsp		; Move stack pointer in rbp
			push	rbx				; Caller-save register
			push	rcx				; Caller-save register
			lea		rbx, [rel rdi]	; Store rdi original address in rbx
			mov		rcx, -0x1		; Maximum number of bytes
			xor		al, al			; Set al = 0x00
			cld						; (Clear Direction Flag, DF = 0) to make the operation left to right
			repne	scasb			; Repeat while rdi != al && rcx > 0 {++rdi; --rcx}
			sub		rdi, rbx		; Length = (rdi after iteration - original rdi)
			dec		rdi				; Substract '\0' terminating char
_return:
			mov		rax, rdi		; Store rdi length in rax
			lea		rdi, [rel rbx]	; Restore rdi original address
			pop		rcx				; Restore caller-save register
			pop		rbx				; Restore caller-save register
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
