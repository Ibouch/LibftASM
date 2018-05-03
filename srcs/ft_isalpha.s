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
					cmp rdi, 65
					jl second_cnd	; if (c < 'A') { second_cnd(); }
					cmp rdi, 90
					jg second_cnd	; if (c > 'Z') { second_cnd(); }
					mov rax, 0x1	; return (1);
					ret

second_cnd:
					cmp rdi, 97
					jl cnd_fails	; if (c < 'a') { cnd_fails(); }
					cmp rdi, 122
					jg cnd_fails	; if (c > 'z') { cnd_fails(); }
					mov rax, 0x1	; return (1);
					ret

cnd_fails:
					mov rax, 0x0	; return (0);
					ret