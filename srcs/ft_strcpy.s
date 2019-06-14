# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcpy.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/14 13:03:11 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/14 13:03:14 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; char	*ft_strcpy(char * dst, const char * src)

SECTION	.text
		global _ft_strcpy
		extern _ft_strlen

_ft_strcpy:
			push	rbp					; Save a copy of old stackframe
			mov		rbp, rsp			; Move stack pointer in rbp
			push	rcx					; Caller-save register
			push	rdi					; Caller-save register
			lea		rdi, [rsi]			; ft_strlen(rsi)
			call	_ft_strlen			; Call ft_strlen with rsi
			pop		rdi					; Restore caller-save register
			mov		rcx, rax			; Store ft_strlen(rsi) bytes to rcx
			cld							; (Clear Direction Flag, DF = 0) to make the operation left to right
			rep		movsb				; Repeat while rcx > 0 {*rdi = *rsi; ++rdi; ++rsi; --rcx}
			mov		byte [rdi], 0x00	; Append '\0' at the end of rdi
			sub		rdi, rax			; rdi address = (iteration offset - original address)
_return:
			mov		rax, rdi			; Return rdi original address
			pop		rcx					; Restore caller-save register
			leave						; Mov rsp, rbp and pop rbp
			ret							; Return
