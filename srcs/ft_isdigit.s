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
			cmp rdi, '0'
			jl cnd_fails	; if (c < '0') { cnd_fails(); }
			cmp rdi, '9'
			jg cnd_fails	; if (c > '9') { cnd_fails(); }
			mov rax, 0x1	; return (1);
			ret

cnd_fails:
			mov rax, 0x0	; return (0);
			ret