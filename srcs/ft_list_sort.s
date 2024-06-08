section	.text
	global	push_front

push_front:		; t*		push_front(t* head, t* highest)
	mov		[rsi + 8],	rdi
	mov		rax,		rsi
	ret

section	.text
	global	find_highest

find_highest:		; t*	find_highest(t* current, int (*cmp)())
	mov		r9,		rdi			; highest
	mov		r10,	rdi			; current
	mov		rcx,	rsi			; cmp

	startLoop1:
		mov		r10, [r10 + 8]	; current = current->next
		cmp		r10, 0
		je		return1

		push	r9
		push	r10
		push	rcx

		mov		rdi,	[r9]
		mov		rsi,	[r10]
		call	rcx

		pop		rcx
		pop		r10
		pop		r9

		cmp		eax, 	0
		jg		startLoop1

	updateHighest:
		mov		r9,		r10		
		jmp		startLoop1

	return1:
		mov		rax,	r9
		ret


section	.text
	global	remove_highest

remove_highest:			; t*	remove_highest(t* current, t* highest)
	mov		r9,		rdi		; save head
	xor		r10,	r10		; prev = NULL

	startLoop2:
		cmp		rdi, rsi				; current = highest
		je		removeHighest
	
		cmp		rdi,		0
		je		return2

		mov		r10, 	rdi				; prev = current
		mov		rdi,	[rdi + 8]		; current = current->next
		jmp		startLoop2

	removeHighest:
		cmp		r10,	0
		je		removeHead

		mov		rcx,		[rdi + 8]
		mov		[r10 + 8],	rcx
		mov		rax,		r9
		ret

	removeHead:
		mov		rax,	[rdi + 8]
		ret

	return2:
		mov		rax,	r9
		ret

section	.text
	global	ft_list_sort

ft_list_sort:	; void	ft_list_sort(t** head, int (*cmp)());
	xor		rax,	rax
	mov		r9,		[rdi]		; current
	mov		[rdi],	rax			; *head = NULL
	mov		r10,	rdi			; head
	mov		r11,	rsi			; cmp


	startLoop3:
		cmp		r9,		0
		je		return3

		push	r11
		push	r10
		push	r9

		mov		rdi,	r9
		mov		rsi,	r11

		call	find_highest		; rax = highest

		mov		r8,		rax			; r8 = highest

		pop		r9
		push	r9
		push	r8
		mov		rsi,	r8
		mov		rdi, r9
		call	remove_highest	

		pop		r8
		pop		r9
		mov		r9,		rax
		pop		r10

		push	r10
		push	r9
		push	r8

		mov		rdi,	[r10]
		mov		rsi,	r8
		call	push_front

		pop		r8
		pop		r9
		pop		r10
		mov		[r10], rax
		pop		r11

		jmp		startLoop3

	return3:
		ret
