section	.text
	global	ft_list_size

ft_list_size:
	xor	rax, rax			; len = 0

	startLoop:
		cmp	rdi, 0			; check for null pointer
		je	return
	
		mov	rdi, [rdi + 8]	; current = current->next
		inc	rax				; len++
		jmp	startLoop		

	return:
		ret
