/*----------------------------------------------------------------------------*/

void MemorySay( char * pcMemDir, int iRow, int iCol, char * szText )
{
   unsigned int ui = 0;
   unsigned int uiOffset = ( iRow * 160 ) + ( iCol * 2 );
   char cColor = 30;
   char cChar;

   while( cChar = szText[ ui++ ] )
   {
      pcMemDir[ uiOffset++ ] = cChar;
      pcMemDir[ uiOffset++ ] = cColor;
   }
}

/*----------------------------------------------------------------------------*/
