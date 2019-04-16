#ifndef _DIALOG_CH
#define _DIALOG_CH

#xtranslate bSETGET(<uVar>) => ;
            { | u | If( PCount() == 0, <uVar>, <uVar> := u ) }

//----------------------------------------------------------------------------//
// BUTTON

#xcommand @ <nRow>, <nCol> BUTTON [ <oBtn> PROMPT ] <cText> ;
             [ COLOR <nClrNormal> [,<nClrFocus>] ] ;
             [ MESSAGE <cMsg> ] ;
             [ ACTION <uAction> ] ;
             [ WHEN <uWhen> ] ;
             [ VALID <uValid> ] ;
             [ OF <oWnd> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
       => ;
          [ <oBtn> := ] TButton():New( <nRow>, <nCol>, <cText>, <cMsg>,;
             <{uAction}>, <{uWhen}>, <{uValid}>, <oWnd>, <nClrNormal>,;
             <nClrFocus> )

//----------------------------------------------------------------------------//
// LISTBOX

#xcommand @ <nRow>, <nCol> LISTBOX [ <oLbx> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ BROWSE <oBrowse> ] ;
             [ LOGICLEN <uLen> ] ;
             [ PROMPT <cLabel> ] ;
             [ MESSAGE <cMsg> ] ;
             [ OF <oWnd> ] ;
       => ;
          [ <oLbx> := ] TCtrBrowse():New( <nRow>, <nCol>, <nWidth>, <nHeight>,;
             <oBrowse>, <cLabel>, <cMsg>, <oWnd>, [<{uLen}>] )

#xcommand @ <nRow>, <nCol> LISTBOX [ [ <oLbx> VAR ] <nVar> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ ITEMS <acItems> ] ;
             [ PROMPT <cLabel> ] ;
             [ MESSAGE <cMsg> ] ;
             [ OF <oWnd> ] ;
       => ;
          [ <oLbx> := ] TListBox():New( <nRow>, <nCol>, <nWidth>, <nHeight>,;
             bSETGET(<nVar>), <acItems>, <cLabel>, <cMsg>, <oWnd> )

//----------------------------------------------------------------------------//
// GET

#xcommand @ <nRow>, <nCol> GET [ <oGet> VAR ] <uVar> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ COLOR <cColors> ] ;
             [ PROMPT <cLabel> ] ;
             [ MESSAGE <cMessage> ] ;
             [ <memo: MULTILINE, MEMO, TEXT> ] ;
             [ WHEN <uWhen> ] ;
             [ VALID <uValid> ] ;
             [ OF <oWnd> ] ;
       => ;
          [ <oGet> := ] TMGet():New( <nRow>, <nCol>, <nWidth>, <nHeight>,;
             bSETGET(<uVar>), <cColors>, <cLabel>, <cMessage>, <oWnd> )

#xcommand @ <nRow>, <nCol> GET [ <oGet> VAR ] <uVar> ;
             [ COLOR <cColors> ] ;
             [ PROMPT <cLabel> ] ;
             [ PICTURE <cPicture> ] ;
             [ MESSAGE <cMessage> ] ;
             [ WHEN <uWhen> ] ;
             [ VALID <uValid> ] ;
             [ OF <oWnd> ] ;
       => ;
          [ <oGet> := ] TGet():New( <nRow>, <nCol>, bSETGET(<uVar>),;
             <cColors>, <cLabel>, <cMessage>, <cPicture>, <oWnd>, <{uWhen}>,;
             <{uValid}> )

//----------------------------------------------------------------------------//
// RADIO

#xcommand @ <nRow>, <nCol> RADIO [ <oRadMenu> VAR ] <nVar> ;
             [ ITEMS <aItems,...> ] ;
             [ <prompt: PROMPT, LABEL> <cLabel> ] ;
             [ <wnd: OF, OF WINDOW, DIALOG> <oWnd> ] ;
       => ;
          [ <oRadMenu> := ] TRdMenu():New( <nRow>, <nCol>, bSETGET(<nVar>),;
             \{<aItems>\}, <cLabel>, <oWnd> )

//----------------------------------------------------------------------------//
// CHECKBOX

#xcommand @ <nRow>, <nCol> CHECKBOX [ <oCbx> VAR ] <lVar> ;
             [ PROMPT <cPrompt> ] ;
             [ MESSAGE <cMsg> ] ;
             [ COLOR <cColors> ] ;
             [ <wnd: OF, WINDOW, DIALOG> <oWnd> ] ;
       => ;
          [ <oCbx> := ] TCheckBox():New( <nRow>, <nCol>, <cPrompt>,;
              bSETGET(<lVar>), <cMsg>, <cColors>, <oWnd> )

//----------------------------------------------------------------------------//
// SCROLLBAR

#xcommand @ <nRow>, <nCol> SCROLLBAR [ <oSbr> ] ;
			 [ PROMPT <cLabel> ];
			 [ MESSAGE <cMsg> ];
             [ <horizontal:HORIZONTAL> ] ;
             [ RANGE <nRANGE> ] ;
             [ PAGESTEP <nPgStep> ] ;
             [ SIZE <nLen> ] ;
             [ ON UP <uUp> ] ;
             [ ON DOWN <uDown> ] ;
             [ ON PAGEUP <uPgUp> ] ;
             [ ON PAGEDOWN <uPgDown> ] ;
             [ OF <oWnd> ] ;
       => ;
          [ <oSbr> := ] TScrollBar():New( <nRow>, <nCol>, <nRANGE>, <nLen>,;
             <cLabel>, <cMsg>, <.horizontal.>,<oWnd>, <{uUp}>, <{uDown}>,;
             <uPgUp> , <uPgDown>, <nPgStep>  )

//----------------------------------------------------------------------------//
// BITMAPS !!! in MsDos

#xcommand @ <nRow>, <nCol> BITMAP [<oBmp>] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ <resource: RESOURCE, NAME, RESNAME> <cResName> ] ;
             [ <file: FILE, FILENAME, DISK> <cBmpFile> ] ;
             [ <wnd: OF, WINDOW, DIALOG> <oWnd> ] ;
       => ;
          [<oBmp>:=] TBitmap():New( <nRow>, <nCol>, <nWidth>, <nHeight>,;
             <{cResName}>, <cBmpFile>, <oWnd> )

//----------------------------------------------------------------------------//

#xcommand DEFINE BUTTONBAR OF <oWnd> => TBtnBar():New( <oWnd> )

//---------------------------------------------------------------------------
// combobox
#xcommand @ <nRow>, <nCol> COMBOBOX [ <oCbx> VAR ] <cVar> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ ITEMS <aItems> ] ;
             [ WINDOW <oWnd> ] ;
             [ VALID   <bValid> ] ;
             [ WHEN   <bWhen> ];
             [ PICTURE <cPicture> ];
             [ PROMPT  <cLabel> ];
             [ MESSAGE <cMsg> ];
       => ;
          [ <oCbx> := ] TComboBox():New( <nRow>, <nCol>, bSETGET(<cVar>),;
             <aItems>,  <nWidth>, <nHeight> , <oWnd>,  <{bValid}> , <{bWhen}> , ;
             <cPicture> , <cLabel> , <cMsg> )
        
#endif
