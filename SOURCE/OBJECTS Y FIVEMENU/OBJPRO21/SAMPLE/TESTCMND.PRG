
/*
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
� M�dulo: TestCmnd.prg                                          �
� Lenguaje: Clipper 5.0x + ObjectsP                             �
� Fecha: Marzo  1993                                            �
� Compilar: Clipper TestMess /a /n /w                           �
� Desc.:Demo/Test de la clase Command                           �
�                                                               �
� (c) 1993 Francisco Pulp�n y Antonio Linares                   �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*/

Function TestCommand( cParam1 )
local mQO := Command( "QOut" )
local mSetRow, mGetClass, mNew
local oGet


  mQO:exec( "� Ol� � Primero llamamos a QOut() !" )

  mQO:exec( "El objeto Command llam� a la funci�n:", mQO:name() )

  // test del m�todo send gen�rico, mandando mensajes a objetos...
  mSetRow = Command():New( "_Row" )

  mQO:exec( "Creamos un objeto get sin iniciar y un objeto Command -> '_Row'" )

  oGet = Get():New()

  mQO:exec( "oGet:row contiene:", oGet:row )

  mQO:exec( "Ahora le mandamos un mensaje oGet:send( mSetRow, 22 ) " )

  oGet:send( mSetRow, 22 ) // equivale a oGet:row = 22

  mQO:exec( "Ahora oGet:row contiene:", oGet:row )

  mQO:exec( "Tambi�n podemos crear cualquier tipo de objeto conociendo el nombre" )
  mQO:exec( "de su clase a partir de objetos Command...")

  mGetClass = Command( "Get" )
  mNew      = Command( "New" )

  oGet = mGetClass:exec():send( mNew, 10, 12 )

  mQO:exec( "oGet es un objeto creado a partir de dos datos caracter: 'Get' y 'New'" )
  mQO:exec( "oGet:ClassName() devuelve el nombre de la clase del objeto:", oGet:ClassName() )
  ?
  mQO:exec( "Puedes probar a mandarle mensajes a 'oGet' a traves de la linea de comandos" )
  mQO:exec( "Puedes entrar Ej.: 'C:\> testcmnd col'"

  if( pCount() > 0 )

      mNew = Command( cParam1 )

      mQO:exec( "El mensaje oGet:"+cParam1 + " devuelve -> ", oGet:send( mNew ) )

  endif

Return nil
