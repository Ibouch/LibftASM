# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strdup.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/13 18:26:05 by ibouchla          #+#    #+#              #
#    Updated: 2019/06/13 18:26:07 by ibouchla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; char	*ft_strdup(const char *s1)

SECTION	.text
		global _ft_strdup
		extern _ft_strlen
		extern _malloc
		extern _ft_memcpy

_ft_strdup:
			push	rbp						; Save a copy of old stackframe
			mov		rbp, rsp				; Move stack pointer in rbp
			push	rsi						; Caller-save register
			push	rdx						; Caller-save register
			push	rdi						; Caller-save register
			call	_ft_strlen				; ft_strlen(rdi)
			mov		rdi, rax				; Prepare malloc call's with ft_strlen(rdi) bytes
			inc		rdi						; Add 1 byte allocation for null-terminated string char '/0'
			push	rax						; Push ft_strlen(rdi) + 1 bytes at the top of rsp register
			call	_malloc					; malloc(ft_strlen(rdi))
			test	rax, rax				; if ((malloc(ft_strlen(rdi))) == NULL)
			jz		_NULL					; Then jump to _NULL label
			mov		rdi, rax				; ft_memcpy(malloc(), .., ..)
			mov		rsi, [rsp + 8]			; ft_memcpy(malloc(), rdi, ..)
			mov		rdx, [rsp]				; ft_memcpy(malloc(), rdi, ft_strlen([rsp + 8])))
			call	_ft_memcpy				; ft_memcpy(rdi, rsi, ft_strlen([rsp + 8]))
			mov		rdi, rax				; Store ft_memcpy pointer's return in rdi
			pop		rax						; Restore caller-save register
			mov		byte [rdi + rax], 0x00	; Append '\0' at rdi + ft_strlen(rdi) offset bytes
_return:
			mov		rax, rdi				; Return ft_memcpy pointer's return
			pop		rdi						; Restore caller-save register
			pop		rdx						; Restore caller-save register
			pop		rsi						; Restore caller-save register
			leave							; Mov rsp, rbp and pop rbp
			ret								; Return
_NULL:
			pop		rax						; Restore caller-save register
			mov		rax, 0x00				; Return NULL pointer
			pop		rdi						; Restore caller-save register
			pop		rdx						; Restore caller-save register
			pop		rsi						; Restore caller-save register
			leave							; Mov rsp, rbp and pop rbp
			ret								; Return
