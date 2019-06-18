# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_isspace.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/17 13:08:33 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/17 13:08:36 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; int	ft_isspace(int c);

SECTION .text
	global _ft_isspace

_ft_isspace:
			push	rbp				; Save a copy of old stackframe
			mov		rbp, rsp		; Move stack pointer in rbp
			cmp		rdi, 32			; if (rdi == 32)
			je		_cnd_success	; Then jump to _cnd_success label
			cmp		rdi, 13			; if (rdi <= 13)
			jle		_second_cnd		; Then jump to _second_cnd label
			jmp		_cnd_fails		; Unconditional jump to _cnd_fails label
_second_cnd:
			cmp		rdi, 9			; if (rdi >= 9)
			jge		_cnd_success	; Then jump to _cnd_success label
			jmp		_cnd_fails		; Unconditional jump to _cnd_fails label
_cnd_fails:
			mov		rax, 0x0		; return (0)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
_cnd_success:
			mov		rax, 0x1		; return (1)
			leave					; Mov rsp, rbp and pop rbp
			ret						; Return
