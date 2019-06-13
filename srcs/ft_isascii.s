# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_isascii.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 17:52:33 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 17:52:35 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_isascii(int c)

SECTION	.text
	global _ft_isascii

_ft_isascii:
			push	rbp			; Save a copy of old stackframe
			mov		rbp, rsp	; Move stack pointer in rbp
			cmp		rdi, 0		; if (rdi < 0)
			jl		_cnd_fails	; Then jump to _cnd_fails label
			cmp		rdi, 127	; if (rdi > 127)
			jg		_cnd_fails	; Then jump to _cnd_fails label
			mov		rax, 0x1	; return (1)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
_cnd_fails:
			mov		rax, 0x0	; return (0)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
