section .text
	global ft_strlen

ft_strlen:
	xor		rax, rax

	startLoop:
		cmp		BYTE [rdi + rax], 0
		je		return

		inc		rax
		jmp		startLoop

	return:
		ret
