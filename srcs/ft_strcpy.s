section .text
	global ft_strcpy

ft_strcpy:
	xor	rax,rax					; i = 0

	startLoop:
		xor		cl,cl			; curr_char = '\0'
		mov		cl,BYTE [rsi + rax]	; str[i]

		cmp		cl,0			; str[i] == '\0'
		je		end				; if true, go to end
		mov		BYTE [rdi + rax],cl	; else cpy curr_char to dest
		inc		rax				; i++
		loop	startLoop		; go to start loop
	end:
		mov		rax, rdi
		ret						; return
