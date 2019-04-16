#ifndef _FIVEPRO_CH
#define _FIVEPRO_CH

#xcommand DEFAULT <uVar1> := <uVal1> ;
               [, <uVarN> := <uValN> ] => ;
                  <uVar1> := If( <uVar1> == nil, <uVal1>, <uVar1> ) ;;
                [ <uVarN> := If( <uVarN> == nil, <uValN>, <uVarN> ); ]

#define CRLF Chr( 13 ) + Chr( 10 )

//----------------------------------------------------------------------------//
// CURSORES RATON

#define IDC_ARROW    0
#define IDC_SIZEWE   1
#define IDC_SIZENS   2
#define IDC_CROSS    3
#define IDC_HAND     4
#define IDC_SIZENWSE 5

//----------------------------------------------------------------------------//

#include "Box.ch"
#include "Browse.ch"
#include "Menus.ch"
#include "Dialog.ch"
#include "DoUntil.ch"
#include "InKey.ch"
#include "Objectsp.ch"
#include "Vesa.ch"
#include "Window.ch"

#endif
