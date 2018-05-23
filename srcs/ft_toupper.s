;	************************************************************************** */
;	                                                                           */
;	                                                       :::      ::::::::   */
;	  ft_toupper.s                                       :+:      :+:    :+:   */
;	                                                   +:+ +:+         +:+     */
;	  By: ibouchla <ibouchla@student.42.fr>          +#+  +:+       +#+        */
;	                                               +#+#+#+#+#+   +#+           */
;	  Created: 2015/11/28 17:50:39 by ibouchla          #+#    #+#             */
;	  Updated: 2016/02/03 19:48:48 by ibouchla         ###   ########.fr       */
;	                                                                           */
;	************************************************************************** */

;	int	ft_toupper(int c)
;	{
;		return (c >= 'a' && c <= 'z' ? c - 32 : c);
;	}

SECTION	.text
	global _ft_toupper

_ft_toupper:
			cmp rdi, 'a'
			jl cnd_fails	; if (c < 'a') { cnd_fails(); }
			cmp rdi, 'z'
			jg cnd_fails	; if (c > 'z') { cnd_fails(); }
			sub rdi, 0x20	; c -= 32
			mov rax, rdi	; return (c);
			ret

cnd_fails:
			mov rax, rdi	; return (c);
			ret