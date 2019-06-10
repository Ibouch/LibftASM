;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_isdigit.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/25 16:47:42 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:40:12 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */

;	int	ft_isdigit(int c)
;	{
;		return (c >= '0' && c <= '9');
;	}

SECTION .text
	global _ft_isdigit

_ft_isdigit:
				push rbp		; Save a copy of old stackframe
				mov rbp, rsp	; Move stack pointer in rbp

				cmp rdi, '0'	; if (rdi < '0')
				jl _cnd_fails	; Then jump to _cnd_fails label
				cmp rdi, '9'	; if (rdi > '9')
				jg _cnd_fails	; Then jump to _cnd_fails label

				mov rax, 0x1	; return (1)
				leave			; Mov rsp, rbp and pop rbp
				ret				; Return

_cnd_fails:
				mov rax, 0x0	; return (0)
				leave			; Mov rsp, rbp and pop rbp
				ret				; Return
