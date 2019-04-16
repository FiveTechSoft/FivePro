#ifndef _VIEW_CH
#define _VIEW_CH

#xcommand SAVE VIEW => ViewSave()

#xcommand RESTORE VIEW => ViewRestore()

#xcommand VIEW => ViewBegin()

#xcommand DBF <cDbf> ;
             [ ALIAS <cAlias> ] ;
             [ INDEX <IndexList,...> ] ;
             [ <exclusive: EXCLUSIVE> ] ;
          => ;
          ViewAdd( <cDbf>, <cAlias>, { <IndexList> }, [<(exclusive)>] )

#xcommand DBF <cDbf> ;
             [ ALIAS <cAlias> ] ;
             FROM <cDbfMaster> ;
          => ;
          ViewAddTemp( <cDbf>, <cAlias>, <cDbfMaster> )

#xcommand ENDVIEW => ;
          if ! lViewEnd() ; ViewRestore(); nMsgBox( "Ficheros ocupados", "Atenci¢n" ); return ; end

#endif
