section .text
	global ft_strcpy

ft_strcpy:
	xor	r10, r10
	mov	rax, rdi

	startLoop:
		mov	r10b, [rsi]
		mov	[rdi], r10b

		inc	rsi
		inc	rdi
		cmp	r10b, 0
		jne	startLoop

		ret
