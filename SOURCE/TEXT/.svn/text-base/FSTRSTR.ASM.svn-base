_TEXT	segment byte use16 public 'CODE'	;size is 110
_TEXT   segment byte use16 public 'CODE'    ;size is 110
_DATA	segment word use16 public 'DATA'	;size is 0
_BSS	segment word use16 public 'BSS'	;size is 0
DGROUP	group	_BSS,_DATA

	public	__fstrstr
_TEXT	segment
__fstrstr:
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		les	BX,0Ah[BP]
		mov	AL,ES:[BX]
		cbw
		or	AX,AX
		jne	L18
		mov	DX,8[BP]
		mov	AX,6[BP]
		jmp short	L6A
L18:		push	DS
		cld
		les	DI,6[BP]
		push	ES
		mov	BX,DI
		xor	AX,AX
		mov	CX,0FFFFh
		repne
		scasb
		not	CX
		xchg	CX,DX
		les	DI,0Ah[BP]
		push	ES
		mov	BP,DI
		xor	AX,AX
		mov	CX,0FFFFh
		repne
		scasb
		inc	CX
		not	CX
		pop	DS
		pop	ES
L3D:		mov	SI,BP
		lodsb
		xchg	DI,BX
		xchg	CX,DX
		repne
		scasb
		mov	BX,DI
		jne	L4E
		cmp	CX,DX
		jae	L57
L4E:		xor	BX,BX
		mov	ES,BX
		mov	BX,1
		jmp short	L64
L57:		xchg	CX,DX
		jcxz	L64
		mov	AX,CX
		dec	CX
		rep
		cmpsb
		mov	CX,AX
		jne	L3D
L64:		pop	DS
		mov	AX,BX
		dec	AX
		mov	DX,ES
L6A:		pop	DI
		pop	SI
		pop	BP
		retf
_TEXT	ends
_DATA	segment
_DATA	ends
_BSS	segment
_BSS	ends
	end
