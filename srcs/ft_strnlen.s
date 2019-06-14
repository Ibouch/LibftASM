# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strnlen.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/14 13:45:39 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/14 13:45:44 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; size_t	ft_strnlen(const char *s, size_t maxlen);

SECTION	.text
		global _ft_strnlen

_ft_strnlen:
			push	rbp			; Save a copy of old stackframe
			mov		rbp, rsp	; Move stack pointer in rbp
			push	rbx			; Caller-save register
			push	rcx			; Caller-save register
			xor		rcx, rcx	; Set rcx = 0
			lea		rbx, [rdi]	; Store rdi original address in rbx
			cld					; (Clear Direction Flag, DF = 0) to make the operation left to right
_cpy_loop:
			cmp byte [rdi], 0	; if (*rdi == '\0')
			je	_return			; Then jump to _return label
			cmp	rcx, rsi		; if (rcx == rsi)
			je _return			; Then jump to _return label
			inc	rcx				; ++rcx
			inc rdi				; ++rdi
			jmp _cpy_loop		; Unconditional jump to _cpy_loop label
_return:
			sub		rdi, rbx	; Length = (rdi after iteration - original rdi)
			mov		rax, rdi	; Store rdi length in rax
			mov		rdi, rbx	; Restore rdi original address
			pop		rcx			; Restore caller-save register
			pop		rbx			; Restore caller-save register
			leave				; Mov rsp, rbp and pop rbp
			ret					; Return
