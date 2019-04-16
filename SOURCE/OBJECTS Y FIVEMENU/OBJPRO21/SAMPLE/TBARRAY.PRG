/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: TBArray.prg                                           บ
บ Lenguaje: Clipper 5.xx + ObjectsP                             บ
บ Fecha: Agosto  1993                                           บ
บ Compilar: Clipper TBArray  /a /n /w                           บ
บ Desc.:Demo de herencia de la Clase TBrowse                    บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

 RECUERDA: TBrowse() devuelve lo mismo que TBrowseNew(). Un objeto
           TBrowse sin skipBlock. Si deseas un Objeto TBrowse como
           el que devuelve TbrowseDB() debes llamar a...

              SetTBrowDB( oBrowse )

           despus de llamar a TBrowse().

           EJ.:
                  local oBrow := TBrowse( 10, 10, 30, 70 )
                   ข
                  local oBrow := TBrowse():New( 10, 10, 30, 70 )

                  SetTBrowDb( oBrow )

*/

#include "ObjectsP.ch"
#include "inkey.ch"


/*******************************
*/
CREATE CLASS TBArray FROM  TBrowse

  PROTECT INSTVAR  nIndex, nLen  AS  Numeric

  METHOD New, lKeyEval, SetStable, AddColumn, DeftBlocks


ENDCLASS


METHOD TBArray::New( nTop, nLeft, nBottom, nRight )


   ::Parent:New( nTop, nLeft, nBottom, nRight )

   ::nIndex        = 1
   ::nLen          = 0
   ::DeftBlocks()

Return Self


METHOD DeftBlocks  CLASS TBArray

  ::GoTopBlock    = { || ::nIndex := 1 }
  ::GoBottomBlock = { || ::nIndex := ::nLen }
  ::SkipBlock     = { | nReq, nMoved | ;
                      nMoved := Min( Max( nReq, 1 - ::nIndex ),;
                           ::nLen - ::nIndex ), ::nIndex += nMoved, nMoved }
Return nil


METHOD AddColumn( cHeader, aColumn ) CLASS TBArray
   
   if valtype( aColumn ) == "A"
   
      ::Parent:AddColumn( TbColumnNew( cHeader, ;
          { || if( len( aColumn ) < ::nIndex, "", aColumn[ ::nIndex ] ) } ) )
   
      ::nLen = max( len( aColumn ), ::nLen )

   elseif valtype( aColumn ) == "B"  // Y el user deber  fijar nLen antes
                                     // de llamar a TBArray():exec()
      ::Parent:AddColumn( TbColumnNew( cHeader, aColumn ) )
   
   endif

Return nil



METHOD TBArray::lKeyEval( nKey )
 static aKeys := ;
       { K_DOWN      , "down"      ,;
         K_UP        , "up"        ,;
         K_PGDN      , "pageDown"  ,;
         K_PGUP      , "pageUp"    ,;
         K_CTRL_PGUP , "goTop"     ,;
         K_CTRL_PGDN , "goBottom"  ,;
         K_RIGHT     , "right"     ,;
         K_LEFT      , "left"      ,;
         K_HOME      , "home"      ,;
         K_END       , "end"       ,;
         K_CTRL_LEFT , "panLeft"   ,;
         K_CTRL_RIGHT, "panRight"  ,;
         K_CTRL_HOME , "panHome"   ,;
         K_CTRL_END  , "panEnd"     ;
       }

 local  nFound

   nFound = aScan( aKeys, nKey )

   if nFound > 0

      if valtype( aKeys[ ++nFound ] ) == "C"
         aKeys[ nFound ] = Command( aKeys[ nFound ] )
      endif

      ::send( aKeys[ nFound ] )

      ::SetStable()

      if ::stable .and. ( ::hitTop .OR. ::hitBottom )
          tone( 58, 0.2 )
      endif

   endif

Return ( nFound > 0 )


METHOD SetStable CLASS TBArray

  DispBegin()

     While !::stabilize()
     end

  DispEnd()

Return nil
