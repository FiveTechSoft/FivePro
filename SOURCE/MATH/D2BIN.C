#define CLIPPER void pascal

extern char * _parnd( unsigned int );
extern void _retclen( char *, unsigned int, unsigned int );
extern void _retnd( unsigned int, unsigned int, unsigned int, unsigned int );
extern char * _parc( unsigned int );

CLIPPER D2Bin()
{
   _retclen( _parnd( 1 ), 8, 1 );
}

CLIPPER Bin2D()
{
   unsigned int * pDouble = ( unsigned int * ) _parc( 1 );

   _retnd( pDouble[ 0 ], pDouble[ 1 ], pDouble[ 2 ], pDouble[ 3 ] );
}
