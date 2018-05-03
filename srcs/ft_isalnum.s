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
			call _ft_isalpha
			cmp rax, 0x1
			je cnd_success		; if (ft_isalpha(c) != 1) { cnd_success(); }
			call _ft_isdigit
			cmp rax, 0x1
			je cnd_success		; if (ft_isdigit(c) != 1) { cnd_success(); }
			mov rax, 0x0		; return (0);
			ret

cnd_success:
			mov rax, 0x1		; return (1);
			ret