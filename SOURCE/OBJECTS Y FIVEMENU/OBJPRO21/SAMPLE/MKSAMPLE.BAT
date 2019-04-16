@echo off
@echo Compiling oInspect Demo ...
clipper oInspect /a /n /I..\include /D_OINSPECT_DEMO
clipper nAchoice /a /n /I..\include
clipper TBarray  /a /n /I..\include

@echo Linking oInspect Demo ...
RTLINK FI oInspect, nAchoice, TBArray LIB ..\lib\ObjectsP


@echo Compiling BoxedArea Demo ...
clipper BoxedAre /a /n /I..\include /DDEMO_BOX
clipper ScreenAr /a /n /I..\include

@echo Linking BoxedArea Demo ...
RTLINK FI BoxedAre, ScreenAr LIB ..\lib\ObjectsP



