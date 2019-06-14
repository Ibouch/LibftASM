# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strncpy.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/14 13:36:17 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/14 13:36:18 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; char	*ft_strncpy(char *dest, const char *src, size_t n)

SECTION	.text
		global _ft_strncpy

_ft_strncpy:
			push	rbp					; Save a copy of old stackframe
			mov		rbp, rsp			; Move stack pointer in rbp
			push	rbx					; Caller-save register
			lea		rbx, [rdi]			; Store rdi original address in rbx
			mov		rcx, rdx			; Store the maximum number of iterations
			cld							; (Clear Direction Flag, DF = 0) to make the operation left to right
_cpy_loop:
			cmp		byte [rsi], 0x00	; if (*rsi == '\0')
			je		_fill_zero			; Then jump to _fill_zero label
			cmp		rcx, 0x00			; if (rcx == 0)
			je		_return				; Then jump to _return label
			movsb						; {*rdi = *rsi; ++rdi; ++rsi; --rcx}
			dec		rcx					; --rcx
			jmp		_cpy_loop			; Unconditional jump to _cpy_loop label
_fill_zero:
			xor		al, al				; Set al = 0x00
			rep		stosb				; Repeat while rcx > 0 {*rdi = al; ++rdi; --rcx}
_return:
			mov		rax, rbx			; Restore rdi original address
			pop		rbx					; Restore caller-save register
			leave						; Mov rsp, rbp and pop rbp
			ret							; Return
