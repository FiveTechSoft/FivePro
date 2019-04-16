
/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: TestCmnd.prg                                          บ
บ Lenguaje: Clipper 5.0x + ObjectsP                             บ
บ Fecha: Marzo  1993                                            บ
บ Compilar: Clipper TestMess /a /n /w                           บ
บ Desc.:Demo/Test de la clase Command                           บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

Function TestCommand( cParam1 )
local mQO := Command( "QOut" )
local mSetRow, mGetClass, mNew
local oGet


  mQO:exec( "ญ Ol ญ Primero llamamos a QOut() !" )

  mQO:exec( "El objeto Command llamข a la funciขn:", mQO:name() )

  // test del mtodo send genrico, mandando mensajes a objetos...
  mSetRow = Command():New( "_Row" )

  mQO:exec( "Creamos un objeto get sin iniciar y un objeto Command -> '_Row'" )

  oGet = Get():New()

  mQO:exec( "oGet:row contiene:", oGet:row )

  mQO:exec( "Ahora le mandamos un mensaje oGet:send( mSetRow, 22 ) " )

  oGet:send( mSetRow, 22 ) // equivale a oGet:row = 22

  mQO:exec( "Ahora oGet:row contiene:", oGet:row )

  mQO:exec( "Tambin podemos crear cualquier tipo de objeto conociendo el nombre" )
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
