section	.text
	extern	free
	global	ft_list_remove_if

ft_list_remove_if:
	xor		r9, r9
	xor		r10, r10

	mov		r10, [rdi]
	jmp		startLoop

	updateCurrPrev:
		mov	r9, r10
		mov	r10, [r10 + 8]

	startLoop:
		cmp		r10, 0			; current == NULL
		je		return

		push	r9
		push	r10
		push	rdi
		push	rsi				
		mov		rdi, rsi		; put data_ref as 1st arg
		mov		rsi, [r10]		; put current->data as 2nd arg

		push	rdx				; save vars
		push	rcx

		call	rdx				; call cmp

		pop		rcx				; retrieve vars
		pop		rdx
		pop		rsi
		pop		rdi
		pop		r10
		pop		r9

		cmp		eax, 0			; cmp == 0
		je		removeElement

		jmp		updateCurrPrev

	removeElement:
		cmp		r9, 0			; prev == NULL
		je		newHead

		mov		rax		, [r10 + 8]	; next = current->next
		mov		[r9 + 8], rax		; prev->next = next

		jmp		freeNode

		

	newHead:
		mov		rax		, [r10 + 8]	; next = current->next
		mov		[rdi]	, rax		; *head = next 
		mov		r9		, rax		; prev = next

		jmp		freeNode

	freeNode:
		push	r9
		push	rsi
		push	rdx
		push	rcx
		push	rdi				; save vars

		mov		rdi, [r10]		; set current->data as 1st arg
		push	r10				; save current
		call	rcx				; call free_data
		pop		rdi				; retrieve current
		call	free wrt ..plt			; free current

		pop		rdi
		pop		rcx
		pop		rdx
		pop		rsi
		pop		r9

		jmp		resetCurrPrev

	resetCurrPrev:
		cmp		r9, [rdi]
		je		resetNewHead

		mov		r10, [r9 + 8]	; current = prev->next
		jmp		startLoop

	resetNewHead:
		mov		r10, r9			; current = prev
		xor		r9, r9			; prev = NULL
		jmp		startLoop
	
	return:
		ret

