#include <extend.h>

extern int __argc;
extern char ** __argv;

CLIPPER nArgC()
{
   _retni( __argc );
}

CLIPPER cArgV()
{
   unsigned char ucWichOne = _parni( 1 );

   _retc( ucWichOne < __argc ? __argv[ ucWichOne ] : "" );
}
