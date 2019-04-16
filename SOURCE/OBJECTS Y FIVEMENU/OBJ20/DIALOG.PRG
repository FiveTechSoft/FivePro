#include "Objects.ch"

// Pruebas de derivaci¢n de nuevas clases

//----------------------------------------------------------------------------//

CLASS TDialog FROM TWindow

   DATA   aControls

   METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors ) CONSTRUCTOR

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors ) CLASS TDialog

   Super:New( nTop, nLeft, nBottom, nRight, cTitle, cColors )

   ::aControls = {}

return

//----------------------------------------------------------------------------//
