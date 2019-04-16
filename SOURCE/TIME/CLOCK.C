#include <extend.h>
#include <dos.h>

static void interrupt far ( * OldClock ) ();
static void interrupt NewClock();
char * pcInDos;

static unsigned char ucBusy, ucTicks, ucSemiColon;

/*----------------------------------------------------------------------------*/

CLIPPER SetClock()
{
   unsigned char ucOnOff = _parl( 1 );

   asm push ax;
   asm push bx;
   asm push cx;
   asm push dx;
   asm push ds;
   asm push es;

   ucBusy      = 0;
   ucTicks     = 0;
   ucSemiColon = 0;
   _AH = 0x34;
   asm int 0x21;
   pcInDos = MK_FP( _ES, _BX );

   if( ucOnOff )
   {
      _AX = 0x3508;
      asm int 0x21;
      OldClock = MK_FP( _ES, _BX );

      _DX = FP_OFF( NewClock );
      _DS = FP_SEG( NewClock );
      _AX = 0x2508;
      asm int 0x21;
   }
   else
   {
      _DX = FP_OFF( OldClock );
      _DS = FP_SEG( OldClock );
      _AX = 0x2508;
      asm int 0x21;
   }

   asm pop es;
   asm pop ds;
   asm pop dx;
   asm pop cx;
   asm pop bx;
   asm pop ax;
}

/*----------------------------------------------------------------------------*/

static void interrupt NewClock()
{
   unsigned char ucHours, ucHoursHi, ucMinutes, ucMinutesHi;
   unsigned char ucPm;
   char * pcVideo = ( char * ) ( peekb( 0, 0x449 ) == 7 ? 0xB0000000: 0xB8000000 );
   unsigned char ucShiftStatus = peekb( 0, 0x417 );
   unsigned int uiOffset = ( 1 * 160 ) + 147;

   OldClock();

   if( ! ucBusy )
   {
      ucBusy++;

      pcVideo[ uiOffset +  1 ] = 'þ';
      pcVideo[ uiOffset +  2 ] = ( pcVideo[ uiOffset + 2 ] & 0xF0 ) | ( ( ucShiftStatus & 32 ) ? 0x0A: 0 );
      pcVideo[ uiOffset +  5 ] = 'þ';
      pcVideo[ uiOffset +  6 ] = ( pcVideo[ uiOffset + 6 ] & 0xF0 ) | ( ( ucShiftStatus & 64 ) ? 0x0A: 0 );
      pcVideo[ uiOffset +  9 ] = 'þ';
      pcVideo[ uiOffset + 10 ] = ( pcVideo[ uiOffset + 10 ] & 0xF0 ) | ( ( ucShiftStatus & 16 ) ? 0x0A: 0 );

      if( ! * pcInDos )
      {
         asm sti;
         _AH = 0x2C;
         asm int 0x21;
         ucHours     = _CH;
         ucMinutes   = _CL;

         ucPm        = ucHours > 11;
         ucHours     = ucPm ? ( ucHours - 12 ): ucHours;
         ucHoursHi   = ucHours / 10;
         ucHoursHi   = ( ucHoursHi > 11 ) ? ( ucHoursHi - 12 ): ucHoursHi;
         ucMinutesHi = ucMinutes / 10;

         pcVideo[ 142 ] = ucHoursHi ? ( ucHoursHi + 48 ): ' ';
         pcVideo[ 144 ] = ucHours - ( ucHoursHi * 10 ) + 48;
         pcVideo[ 148 ] = ucMinutesHi + 48;
         pcVideo[ 150 ] = ucMinutes - ( ucMinutesHi * 10 ) + 48;
         pcVideo[ 154 ] = ucPm ? 'p':'a';
         pcVideo[ 156 ] = 'm';

         if( ++ucTicks > 18 )
         {
            ucTicks        = 0;
            ucSemiColon    = ! ucSemiColon;
            pcVideo[ 146 ] = ucSemiColon ? ' ': ':';
         }
      }
      ucBusy--;
   }
}

/*----------------------------------------------------------------------------*/
