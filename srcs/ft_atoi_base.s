section	.text
	global	string_contains

string_contains:	; int	string_contains(const char* str, char c) -> return -1 on if not in string, else index
	xor		rdx,	rdx
	xor		rcx,	rcx
	mov		rdx,	rsi

	startLoop1:
		cmp		BYTE [rdi], 0
		je		return_minus_1

		cmp		BYTE [rdi], dl
		je		return_index

		inc		rdi
		inc		ecx
		jmp		startLoop1

	return_index:
		mov		rax,	rcx
		ret

	return_minus_1:
		xor		rax,	rax
		mov		eax,	DWORD -1
		ret

section	.text
	global	check_duplicates

check_duplicates:	; int	check_duplicates(const char* str) -> return 0 on if has no duplicates, else 1
	mov		r9,		rdi

	cmp		BYTE [r9],	0
	je		return_no_dups

	xor		rcx,	rcx
	mov		cl,		BYTE [r9]
	inc		r9
	push	r9

	mov		rdi,	r9
	mov		rsi,	rcx
	call	string_contains
	pop		r9

	cmp		eax,	0
	jge		return_dups

	mov		rdi,	r9
	call	check_duplicates

	cmp		rax,	0
	je		return_no_dups

	return_dups:
		xor		rax,	rax
		inc		rax
		ret

	return_no_dups:
		xor		rax,	rax
		ret

section	.text
	global	check_base
	extern	ft_strlen,@function

check_base:		; int	check_base(const char* base) -> return 0 on 'success', -1 on error
	mov		r9,		rdi

	; ||---- Check length
	push	r9
	call	ft_strlen
	pop		r9

	cmp		rax,	1
	jle		return_error


	; ||---- check for "+- "
	push	r9
	mov		rdi,	r9
	xor		rax,	rax
	mov		al,		'+'
	mov		rsi,	rax
	call	string_contains
	pop		r9

	cmp		rax,	0
	jl		return_error

	push	r9
	mov		rdi,	r9
	xor		rax,	rax
	mov		al,		'-'
	mov		rsi,	rax
	call	string_contains
	pop		r9

	cmp		rax,	0
	jl		return_error

	push	r9
	mov		rdi,	r9
	xor		rax,	rax
	mov		al,		'-'
	mov		rsi,	rax
	call	string_contains
	pop		r9

	cmp		rax,	0
	jl		return_error

	; ||---- check for duplicates
	push	r9
	mov		rdi,	r9
	call	check_duplicates
	pop		r9

	cmp		rax,	0
	jne		return_error

	xor		rax,	rax
	ret

	return_error:
		xor		rax,	rax
		mov		eax,	DWORD -1
		ret		

section	.text
	global	skip_spaces

skip_spaces:	; const char*	skip_spaces(const char* str)
	jmp		startLoop3

	updateStrSigns:
		inc		rdi
	startLoop3:
		cmp		BYTE [rdi], 32
		je		updateStrSigns

		mov		rax,	rdi
		ret

section	.text
	global	compute_sign

compute_sign:	; int	compute_sign(const char* str)
	xor		rax,	rax
	xor		rcx,	rcx
	mov		ecx,	1

	startLoop5:
		cmp		BYTE [rdi],	'-'
		je		updateSign
		
		cmp		BYTE [rdi],	'+'
		je		updateStr

		mov		eax,	ecx
		ret
	
	updateSign:
		cmp		ecx,	-1
		je		setPositive

		mov		ecx,	-1
		jmp		updateStr

	setPositive:
		mov		ecx,	1
		jmp		updateStr

	updateStr:
		inc		rdi
		jmp		startLoop5

section	.text
	global	skip_plus_minus

skip_plus_minus:	; const char*	skip_plus_minus(const char* str)
	jmp		startLoop4

	updateStrPlusMinus:
		inc		rdi
	startLoop4:
		cmp		BYTE [rdi], '+'
		je		updateStrPlusMinus
	
		cmp		BYTE [rdi], '-'
		je		updateStrPlusMinus

		mov		rax,	rdi
		ret


section	.text
	global	times_ten

times_ten:	;int	times_ten(int x)	
	xor	rcx,	rcx
	xor	rax,	rax

	startLoop_ten:
		cmp		ecx,	DWORD 10
		je		return

		add		eax,	edi
		inc		ecx
		jmp		startLoop_ten
	
	return:
		ret

section	.text
	global	ft_atoi_base

ft_atoi_base:	; int		ft_atoi_base(const char* str, const char* base)
	mov		r8,		rdi		; str
	mov		r9,		rsi		; base

	; ||---- check base for errors
	push	r8
	push	r9
	mov		rdi,	r9
	call	check_base
	pop		r9
	pop		r8

	cmp		rax,	0
	jne		return_base_error
	
	push	r8
	push	r9
	mov		rdi,	r8
	call	skip_spaces
	pop		r9
	pop		r8
	mov		r8,		rax

	push	r8
	push	r9
	mov		rdi,	r8
	call	compute_sign
	pop		r9
	pop		r8
	xor		r10,	r10		; sign
	mov		r10,	rax

	push	r8
	push	r9
	push	r10
	mov		rdi,	r8
	call	skip_plus_minus
	pop		r10
	pop		r9
	pop		r8
	mov		r8,		rax

	xor		r11,	r11		; return val

	startLoop6:
		cmp		BYTE [r8],	0
		je		return_atoi

		push	r8
		push	r9
		push	r10
		push	r11

		mov		rdi,	r9
		xor		rax,	rax
		mov		al,		BYTE [r8]
		mov		rsi,	rax
		call	string_contains

		pop		r11
		pop		r10
		pop		r9
		pop		r8

		cmp		eax,	0
		jl		return_atoi

		push	r8
		push	r9
		push	r10
		push	r11
		push	rax

		mov		rdi,	r11
		call	times_ten

		pop		rdx
		pop		r11
		pop		r10
		pop		r9
		pop		r8

		mov		r11,	rax
		add		r11d,	edx

		inc		r8
		jmp		startLoop6

	return_atoi:
		cmp		r10d,	-1
		je		returnNegative

		mov		eax,	r11d
		ret

	returnNegative:
		xor		rax,	rax
		sub		eax,	r11d
		ret

	return_base_error:
		xor		rax, rax
		ret
