#ifndef _MENUS_CH
#define _MENUS_CH

#xcommand DEFINE MENU <oMenu> ;
       => ;
          <oMenu> := TMenu():New()

#xcommand DEFINE PAD [<oPad>] ;
             [ OF <oMenu> ] ;
             [ PROMPT <cPrompt> ] ;
             [ AT <nRow>, <nCol> ] ;
             [ ACTION <uAction> ] ;
             [ MESSAGE <cMsg> ] ;
       => ;
          <oMenu>:AddItem( [ <oPad> := ] TMenuItem():New( <nRow>, <nCol>,;
                           <cPrompt>, <cMsg>, <{uAction}> ) )

#xcommand ACTIVATE MENU <oMenu> => <oMenu>:Exec()

#endif
