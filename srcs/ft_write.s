section .text
	global ft_write

ft_write:
	mov	rcx, rsi
	mov	rbx, rdi
	mov	rax, 1 
	syscall
	cmp	rax, 0
	jl	error
	ret

error:
	ret	; set ernno
