#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TBitmap FROM TView

   DATA   cBinFile, bResource, cImage
   DATA   nWidth, nHeight

   METHOD New( nRow, nCol, nWidth, nHeight, bResource, cBinFile, oWnd ) ;
                                                                   CONSTRUCTOR
   METHOD Display()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, nWidth, nHeight, bResource, cBinFile, oWnd ) CLASS TBitmap

   DEFAULT nWidth := MaxCol() + 1, nHeight := MaxRow() + 1

   Super:New( nRow, nCol, nRow + nHeight - 1, nCol + nWidth - 1, oWnd )

   ::nWidth    = nWidth
   ::nHeight   = nHeight
   ::cBinFile  = cBinFile
   ::bResource = bResource
   ::cImage    = If( ! Empty( cBinFile ), MemoRead( cBinFile ),;
                     Eval( bResource ) )

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TBitmap

   MOff()
   RestScreen( ::nTop, ::nLeft,;
               ::nTop + ::nHeight - 1, ::nLeft + ::nWidth - 1, ::cImage )
   MOn()

return

//----------------------------------------------------------------------------//
