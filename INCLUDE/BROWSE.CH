#ifndef _BROWSE_CH
#define _BROWSE_CH

#xcommand BROWSE <oBrw> ;
            [ FROM <nTop>, <nLeft> TO <nBottom>, <nRight> ] ;
            [ COLOR <cColors> ] ;
            [ HEADSEP <cHeadSep> ] ;
            [ SEPARATOR <cSeparator> ] ;
            [ FILTER <cField> FOR <uValue1> [,<uValue2>] ] ;
            [ SELECT <uSelect> ] ;
          => ;
         <oBrw> := oBrwBegin( <nTop>, <nLeft>, <nBottom>, <nRight>,;
                              <cColors>, <cHeadSep>, <cSeparator>,;
                              <(cField)>, <uValue1>, [<uValue2>], <{uSelect}> )
#xcommand COLUMN [ <oCol> ] ;
            [ SHOW <uData> ] ;
            [ TITLE <cTitle> ] ;
            [ FOOTER <cFooter> ] ;
            [ COLOR <nColors,...> ] ;
            [ COLORSEL <uColorExpr> ] ;
            [ FOOTSEP <cFootSep> ] ;
            [ WIDTH <nWidth> ] ;
      => ;
         [<oCol> :=] oBrwColumn( [<{uData}>], [<cTitle>], [<cFooter>],;
            [{<nColors>}], [<{uColorExpr}>], [<cFootSep>],;
            [<nWidth>] )

#xcommand ENDBROWSE  =>

#xcommand END BROWSE => ENDBROWSE

#xcommand ACTIVATE BROWSE <oBrw> ;
            [ TITLE <oWndTitle> ] ;
            [ BUTTONBAR <aHotKeys> ] ;
            [ ON KEY <nKey1> DO <uAction1> ] ;
            [ ON KEY <nKeyN> DO <uActionN> ] ;
          => ;
            BrowseExec( <oBrw>, [<oWndTitle>], \{ ;
            [ \{ <nKey1>, <{uAction1}> \}, ] ;
            [ \{ <nKeyN>, <{uActionN}> \}  ] ;
            \}, [ <aHotKeys> ] )

#endif
