section .text
	global		ft_strdup
	extern		ft_strlen,@function
	extern		ft_strcpy,@function
	extern		malloc,@function

ft_strdup:
	push	rdi
	call	ft_strlen

	mov		rdi, rax
	inc		rdi
	call	malloc wrt ..plt

	cmp		rax, 0
	je		return
	
	mov		rdi, rax
	pop		rsi
	call	ft_strcpy

	return:
		ret
