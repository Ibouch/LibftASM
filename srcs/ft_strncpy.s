; ****************************************************************************
;                                                                            *
;                                                        :::      ::::::::   *
;   ft_strncpy.c                                       :+:      :+:    :+:   *
;                                                    +:+ +:+         +:+     *
;   By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        *
;                                                +#+#+#+#+#+   +#+           *
;   Created: 2015/11/25 13:41:26 by ibouchla          #+#    #+#             *
;   Updated: 2016/02/03 19:47:38 by ibouchla         ###   ########.fr       *
;                                                                            *
; ****************************************************************************

;	char	*ft_strncpy(char *dest, const char *src, size_t n)
;	{
;		size_t	i;
;
;		i = 0;
;		while ((i < n) && (src[i] != '\0'))
;		{
;			dest[i] = src[i];
;			i++;
;		}
;		while (i < n)
;			dest[i++] = '\0';
;		return (dest);
;	}

SECTION	.text
		global _ft_strncpy

_ft_strncpy:
			push	rbp
			mov		rbp, rsp

			push	r15
			lea		r15, [rdi]
			mov		rcx, rdx
			cld
_cpy_loop:
			cmp		byte [rsi], 0x00
			je		_fill_zero
			cmp		rcx, 0x00
			je		_return
			movsb
			dec		rcx
			jmp		_cpy_loop
_fill_zero:
			xor		al, al
			rep		stosb			; Repeat while rcx > 0 {*rdi = al; ++rdi; --rcx}
_return:
			mov		rax, r15
			pop		r15
			leave
			ret