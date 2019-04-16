#ifndef _WINDOW_CH
#define _WINDOW_CH


#xcommand DEFINE WINDOW <oWnd> ;
             [ <from:FROM, AT> <nTop>, <nLeft> ] ;
             [ TO <nBottom>, <nRight> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ TITLE <cTitle> ] ;
             [ <frame:DOUBLE, PANEL, NONE, SYSTEM> ] ;
             [ COLOR <cColorSpec> ] ;
             [ <max:MAXIMIZED> ] ;
             [ <min:MINIMIZED> ] ;
             [ <close:CLOSE, NOCLOSE> ] ;
             [ <float:FLOAT, NOFLOAT> ] ;
             [ <grow:GROW, NOGROW, NORESIZE> ] ;
             [ <iconize:ICONIZE, NOICONIZE> ] ;
             [ <zoom:ZOOM, NOZOOM> ] ;
             [ <vscroll: VERTICAL SCROLL, SCROLL VERTICAL> ] ;
             [ <hscroll: HORIZONTAL SCROLL, SCROLL HORIZONTAL> ] ;
             [ MENU <oMenu> ] ;
             [ <shadow:NOSHADOW> ] ;
             [ OF <oParent> ] ;
        => ;
          <oWnd> := TWindow():New( <nTop>, <nLeft>, <nBottom>, <nRight>, ;
                       <nHeight>, <nWidth>, <cTitle>,  ;
                       <cColorSpec>, <.max.>, <.min.>, <(close)>, ;
                       <(float)>, <(grow)>, <(iconize)>, <(zoom)>, ;
                       <.vscroll.>, <.hscroll.>, <oMenu>, [!<.shadow.>],;
                       <oParent> )

#xcommand DEFINE DIALOG <oWnd> ;
             [ <from:FROM, AT> <nTop>, <nLeft> ] ;
             [ TO <nBottom>, <nRight> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ TITLE <cTitle> ] ;
             [ COLOR <cColorSpec> ] ;
             [ <close:CLOSE, NOCLOSE> ] ;
             [ <shadow:NOSHADOW> ] ;
             [ OF <oParent> ] ;
        => ;
          <oWnd> := TWindow():New( <nTop>, <nLeft>, <nBottom>, <nRight>, ;
                       <nHeight>, <nWidth>, <cTitle>,  ;
                       <cColorSpec>, .f. , .f. , <(close)>, ;
                       "NOFLOAT" , "NOGROW" , "NOICONOZE" , "NOZOOM" , ;
                       .f.,.f., , [!<.shadow.>],;
                       <oParent> )






#xcommand ACTIVATE <wnd:WINDOW,DIALOG> <oWnd> ;
             [ WHEN <uWhen> ] ;
             [ VALID <uValid> ] ;
             [ ON CLICK <uClick> ] ;
             [ ON DBLCLICK <uDblClick> ] ;
             [ ON ICONIZE <uIconize> ] ;
             [ ON MOVE <uMove> ] ;
             [ ON PAINT <uPaint> ] ;
             [ ON RESIZE <uResize> ] ;
             [ ON SCROLL UP    <uScrollUp> ] ;
             [ ON SCROLL DOWN  <uScrollDown> ] ;
             [ ON SCROLL LEFT  <uScrollLeft> ] ;
             [ ON SCROLL RIGHT <uScrollRight> ] ;
             [ ON ZOOM <uZoom> ] ;
             [ <nowait: NOWAIT> ] ;
        => ;
          <oWnd>:Activate( <oWnd>:bWhen        [ := <{uWhen}> ], ;
                           <oWnd>:bValid       [ := <{uValid}> ], ;
                           <oWnd>:bClicked     [ := <{uClick}> ], ;
                           <oWnd>:bIconized    [ := <{uIconize}> ], ;
                           <oWnd>:bMoved       [ := <{uMove}> ], ;
                           <oWnd>:bPainted     [ := <{uPaint}> ], ;
                           <oWnd>:bResized     [ := <{uResize}> ], ;
                           [ <{uScrollUp}> ], ;
                           [ <{uScrollDown}> ], ;
                           [ <{uScrollLeft}> ], ;
                           [ <{uScrollRight}> ], ;
                           <oWnd>:bZoomed      [ := <{uZoom}> ],;
                           <.nowait.> )


#command @ <nRow>, <nCol> SAY [ <oSay> PROMPT ] <uExpr> ;
            [ COLOR <cColor> ] ;
            <of:WINDOW, OF, OF WINDOW> <oWnd> ;
      => ;
         [ <oSay> := ] TSay():New( <nRow>, <nCol>, <{uExpr}>,;
             <cColor>, <oWnd> )

#endif
