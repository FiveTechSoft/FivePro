#include "InKey.ch"
#include "Menu.ch"

#define CHR_CLOSE1 206
#define CHR_CLOSE2 183

// ----------------------------------------------------------------------------

function Main

  SET CURSOR OFF
  SetCancel( .f. )
  AltD( 0 )

  TrueShadow( .f. )
  FntBoxRnd()

  Alert( "This is only a Borland C++ 3.1 clone menu;Eso es solo una copia del men£ de Borland C++ 3.1" )
  @ 0, 0, MaxRow(), MaxCol() BOX Replicate( "°", 9 ) COLOR "B/W"
  @ MaxRow(), 0 SAY " F1" COLOR "R/W"
  @ MaxRow(), 3 SAY " Help ³ " COLOR "N/W"

  ACTIVATE MENU MenuBuild()

  FntSystem()
  CLS

return

// ----------------------------------------------------------------------------

function MenuBuild()

   local oMenu

   MENU oMenu MESSAGE AT MaxRow(), 11
      oMenu:nRow = 0
      MENUITEM " ð " MESSAGE "System commands and Transfer programs"
      MENU
         MENUITEM " &Repaint desktop "   MESSAGE "Redraw the screen"
         SEPARATOR
         MENUITEM " &GREP "              MESSAGE "Transfer to this program"
         MENUITEM " &Turbo Assembler "   MESSAGE "Transfer to this program"
         MENUITEM " Turbo &Debugger "    MESSAGE "Transfer to this program"
         MENUITEM " Turbo &Profiler "    MESSAGE "Transfer to this program"
         MENUITEM " R&esource compiler " MESSAGE "Transfer to this program"
         MENUITEM " &Import Librarian "  MESSAGE "Transfer to this program"
      ENDMENU
      MENUITEM " &File " MESSAGE "File-management commands (Open, Save, Print, etc.)"
      MENU
         MENUITEM " &New "            MESSAGE "Create a new file in a new Edit window"
         MENUITEM " &Open...     F3 " MESSAGE "Locate and open a file"
         MENUITEM " &Save        F2 " MESSAGE "Save the file in the active Edit window" ;
                                      DISABLED
         MENUITEM " S&ave as... "     MESSAGE "Save the file in the active window under a new name" ;
                                      DISABLED
         MENUITEM " Save a&ll "       MESSAGE "Save all modified files" ;
                                      DISABLED
         SEPARATOR
         MENUITEM " &Change dir... "  MESSAGE "Change the current working directory"
         MENUITEM " &Print "          MESSAGE "Print the contents of the active window" ;
                                      DISABLED
         MENUITEM " &DOS shell "      MESSAGE "Temporaly exit to DOS"
         SEPARATOR
         MENUITEM " &Quit     Alt+X " MESSAGE "Exit Borland C++ demo" ;
                                      SHORTCUT K_ALT_X ;
                                      ACTION oMenu:lEnd := .t.
      ENDMENU
      MENUITEM " &Edit " MESSAGE "Editor operations, undo, and Clipboard access"
      MENU
         MENUITEM " &Undo          Alt+BkSp " MESSAGE "Undo the previous editor action" ;
                                              DISABLED
         MENUITEM " &Redo    Shift+Alt+BkSp " MESSAGE "Redo the previously undone editor action" ;
                                              DISABLED
         SEPARATOR
         MENUITEM " Cu&t          Shift+Del " MESSAGE "Remove the selected text and put it in the Clipboard" ;
                                              DISABLED
         MENUITEM " &Copy          Ctrl+Ins " MESSAGE "Copy the selected text and put it in the Clipboard" ;
                                              DISABLED
         MENUITEM " &Paste        Shift+Ins " MESSAGE "Insert selected text from the Clipboard at the cursor position" ;
                                              DISABLED
         MENUITEM " C&lear         Ctrl+Del " MESSAGE "Delete the selected text" ;
                                              DISABLED
         MENUITEM " Copy &example "           MESSAGE "Copy program example from the Help window into the Clipboard" ;
                                              DISABLED
         SEPARATOR
         MENUITEM " &Show clipboard "         MESSAGE "Open the Clipboard window"
      ENDMENU
      MENUITEM " &Search " MESSAGE "Text and error search commands"
      MENU
         MENUITEM " &Find... "                  MESSAGE "Search for text" ;
                                                DISABLED
         MENUITEM " &Replace... "               MESSAGE "Search for text and replace it with new text" ;
                                                DISABLED
         MENUITEM " &Search again      Ctrl+L " MESSAGE "Repeat the last Find or Replace operation" ;
                                                DISABLED
         SEPARATOR
         MENUITEM " &Go to line number... "     MESSAGE "Move the cursor to a specific line number" ;
                                                DISABLED
         MENUITEM " &Previous error    Alt+F7 " MESSAGE "Move the cursor to the position of the previous message" ;
                                                DISABLED
         MENUITEM " &Next error        Alt+F8 " MESSAGE "Move the cursor to the position of the next message" ;
                                                DISABLED
         MENUITEM " &Locate function "          MESSAGE "Search for a function declaration while debugging" ;
                                                DISABLED
      ENDMENU
      MENUITEM " &Run " MESSAGE "Execute or single-step through a program"
      MENU
         MENUITEM " &Run             Ctrl+F9 " MESSAGE "Make and run the current program" ;
                                               DISABLED
         MENUITEM " &Program reset   Ctrl+F2 " MESSAGE "Restart the program from beginning" ;
                                               DISABLED
         MENUITEM " &Go to cursor         F4 " MESSAGE "Run the program from the run bar to the cursor position" ;
                                               DISABLED
         MENUITEM " &Trace into           F7 " MESSAGE "Execute next statement; stop within the current function" ;
                                               DISABLED
         MENUITEM " &Step over            F8 " MESSAGE "Execute next statement; skip over the current function" ;
                                               DISABLED
         MENUITEM " &Arguments... "            MESSAGE "Set command-line arguments to be passed to program"
      ENDMENU
      MENUITEM " &Compile " MESSAGE "Compile, Make or Build a program"
      MENU
         MENUITEM " &Compile     Alt+F9 " MESSAGE "Compile the file in the active Edit window" ;
                                          DISABLED
         MENUITEM " &Make            F9 " MESSAGE "Bring target up-to-date by compiling and linking, as necessary" ;
                                          DISABLED
         MENUITEM " &Link "               MESSAGE "Link target without recompiling" ;
                                          DISABLED
         MENUITEM " &Build all "          MESSAGE "Rebuild all files" ;
                                          DISABLED
         SEPARATOR
         MENUITEM " &Information... "     MESSAGE "Display compiler information"
         MENUITEM " &Remove messages "    MESSAGE "Clear all messages from the Message window" ;
                                          DISABLED
      ENDMENU
      MENUITEM " &Debug " MESSAGE "Inspect, evaluate, set breakpoints and watches"
      MENU
         MENUITEM " &Inspect...           Alt+F4  " MESSAGE "Open an Inspector window to examine values in a data element"
         MENUITEM " &Evaluate/modify...  Ctrl+F4  " MESSAGE "Evaluate a variable or expression and display the value"
         MENUITEM " &Call stack...       Ctrl+F3  " MESSAGE "Show the functions the program called to reach this point" ;
                                                    DISABLED
         MENUITEM " &Watches "                      MESSAGE "Add, delete, and edit watches"
         MENU
            MENUITEM " &Add watch...   Crtl+F7 "    MESSAGE "Insert a watch expression into the Watch window"
            MENUITEM " &Delete watch "              MESSAGE "Remove the current watch expression from the Watch window"
            MENUITEM " &Edit watch... "             MESSAGE "Edit the current watch expression int the Watch window"
            MENUITEM " &Remove all watches "        MESSAGE "Delete all watch expressions from the Watch window"
         ENDMENU
         MENUITEM " &Toggle breakpoint   Ctrl-F8  " MESSAGE "Set or clear an unconditional breakpoint at the cursor position" ;
                                                    DISABLED
         MENUITEM " &Breakpoints "                  MESSAGE "Set conditional breakpoints; view and edit breakpoints" ACTION Alert( "Test" )
      ENDMENU
      MENUITEM " &Proyect " MESSAGE "Project management commands: add, delete, view proyect files"
      MENU
         MENUITEM " &Open proyect... "  MESSAGE "Load a proyect file and its desktop"
         MENUITEM " &Close proyect... " MESSAGE "Close the current proyect and reload the default proyect" ;
                                        DISABLED
         SEPARATOR
         MENUITEM " &Add item... "      MESSAGE "Add an item to the proyect" ;
                                        DISABLED
         MENUITEM " &Delete item "      MESSAGE "Delete an item from the proyect" ;
                                        DISABLED
         MENUITEM " &Local options... " MESSAGE "Set or view options for a proyect item" ;
                                        DISABLED
         MENUITEM " &Include files... " MESSAGE "View the include files for a proyect item" ;
                                        DISABLED
      ENDMENU
      MENUITEM " &Options " MESSAGE "Set defaults for IDE, compiler, debugger; define Transfer programs"
      MENU
         MENUITEM " &Application... " MESSAGE "Specify properties of target file"
         MENUITEM " &Compiler"        MESSAGE "Set compiler defaults for code generation, error messages, and names"
         MENU
            MENUITEM " &Code generation... "          MESSAGE "Specify how compiler prepares object code (memory models, etc.)"
            MENUITEM " &Advanced code generation... " MESSAGE "View further code generation options"
            MENUITEM " &Entry/Exit code... "          MESSAGE "Change the entry/exit code generated for functions"
            MENUITEM " C&++ options..."               MESSAGE "Specify how C++ compiler prepares object code"
            MENUITEM " Adv&anced C++ options... "     MESSAGE "Specify settings for advanced C++ code generation items"
            MENUITEM " &Optimizations"                MESSAGE "Specify compiler optimizations"
            MENUITEM " &Source..."                    MESSAGE "Specify source code related options"
            MENUITEM " &Messages            "         MESSAGE "Specify how the IDE handles errors and warnings"
               MENU
                  MENUITEM " &Display... "              MESSAGE "Configure error and warning display"
                  SEPARATOR
                  MENUITEM " &Portability... "          MESSAGE "Choose portability messages to display"
                  MENUITEM " &Ansi violations... "      MESSAGE "Choose ANSI-violation messages to display"
                  MENUITEM " &C++ warnings... "         MESSAGE "Choose C++ warning messages to display"
                  MENUITEM " &Frequent errors... "      MESSAGE "Choose frequently enconuntered messages to display"
                  MENUITEM " &Less frequent errors... " MESSAGE "Choose less common messages to display"
               ENDMENU
            MENUITEM " &Names... "                    MESSAGE "Change the default segment, group, and class names"
         ENDMENU
         MENUITEM " &Transfer... "    MESSAGE "Create or change Transfer programs"
         MENUITEM " &Make... "        MESSAGE "Set make options"
         MENUITEM " &Linker "         MESSAGE "Set linker settings and libraries to be linked"
         MENU
            MENUITEM " &Settings... "  MESSAGE "Set linker options (map files, overlays, etc.)"
            MENUITEM " &Libraries... " MESSAGE "Set libraries to be included in link"
         ENDMENU
         MENUITEM " L&ibrarian... "   MESSAGE "Set librarian options (list file, case sensitivity, etc.)"
         MENUITEM " De&bugger... "    MESSAGE "Set debugging options (display swapping, inspector options, etc.)"
         MENUITEM " &Directories...   " MESSAGE "Set paths for include files, libraries, and binary output files"
         SEPARATOR
         MENUITEM " &Environment "    MESSAGE "Set environment, editor, mouse, and desktop preferences"
         MENU
            MENUITEM " &Preferences... " MESSAGE "Specify environment settings"
            MENUITEM " &Editor... "      MESSAGE "Specify editor settings"
            MENUITEM " &Mouse... "       MESSAGE "Specify mouse settings"
            MENUITEM " &Desktop... "     MESSAGE "Specify desktop settings"
            MENUITEM " &Startup..."      MESSAGE "Specify environment startup settings"
            MENUITEM " &Colors... "      MESSAGE "Set environment colors"
         ENDMENU
         SEPARATOR
         MENUITEM " &Save... "        MESSAGE "Save all the options"
      ENDMENU
      MENUITEM " &Window " MESSAGE "Open, arrange, and list windows" ;
                           AT 0, MaxCol() - 15
      MENU
         MENUITEM " Size/Move    Ctrl-F5 " MESSAGE "Change the size or position of the active window" ;
                                            DISABLED
         MENUITEM " Zoom              F5 " MESSAGE "Enlarge or restore the size of the active window" ;
                                            DISABLED
         MENUITEM " Cascade "               MESSAGE "Cascade windows on the desktop" ;
                                            DISABLED
         MENUITEM " Tile "                  MESSAGE "Tile windows on the desktop" ;
                                            DISABLED
         MENUITEM " Next              F6 " MESSAGE "Make the next window active" ;
                                            DISABLED
         MENUITEM " Close         Alt+F3 " MESSAGE "Close the active window" ;
                                            DISABLED
         MENUITEM " Clos&e all "            MESSAGE "Close all windows on the desktop; clear history list"
         SEPARATOR
         MENUITEM " &Message "              MESSAGE "Open the Message window"
         MENUITEM " &Output "               MESSAGE "Open the Output window"
         MENUITEM " &Watch "                MESSAGE "Open the Watch window"
         MENUITEM " &User screen   Alt+F5 " MESSAGE "Switch to the full-screen user output"
         MENUITEM " &Register "             MESSAGE "Open the Register window"
         MENUITEM " Proyect "               MESSAGE "Open the Proyect Manager window" ;
                                            DISABLED
         MENUITEM " Proyect notes "         MESSAGE "Open the Proyect Manager Notebook window" ;
                                            DISABLED
         SEPARATOR
         MENUITEM " &List all...    Alt+0 " MESSAGE "Show a complete list of windows"
      ENDMENU
      MENUITEM " &Help " MESSAGE "Access online Help" ;
                         AT 0, MaxCol() - 7
      MENU
         MENUITEM " &Contents "               MESSAGE "Show table of contens for online Help"
         MENUITEM " &Index         Shift+F1 " MESSAGE "Show index for online Help"
         MENUITEM " &Topic search   Ctrl+F1 " MESSAGE "Display Help for the word at the cursor, or display the index"
         MENUITEM " &Previous topic  Alt+F1 " MESSAGE "Redisplay the last-viewed online Help screen"
         MENUITEM " &Help on help "           MESSAGE "How to use online Help"
         MENUITEM " Active &file... "         MESSAGE "Choose the help file you want to use"
         SEPARATOR
         MENUITEM " &About... "               MESSAGE "Show version and copyright information"
      ENDMENU
   ENDMENU

return oMenu

// ----------------------------------------------------------------------------
