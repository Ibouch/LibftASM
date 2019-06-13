# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_tolower.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 18:07:59 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 18:08:00 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_tolower(int c)

SECTION	.text
	global _ft_tolower

_ft_tolower:
			push	rbp			; Save a copy of old stackframe
			mov		rbp, rsp	; Move stack pointer in rbp
			cmp		rdi, 'A'	; if (rdi < 'A')
			jl		_cnd_fails	; Then jump to _cnd_fails label
			cmp		rdi, 'Z'	; if (rdi > 'Z')
			jg		_cnd_fails	; Then jump to _cnd_fails label
			add		rdi, 0x20	; rdi += 32
			mov		rax, rdi	; return (rdi)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
_cnd_fails:
			mov		rax, rdi	; return (rdi)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
