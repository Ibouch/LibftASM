# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_isprint.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 17:59:10 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 17:59:11 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_isprint(int c)

SECTION	.text
	global _ft_isprint

_ft_isprint:
			push	rbp			; Save a copy of old stackframe
			mov		rbp, rsp	; Move stack pointer in rbp
			cmp		rdi, 32		; if (rdi < 32)
			jl		_cnd_fails	; Then jump to _cnd_fails label
			cmp		rdi, 126	; if (rdi > 126)
			jg		_cnd_fails	; Then jump to _cnd_fails label
			mov		rax, 0x1	; return (1)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
_cnd_fails:
			mov		rax, 0x0	; return (0)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
