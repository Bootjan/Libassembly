section	.text
	global	ft_list_push_front
	static	ft_create_element
	extern	malloc,@function

ft_create_element:
	push	rdi

	mov		rdi, 16
	call	malloc

	cmp		rax, 0
	je		return_element

	pop		rdi
	mov		[rax], rdi
	xor		rdi, rdi
	xor		[rax + 8], rdi

	return_element:
		ret

ft_list_push_front:
	push	rdi
	mov		rdi, rsi
	call	ft_create_element

	cmp		rax, 0
	je		return

	pop		rdi
	mov		rsi, [rdi]
	mov		[rax + 8], rsi
	mov		[rdi], rax

	return:
		ret
