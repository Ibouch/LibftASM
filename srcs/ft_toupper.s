# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_toupper.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 18:02:46 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 18:02:48 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_toupper(int c)

SECTION	.text
	global _ft_toupper

_ft_toupper:
			push	rbp			; Save a copy of old stackframe
			mov		rbp, rsp	; Move stack pointer in rbp
			cmp		rdi, 'a'	; if (rdi < 'a')
			jl		cnd_fails	; Then jump to _cnd_fails label
			cmp		rdi, 'z'	; if (rdi > 'z')
			jg		cnd_fails	; Then jump to _cnd_fails label
			sub		rdi, 32		; rdi -= 32
			mov		rax, rdi	; return (rdi)
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
cnd_fails:
			mov		rax, rdi	; return (rdi);
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
