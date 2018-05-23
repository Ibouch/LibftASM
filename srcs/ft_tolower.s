;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_tolower.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/28 17:50:39 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:48:48 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */

;	int	ft_tolower(int c)
;	{
;		return (c >= 'A' && c <= 'Z' ? c + 32 : c);
;	}

SECTION	.text
	global _ft_toupper

_ft_toupper:
			cmp rdi, 'A'
			jl cnd_fails	; if (c < 'A') { cnd_fails(); }
			cmp rdi, 'Z'
			jg cnd_fails	; if (c > 'Z') { cnd_fails(); }
			add rdi, 0x20	; c += 32
			mov rax, rdi	; return (c);
			ret

cnd_fails:
			mov rax, rdi	; return (c);
			ret