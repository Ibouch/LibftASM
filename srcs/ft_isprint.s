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
			cmp rdi, 0x20
			jl cnd_fails	; if (c < 32) { cnd_fails() }
			cmp rdi, 0x7e
			jg cnd_fails	; if (c > 126) { cnd_fails() }
			mov rax, 0x1	; return (1);
			ret

cnd_fails:
			mov rax, 0x0	; return (0);
			ret