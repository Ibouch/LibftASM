;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_isalnum.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/25 16:47:42 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:40:12 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */


;	int	ft_isalnum(int c)
;	{
;		return (ft_isalpha(c) == 1 || ft_isdigit(c) == 1);
;	}

SECTION	.text
	global _ft_isalnum
	extern _ft_isalpha
	extern _ft_isdigit

_ft_isalnum:
				push rbp			; Save a copy of old stackframe
				mov rbp, rsp		; Move stack pointer in rbp

				call _ft_isalpha	; ft_isalpha(rdi)
				cmp rax, 0x1		; if (ft_isalpha(rdi) == 1)
				je _cnd_success		; Then jump to _cnd_success label
				call _ft_isdigit	; ft_isdigit(rdi)
				cmp rax, 0x1		; if (ft_isdigit(rdi) == 1)
				je _cnd_success		; Then jump to _cnd_success label

				mov rax, 0x0		; return (0)
				leave				; Mov rsp, rbp and pop rbp
				ret					; Return
_cnd_success:
				mov rax, 0x1		; return (1)
				leave				; Mov rsp, rbp and pop rbp
				ret					; Return
