; ******************************************************************************
;                                                                              *
;                                                         :::      ::::::::    *
;    hello.s                                            :+:      :+:    :+:    *
;                                                     +:+ +:+         +:+      *
;    By: ibouchla <marvin@42.fr>                    +#+  +:+       +#+         *
;                                                 +#+#+#+#+#+   +#+            *
;    Created: 2018/04/22 16:09:14 by ibouchla          #+#    #+#              *
;    Updated: 2018/04/22 16:09:20 by ibouchla         ###   ########.fr        *
;                                                                              *
; ******************************************************************************

%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define WRITE				4

section .data
string:
	.content db "Hello World!", 10
	.len equ $ - string.content

section .text		; Code segment
	global start
	global _main

start:
	call _main
	ret

_main:
	mov	rax, MACH_SYSCALL(WRITE)	; Call write syscall
	mov	rdi, STDOUT
	mov	rsi, string.content
	mov	rdx, string.len
	syscall
	ret