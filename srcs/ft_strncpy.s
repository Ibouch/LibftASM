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
		extern _ft_strnlen

_ft_strncpy:
					push rbp
					mov rbp, rsp
					push rbx
					push rdi
					;
					mov rdi, rsi
					push rsi
					mov rsi, rdx
					call _ft_strnlen
					;
					pop rsi
					pop rdi
					lea rbx, [rdi]
					mov rcx, rax
					;
					cld
					rep movsb
					;
					sub rdx, rax
					cmp rdx, 0x00
					jg fill_null_char
					mov byte [rdi], 0x00
					mov rax, rbx
					pop rbx
					leave
					ret

fill_null_char:
					mov rcx, rdx
					xor al, al
					cld
					rep stosb
					mov rax, r8
					pop rbx
					leave
					ret
