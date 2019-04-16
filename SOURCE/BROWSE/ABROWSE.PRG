#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TABrowse FROM TQBrowse

   DATA aArray READONLY
   DATA nItem  READONLY
   DATA nLen   READONLY

   METHOD New( nTop, nLeft, nBottom, nRight, aArray, cTitle ) CONSTRUCTOR
   METHOD SetArray( aArray )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, aArray, cTitle ) CLASS TABrowse

   ::Parent:New( nTop, nLeft, nBottom, nRight )

   ::aArray        = aArray
   ::nItem         = 1
   ::nLen          = Len( aArray )
   ::GoTopBlock    = { || ::nItem := 1 }
   ::GoBottomBlock = { || ::nItem := Len( aArray ) }
   ::SkipBlock     = { | nWant, nDo | nDo := Min( Max( nWant, -::nItem + 1 ),;
                                      ::nLen - ::nItem ), ::nItem += nDo, nDo }
   ::AddColumn( TbColumnNew( cTitle,;
                { | u | If( PCount() == 0, ::aArray[ ::nItem ],;
                ::aArray[ ::nItem ] := u ) } ) )

return

//----------------------------------------------------------------------------//

METHOD SetArray( aArray ) CLASS TABrowse

   ::aArray        = aArray
   ::nItem         = 1
   ::nLen          = Len( aArray )

   ::RefreshAll()
   ::Display()

return

//----------------------------------------------------------------------------//
