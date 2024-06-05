section .text
	global ft_strcmp

ft_strcmp:
	xor	rax, rax
	xor	rcx, rcx

	startLoop:
		mov	al, BYTE [rdi]
		mov	cl, BYTE [rsi]

		cmp	al, 0
		je	return

		cmp	al, cl
		jne	return

		xor	al, al
		xor	cl, cl
		inc	rdi
		inc	rsi
		jmp	startLoop	

	return:
		sub	rax, rcx
		ret
