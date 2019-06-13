# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_isalnum.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 17:37:46 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 17:37:49 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_isalnum(int c)

SECTION	.text
	global _ft_isalnum
	extern _ft_isalpha
	extern _ft_isdigit

_ft_isalnum:
			push	rbp				; Save a copy of old stackframe
			mov		rbp, rsp		; Move stack pointer in rbp
			call	_ft_isalpha		; ft_isalpha(rdi)
			cmp		rax, 0x1		; if (ft_isalpha(rdi) == 1)
			je		_cnd_success	; Then jump to _cnd_success label
			call	_ft_isdigit		; ft_isdigit(rdi)
			cmp		rax, 0x1		; if (ft_isdigit(rdi) == 1)
			je		_cnd_success	; Then jump to _cnd_success label
			mov		rax, 0x0		; return (0)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
_cnd_success:
			mov		rax, 0x1		; return (1)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
