# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcat.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 17:28:40 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 17:28:43 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; char	*ft_strcat(char *s1, const char *s2)

SECTION	.text
	global _ft_strcat
	extern _ft_strlen

_ft_strcat:
			push	rbp					; Save a copy of old stackframe
			mov		rbp, rsp			; Move stack pointer in rbp
			push	rsi					; Caller-save register
			push	rcx					; Caller-save register
			push	rbx					; Caller-save register
			push	rdi					; Caller-save register
			lea		rbx, [rel rdi]		; Store rdi original address
			call	_ft_strlen			; ft_strlen(rdi)
			push	rax					; Caller-save register
			lea		rdi, [rel rsi]		; Move rsi address in ft_strlen argument
			call	_ft_strlen			; ft_strlen(rsi)
			mov		rcx, rax			; rcx = ft_strlen(rsi)
			lea		rdi, [rel rbx]		; Restore rdi original address
			pop		rax					; Restore caller-save register
			add		rdi, rax			; rdi += ft_strlen(rdi)
			cld							; (Clear Direction Flag, DF = 0) to make the operation left to right
			rep		movsb				; Repeat while rcx > 0 {*rdi = *rsi; ++rdi; ++rsi; --rcx}
			mov		byte [rdi], 0x00	; Append '\0' at the end of rdi register
_return:
			pop		rdi					; Restore caller-save register
			pop		rbx					; Restore caller-save register
			pop		rcx					; Restore caller-save register
			pop		rsi					; Restore caller-save register
			lea		rax, [rel rdi]		; Return rdi original address
			leave						; Mov rsp, rbp and pop rbp
			ret							; Return
