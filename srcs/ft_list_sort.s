section	.text:
	global	ft_list_sort

ft_list_sort:	; 	void	ft_list_sort_helper(t** head, int (*cmp)())
	push	rsi			; rsi = cmp [rbp + 8]
	mov		r10, [rdi]	; r10 = current
	mov		r8,	r10		; save first element

	cmp		r10, 0
	je		return

	xor		[rdi], r10	;
	push	rdi			; rdi = head [rbp]

	startLoop:
		mov		r9, r10		; highest = current
		mov		r10, [r10 + 8]	; current = current->next

	findHighest:
		cmp		r10, 0		; current == NULL
		je		removeHighest

		push	r10
		push	r9
		push	r8
		mov		rdi, r9		; highest is 1st arg
		mov		rsi, r10	; current is 2nd arg
		call	[rbp + 24]

		pop		r8
		pop		r9
		pop		r10

		cmp		rax, 0
		jl		switchHighest

		mov		r10, [r10 + 8]
		jmp		findHighest

	switchHighest:
		mov		r9, r10
		mov		r10, [r10 + 8]
		jmp		findHighest

	removeHighest:
		xor		r11, r11	; r11 = prev = NULL
		mov		r10, r8		; r10 = currnt

	removeLoop:
		cmp		r9, r10
		je		remove

		mov		r11, r10
		mov		r10, [r10 + 8]
		jmp		removeLoop
	
	remove:
		cmp		r11, 0
		je		removeHead

		mov		rax, [r10 + 8]
		mov		[r11 + 8], rax
		jmp		pushHighest

	removeHead:
		mov		r8, [r8 + 8]
		jmp		pushHighest


	pushHighest:
		mov		rax, [rbp + 8]
		mov		rax, [rax]
		mov		[r9 + 8], rax
		mov		[rax], r9

		mov		r9, r8
		cmp		r9, 0
		je		return

		mov		r10, [r9 + 8]
		jmp		startLoop

	return:
		ret

