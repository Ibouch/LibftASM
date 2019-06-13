# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_isdigit.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 17:45:12 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 17:45:14 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;	int	ft_isdigit(int c)

SECTION .text
	global _ft_isdigit

_ft_isdigit:
			push	rbp				; Save a copy of old stackframe
			mov		rbp, rsp		; Move stack pointer in rbp
			cmp		rdi, '0'		; if (rdi < '0')
			jl		_cnd_success	; Then jump to _cnd_success label
			cmp		rdi, '9'		; if (rdi > '9')
			jg		_cnd_success	; Then jump to _cnd_success label
			mov		rax, 0x1		; return (1)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
_cnd_success:
			mov		rax, 0x0		; return (0)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
