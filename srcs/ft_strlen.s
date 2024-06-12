section .text
	global ft_strlen

ft_strlen:
	xor		rax, rax		; int i = 0

	startLoop:
		cmp		BYTE [rdi + rax], 0		; str[i] == 0
		je		return

		inc		rax						; i++
		jmp		startLoop

	return:
		ret
