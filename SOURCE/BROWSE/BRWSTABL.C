#include <Clipapi.h>

typedef CLV_WORD near * PCLIPLOG;

extern CLIPPER __TSTABILI( void );

// ForceStable para Clipper 5.01
// A¥ADIR A LA CLASE TBROWSE con :
// external BrwStable
//....
// __ClassAdd( oBrw:ClassH(), "FORCESTABLE", "BrwStable" )

CLIPPER BrwStable() // oBrowse en SELF.
{
   ( (PCLIPLOG) _eval )->wWord = 0;

   while( !( (PCLIPLOG) _eval )->wWord )
        __TSTABILI();
}

