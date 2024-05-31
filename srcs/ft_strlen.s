section .text
	global ft_strlen

ft_strlen:
	xor		rax, rax				; i = 0

	startLoop:
		xor		cl, cl
		mov		cl, [rdi + rax]		; cl = str[i]

		cmp		cl, 0				; str[i] == 0
		je		end					; if true, go to end

		inc		rax					; increment loopcounter
		loop	startLoop			; go back to top
	end:
		ret
