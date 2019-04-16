	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "setpixel.c"
	?debug	C E97D55461C0A736574706978656C2E63
	?debug	C E903AD241C1F633A5C4669766550726F2E32305C696E636C756465+
	?debug	C 5C436C69704170692E68
	?debug	C E94019CA1822433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C646F732E68
	?debug	C E94019CA1824433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C5F646566732E68
SETPIXEL_TEXT	segment byte public 'CODE'
SETPIXEL_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:SETPIXEL_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
SETPIXEL_TEXT	segment byte public 'CODE'
   ;	
   ;	void SetPixel( WORD wRow, WORD wCol, BYTE bColor )
   ;	
	assume	cs:SETPIXEL_TEXT
_SetPixel	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
   ;	
   ;	{
   ;	   LONG lOffset = ( ( LONG ) wRow * 640 ) + wCol;
   ;	
	mov	bx,word ptr [bp+6]
	xor	cx,cx
	xor	dx,dx
	mov	ax,640
	call	far ptr F_LXMUL@
	add	ax,word ptr [bp+8]
	adc	dx,0
	mov	word ptr [bp-2],dx
	mov	word ptr [bp-4],ax
   ;	
   ;	
   ;	   VesaBank( lOffset / 65535 );
   ;	
	xor	ax,ax
	mov	dx,-1
	push	ax
	push	dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr F_LDIV@
	push	ax
	call	far ptr _VesaBank
	add	sp,2
   ;	
   ;	
   ;	   * ( ( LPBYTE ) 0xA0000000 + lOffset ) = bColor;
   ;	
	mov	bx,word ptr [bp-4]
	mov	ax,-24576
	mov	dl,byte ptr [bp+10]
	mov	es,ax
	mov	byte ptr es:[bx],dl
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_SetPixel	endp
   ;	
   ;	CLIPPER SETPIXEL()
   ;	
	assume	cs:SETPIXEL_TEXT
SETPIXEL	proc	far
   ;	
   ;	{
   ;	   SetPixel( _parni( 1 ), _parni( 2 ), _parni( 3 ) );
   ;	
	mov	ax,3
	push	ax
	call	far ptr __parni
	add	sp,2
	push	ax
	mov	ax,2
	push	ax
	call	far ptr __parni
	add	sp,2
	push	ax
	mov	ax,1
	push	ax
	call	far ptr __parni
	add	sp,2
	push	ax
	push	cs
	call	near ptr _SetPixel
	add	sp,6
   ;	
   ;	}
   ;	
	ret	
SETPIXEL	endp
	?debug	C E9
	?debug	C FA00000000
SETPIXEL_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
SETPIXEL_TEXT	segment byte public 'CODE'
SETPIXEL_TEXT	ends
	public	SETPIXEL
	extrn	F_LDIV@:far
	extrn	F_LXMUL@:far
	public	_SetPixel
	extrn	_VesaBank:far
	extrn	__parni:far
_s@	equ	s@
	end
