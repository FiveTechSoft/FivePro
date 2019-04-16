#ifndef _SVGA_H
#define _SVGA_H

#define CLIPPER void pascal

typedef unsigned int WORD;

void SVGAMode( void );
WORD WhichVGA( void );
void Point( WORD, WORD, WORD );

#endif
