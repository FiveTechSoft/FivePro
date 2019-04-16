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
	?debug	S "cabsread.c"
	?debug	C E9BABD9C1B0A63616273726561642E63
	?debug	C E967544E1B1F633A5C4669766550726F2E32305C696E636C756465+
	?debug	C 5C436C69704170692E68
	?debug	C E94019CA1822433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C646F732E68
	?debug	C E94019CA1824433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C5F646566732E68
CABSREAD_TEXT	segment byte public 'CODE'
CABSREAD_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:CABSREAD_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
CABSREAD_TEXT	segment byte public 'CODE'
   ;	
   ;	CLIPPER cAbsRead()
   ;	
	assume	cs:CABSREAD_TEXT
CABSREAD	proc	far
	push	bp
	mov	bp,sp
	sub	sp,522
   ;	
   ;	{
   ;	   BYTE byDrive        = _parni( 1 );
   ;	
	mov	ax,1
	push	ax
	call	far ptr __parni
	pop	cx
	mov	byte ptr [bp-1],al
   ;	
   ;	   WORD wSectorNumber  = _parni( 2 );
   ;	
	mov	ax,2
	push	ax
	call	far ptr __parni
	pop	cx
	mov	word ptr [bp-4],ax
   ;	
   ;	   BYTE byBuffer[ 512 ];
   ;	   WORD wBufferSegment = FP_SEG( byBuffer );
   ;	
	mov	word ptr [bp-6],ss
   ;	
   ;	   WORD wBufferOffset  = FP_OFF( byBuffer );
   ;	
	lea	ax,word ptr [bp-522]
	mov	word ptr [bp-8],ax
   ;	
   ;	   char cResult;
   ;	
   ;	   asm push ds;
   ;	
 	push	 ds
   ;	
   ;	   asm mov cx, 1;                    // n£mero de sectores a leer
   ;	
 	mov	 cx, 1
   ;	
   ;	   asm mov dx, wSectorNumber;
   ;	
 	mov	 dx, [bp-4]
   ;	
   ;	   asm mov ds, wBufferSegment;
   ;	
 	mov	 ds, [bp-6]
   ;	
   ;	   asm mov bx, wBufferOffset;
   ;	
 	mov	 bx, [bp-8]
   ;	
   ;	   asm mov al, byDrive;
   ;	
 	mov	 al, [bp-1]
   ;	
   ;	   asm int 0x25;
   ;	
 	int	 025H
   ;	
   ;	   asm mov wError, ax;
   ;	
 	mov	 wError, ax
   ;	
   ;	   asm pop ax;                       // retira los FLAGS del Stack
   ;	
 	pop	 ax
   ;	
   ;	   asm pop ds;
   ;	
 	pop	 ds
   ;	
   ;	   asm and ax, 1;                    // Test CF
   ;	
 	and	 ax, 1
   ;	
   ;	   asm mov cResult, al;
   ;	
 	mov	 [bp-9], al
   ;	
   ;	
   ;	   _retclen( byBuffer, cResult == 0 ? 512: 0 );
   ;	
	cmp	byte ptr [bp-9],0
	jne	short @1@450
	mov	ax,512
	jmp	short @1@478
@1@450:
	xor	ax,ax
@1@478:
	push	ax
	push	ss
	lea	ax,word ptr [bp-522]
	push	ax
	call	far ptr __retclen
	add	sp,6
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
CABSREAD	endp
   ;	
   ;	CLIPPER nAbsRdError()
   ;	
	assume	cs:CABSREAD_TEXT
NABSRDERROR	proc	far
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;	   _retni( wError );
   ;	
	push	word ptr DGROUP:wError
	call	far ptr __retni
	pop	cx
   ;	
   ;	}
   ;	
	pop	bp
	ret	
NABSRDERROR	endp
CABSREAD_TEXT	ends
_BSS	segment word public 'BSS'
wError	label	word
	db	2 dup (?)
	?debug	C E9
	?debug	C FA00000000
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
CABSREAD_TEXT	segment byte public 'CODE'
CABSREAD_TEXT	ends
	public	NABSRDERROR
	public	CABSREAD
_wError	equ	wError
	extrn	__retni:far
	extrn	__retclen:far
	extrn	__parni:far
_s@	equ	s@
	end
