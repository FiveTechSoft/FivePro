#ifndef _MENU_CH
#define _MENU_CH

#xcommand MENU [ <oMenu> ] ;
             [ AT <nRow> ] ;
             [ MESSAGE AT <nMsgRow> [,<nMsgCol>] ] ;
             [ <color:COLOR,COLORS> <cColors,...> ] ;
       => ;
          [ <oMenu> := ] MenuBegin( <nRow>, <nMsgRow>, <nMsgCol>, [ {<cColors>} ] )

#xcommand MENUITEM [ <oMenuItem> PROMPT ] <cItem> ;
             [ SHORTCUT <nKey> ] ;
             [ AT <nRow>, <nCol> ] ;
             [ MESSAGE <cMsg> ] ;
             [ ACTION <uAction> ] ;
             [ <check:CHECKED> ] ;
             [ <disable:DISABLED> ] ;
             [ <color:COLOR,COLORS> <colors,...> ] ;
        => ;
           [ <oMenuItem> := ] MnuItem( <nRow>, <nCol>, <cItem>, <cMsg>,;
             <{uAction}>, <.disable.>, <.check.>, [ {<colors>} ], <nKey> )

#xcommand SEPARATOR => MnuItem( ,, "" )

#xcommand ENDMENU => MenuEnd()

#xcommand ACTIVATE MENU <oMenu> ;
             [ ON IDLE <uAction> ] ;
       => ;
          <oMenu>:Activate( <{uAction}> )

#endif
