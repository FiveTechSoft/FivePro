; OBJASM version 2.0 released on Jan 3, 1991
; (C) Copyright 1988,1989,1990,1991 by Robert F. Day.  All rights reserved

	TITLE	prnpaper.c

	; Compiler:	TC86 Borland C++ 3.1

	; Unknown Comment Record (Class 249): '[03][00]'

	; Unknown Comment Record (Class 233): 'E[97]<[19][0A]prnpaper.c'

	; Unknown Comment Record (Class 233): '[00][10][8F][16][1E]c:\FivePro.20\include\extend.h'

	; Unknown Comment Record (Class 250): '[00][00][00][00]'

	; Unknown Comment Record (Class 233): ''

	; Unknown Comment Record (Class 234): '[01][0C]'

	.386p					; Enable USE32/USE16 usage
	.387					; Enable floating point also

PRNPAPER_TEXT	SEGMENT	BYTE PUBLIC USE16 'CODE'
PRNPAPER_TEXT	ENDS

_DATA	SEGMENT	WORD PUBLIC USE16 'DATA'
_DATA	ENDS

_BSS	SEGMENT	WORD PUBLIC USE16 'BSS'
_BSS	ENDS

DGROUP	GROUP	_DATA, _BSS

	; Unknown Comment Record (Class 232): '[01][0A]prnpaper.cE[97]<[19]'


	EXTRN		__parni:NEAR
	EXTRN		__retl:NEAR

	PUBLIC		LPRNPAPER		; Located at 1:0000h Type = 1


PRNPAPER_TEXT	SEGMENT
	assume	cs: PRNPAPER_TEXT


LPRNPAPER:
	push	bp
	mov	bp,sp
	sub	sp,+004h
	mov	ax,0001h
	push	ax
	call	far ptr __parni
	add	sp,+002h
	mov	[bp-002h],ax
	mov	ah,02h
	mov	dx,[bp-002h]
	int	17h
	mov	[bp-003h],ah
	test	byte ptr [bp-003h],20h
	jz	$L1
	xor	ax,ax
	jmp	short $L2
$L1:	mov	ax,0001h
$L2:	push	ax
	call	far ptr __retl
	add	sp,+002h
	mov	sp,bp
	pop	bp
	retf

PRNPAPER_TEXT	ENDS

	END

