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
	?debug	S "boot.c"
	?debug	C E9A2039D1B06626F6F742E63
	?debug	C E967544E1B1F633A5C4669766550726F2E32305C696E636C756465+
	?debug	C 5C436C69704170692E68
	?debug	C E94019CA1822433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C646F732E68
	?debug	C E94019CA1824433A5C434F4D50494C41445C424F524C414E44435C+
	?debug	C 494E434C5544455C5F646566732E68
BOOT_TEXT	segment byte public 'CODE'
BOOT_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:BOOT_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
BOOT_TEXT	segment byte public 'CODE'
   ;	
   ;	CLIPPER BootRead()
   ;	
	assume	cs:BOOT_TEXT
BOOTREAD	proc	far
	push	bp
	mov	bp,sp
	sub	sp,512
   ;	
   ;	{
   ;	   BYTE bBuffer[ 512 ];
   ;	
   ;	   _CH = 0;
   ;	
	mov	ch,0
   ;	
   ;	   _CL = 0;
   ;	
	mov	cl,0
   ;	
   ;	   _DH = 0;
   ;	
	mov	dh,0
   ;	
   ;	   _DL = 0x80;
   ;	
	mov	dl,128
   ;	
   ;	   _ES = FP_SEG( bBuffer );
   ;	
	mov	ax,ss
	mov	es,ax
   ;	
   ;	   _BX = FP_OFF( bBuffer );
   ;	
	lea	ax,word ptr [bp-512]
	mov	bx,ax
   ;	
   ;	   _AL = 1;
   ;	
	mov	al,1
   ;	
   ;	   _AH = 2;
   ;	
	mov	ah,2
   ;	
   ;	   asm int 0x13;
   ;	
 	int	 013H
   ;	
   ;	
   ;	   _retclen( bBuffer, 512 );
   ;	
	mov	ax,512
	push	ax
	push	ss
	lea	ax,word ptr [bp-512]
	push	ax
	call	far ptr __retclen
	add	sp,6
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
BOOTREAD	endp
	?debug	C E9
	?debug	C FA00000000
BOOT_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
BOOT_TEXT	segment byte public 'CODE'
BOOT_TEXT	ends
	public	BOOTREAD
	extrn	__retclen:far
_s@	equ	s@
	end
