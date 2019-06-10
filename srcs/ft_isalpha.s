;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_isalpha.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/25 16:47:42 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:40:12 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */

;	int	ft_isalpha(int c)
;	{
;		return ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'));
;	}

SECTION .text
	global _ft_isalpha

_ft_isalpha:
				push rbp			; Save a copy of old stackframe
				mov rbp, rsp		; Move stack pointer in rbp

				cmp rdi, 'A'		; if (rdi < 'A')
				jl _second_cnd		; Then jump to _second_cnd label
				cmp rdi, 'Z'		; if (rdi > 'Z')
				jg _second_cnd		; Then jump to _second_cnd label
				jmp _cnd_success	; Else jump to _cnd_success label
_second_cnd:
				cmp rdi, 'a'		; if (rdi < 'a')
				jl _cnd_fails		; Then jump to _cnd_fails label
				cmp rdi, 'z'		; if (rdi > 'z')
				jg _cnd_fails		; Then jump to _cnd_fails label
				jmp _cnd_success	; Else jump to _cnd_success label
_cnd_fails:
				mov rax, 0x0		; return (0)
				leave				; Mov rsp, rbp and pop rbp
				ret					; Return
_cnd_success:
				mov rax, 0x1		; return (1)
				leave				; Mov rsp, rbp and pop rbp
				ret					; Return
