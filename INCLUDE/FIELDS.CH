#ifndef _FIELDS_CH
#define _FIELDS_CH

#xtranslate LOCAL VARFIELD <Field1> [,<FieldN> ] ALIAS <Dbf> => ;
      local <Field1> := If( lAltas, uValBlank( <Dbf>-><Field1> ), <Dbf>-><Field1> ) ;
  [ ; local <FieldN> := If( lAltas, uValBlank( <Dbf>-><FieldN> ), <Dbf>-><FieldN> ) ]

#xtranslate ASSIGN VARFIELD <Field1> [,<FieldN> ] ALIAS <Dbf> => ;
      <Field1> := If( lAltas, uValBlank( <Dbf>-><Field1> ), <Dbf>-><Field1> ) ;
  [ ; <FieldN> := If( lAltas, uValBlank( <Dbf>-><FieldN> ), <Dbf>-><FieldN> ) ]

#xtranslate UPDATE FIELDS <Field1> [,<FieldN>] => ;
            DbUpdate( lAltas, { <(Field1)> [,<(FieldN)> ] },;
                              { <Field1> [,<FieldN>] } )
#endif
