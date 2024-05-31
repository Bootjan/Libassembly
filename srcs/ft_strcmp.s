section .text
	global ft_strcmp

ft_strcmp:
	xor	rcx,rcx							; i = 0
	xor	rax,rax							; set entire return value to 0

	startLoop:
		mov		al, BYTE [rdi + rcx]	; al = s1[i]

		cmp		al, BYTE [rsi + rcx]	; s1[i] == s2[i]
		jne		diffStrings				; if false, go to diffStrings

		cmp		al,0					; end of one string
		jne		increment				; if true check for other

		cmp		BYTE [rsi + rcx], 0		; end of other string
		je		equalStrings			; if true, strings are the same

	increment:
		inc		rcx						; i++
		jmp		startLoop				; go to begin of loop

	equalStrings:
		xor		rax,rax					; set return value to 0
		ret
	diffStrings:
		xor		rbx,rbx					; xor
		mov		bl, BYTE [rsi + rcx]	; load byte
		sub		eax, DWORD ebx 			; substract to signed int
		ret
