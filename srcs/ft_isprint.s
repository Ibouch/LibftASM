;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_isprint.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/25 16:47:42 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:40:12 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */

;	int	ft_isprint(int c)
;	{
;		return (c >= 32 && c <= 126);
;	}

SECTION	.text
	global _ft_isprint

_ft_isprint:
				push rbp		; Save a copy of old stackframe
				mov rbp, rsp	; Move stack pointer in rbp

				cmp rdi, 32		; if (rdi < 32)
				jl _cnd_fails	; Then jump to _cnd_fails label
				cmp rdi, 126	; if (rdi > 126)
				jg _cnd_fails	; Then jump to _cnd_fails label

				mov rax, 0x1	; return (1)
				leave			; Mov rsp, rbp and pop rbp
				ret				; Return

_cnd_fails:
				mov rax, 0x0	; return (0)
				leave			; Mov rsp, rbp and pop rbp
				ret				; Return
