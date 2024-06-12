section .text
	extern	__errno_location
	global	ft_write

ft_write:		; int ft_write(int fd, const char* buff, size_t count)
	mov	rax, 1 
	syscall

	cmp	rax, 0
	jl	error
	
	ret

	error:
		xor		rdi, rdi
		sub		rdi, rax
		call	__errno_location wrt ..plt
		mov		[rax], rdi
		mov		rax, -1
		ret
