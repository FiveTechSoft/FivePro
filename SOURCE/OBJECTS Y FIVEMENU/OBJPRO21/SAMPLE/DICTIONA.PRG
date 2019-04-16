/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: Dictiona.prg                                          บ
บ Lenguaje: Clipper 5.xx + ObjectsP                             บ
บ Fecha: Agosto  1993                                           บ
บ Compilar: Clipper Dictiona /a /n /w                           บ
บ Desc.:Demo/Test de la clase Dictionary                        บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

  Una adaptaciขn OOPS de dict.prg, uno de los ejemplos incluidos
  en Clipper 5

*/

#include "ObjectsP.ch"

#define  DEFAULT_HASH_SIZE   31
#define  MAX_PAILS         4096

#define  KEY_HASH(key)       ( Bin2W(key) + Bin2W( SubStr(Trim(key), -2) ) )
#define  HASH_VAL(key, size) ( ( KEY_HASH(key) % size ) + 1 )

/*************
*/
  CLASS Dictionary

      HIDE INSTVAR  Pails AS Array

      METHOD        New      ,;
                    getVal   ,;
                    putAssoc ,;
                    remove   ,;
                    eval = DictEval

      METHOD putVal(  cKey, uVal )  INLINE ;
             ::putAssoc( Association():New( cKey, uVal ) )

      HIDE METHOD   resize   ,;
                    getPail

  ENDCLASS


/*****
*/
METHOD New( nHashSize )   CLASS Dictionary

    DEFAULT nHashSize = DEFAULT_HASH_SIZE

    ::Pails = Array( nHashSize, 0 )

Return Self

/*****
*/
METHOD getPail( cKey, nAssoc )   CLASS Dictionary

  local Pail := ::Pails[ HASH_VAL( cKey, LEN( ::Pails ) ) ]

     nAssoc = ascan( Pail, { |oAssoc| oAssoc:cKey == cKey } )

Return Pail

/*****
*/
METHOD getVal( cKey )  CLASS Dictionary

  local nAssoc
  local Pail := ::getPail( cKey, @nAssoc )

Return if( nAssoc == 0, NIL, Pail[ nAssoc ]:uValue )

/*****
*/
METHOD putAssoc( oAssoc )  CLASS Dictionary

  local nAssoc
  local Pail := ::getPail( oAssoc:cKey, @nAssoc )

    if nAssoc == 0

       aadd( Pail, oAssoc )
       nAssoc = len( Pail )

    else

       Pail[ nAssoc ] = oAssoc

    endif

    if nAssoc > 3 .AND. len( ::Pails ) < MAX_PAILS

        ::resize()  // this Pail is big, grow dict

    endif

Return nil


/*****
*/
METHOD Resize   CLASS Dictionary

  local oNew := Dictionary():New( min( len( ::Pails ) * 4 - 1, MAX_PAILS ) )

  aeval( ::Pails,;
                { |Pail| aeval( Pail, ;
                                  { |oAssoc| oNew:putAssoc( oAssoc ) } ) } )

  ::Pails = oNew:Pails

Return nil

/*****
*/
METHOD remove( cKey )       CLASS Dictionary

  local nAssoc
  local Pail   := ::getPail( cKey, @nAssoc )

    if nAssoc != 0
        adel( Pail, nAssoc )
        asize( Pail, len( Pail ) - 1 )
    endif

Return nil

/*****
*/
METHOD DictEval( block )     CLASS Dictionary

  local nPail

    for nPail = 1 to  len( ::Pails )
        
        // El CodeBlock recibe:  Pail[ nAssoc ], nAssoc
        aeval( ::Pails[ nPail ], block ) 

    next

Return nil
