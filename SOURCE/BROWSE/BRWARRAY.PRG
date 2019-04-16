// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function TBrowseArray( nTop, nLeft, nBottom, nRight, aArray )

   local oBrw := TBrowseNew( nTop, nLeft, nBottom, nRight )

   oBrw:Cargo         = 1
   oBrw:GoTopBlock    = { || oBrw:Cargo := 1 }
   oBrw:GoBottomBlock = { || oBrw:Cargo := Len( aArray ) }
   oBrw:SkipBlock     = ;
      { | nWant, nDo | nDo := Min( Max( nWant, 1 - oBrw:Cargo ),;
                       Len( aArray ) - oBrw:Cargo ), oBrw:Cargo += nDo, nDo }
   oBrw:AddColumn( TbColumnNew( , { || aArray[ oBrw:Cargo ] } ) )

return oBrw

//----------------------------------------------------------------------------//
