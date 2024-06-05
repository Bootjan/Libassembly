section	.text
	global	ft_push_front

ft_push_front:
	xor		rax, rax
	mov		[rdi], rax
	ret

section	.text
	global	ft_list_sort

ft_list_sort:	; void	ft_list_sort(t** head, int (*cmp)());
	mov		rax, [rdi]
	push	rdi
	push	rsi
	mov		rdi, rax

	call	ft_push_front

	pop		rsi
	pop		rdi
	ret

global	.text
