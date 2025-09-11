;Gadget Typen:
#amigaWindow = 0
#amigaStringGadget = 1
#amigaTextGadget = 2
#amigaButtonGadget = 3
#amigaCheckBoxGadget = 4

Structure Gadgets
  Typ.i
  PosX.i
  PosY.i
  Breite.i
  Hoehe.i
  Text.s
  Flags.i
EndStructure
  
Dim Gadget.Gadgets(10)

;- Struktur
;{ Faltung Struktur Gadgets
OpenPreferences("Preferences.prefs")
PreferenceGroup("Window")
;Window:
Gadget(0)\Typ.i = #amigaWindow
Gadget(0)\PosX.i = ReadPreferenceInteger("Position_X", 50)
Gadget(0)\PosY.i = ReadPreferenceInteger("Position_X", 50)
Gadget(0)\Breite.i = 400
Gadget(0)\Hoehe.i = 200
Gadget(0)\Text.s = "Workbench:Test"
Gadget(0)\Flags.i = 0
ClosePreferences()

;StringGadget:
Gadget(1)\Typ.i = #amigaStringGadget
Gadget(1)\PosX.i = 100
Gadget(1)\PosY.i = 50
Gadget(1)\Breite.i = 150
Gadget(1)\Hoehe.i = 20
Gadget(1)\Text.s = "String"
Gadget(1)\Flags.i = 0

;TextGadget:
Gadget(2)\Typ.i = #amigaTextGadget
Gadget(2)\PosX.i = 50
Gadget(2)\PosY.i = 50
Gadget(2)\Breite.i = 30
Gadget(2)\Hoehe.i = 20
Gadget(2)\Text.s = "Text:"
Gadget(2)\Flags.i = 0

;ButtonGadget:
Gadget(3)\Typ.i = #amigaButtonGadget
Gadget(3)\PosX.i = 50
Gadget(3)\PosY.i = 100
Gadget(3)\Breite.i = 100
Gadget(3)\Hoehe.i = 40
Gadget(3)\Text.s = "Button"
Gadget(3)\Flags.i = 0

;CheckBoxGadget:
With Gadget(4)
  \Typ = #amigaCheckBoxGadget
  \PosX = 200
  \PosY.i = 100
  \Breite.i = 100
  \Hoehe.i = 20
  \Text.s = "CheckBox"
  \Flags.i = #PB_Checkbox_Unchecked
EndWith
;}


;Konstanten Amiga Workbench Farben
#amiga_farbe_ws = $ffffff
#amiga_farbe_sw = $000000
#amiga_farbe_gr = $a9a9a9
#amiga_farbe_bl = $b68967
#testfarbe      = $0000ff

;Konstanten für die Windows API Nachrichten
#WM_LBUTTONDOWN = $0201
#WM_SYSCOMMAND  = $0112
#SC_MOVE        = $F010
#SC_SIZE_MOVE   = $F012
#HTCAPTION      = 2

Enumeration
  #amiga_font
EndEnumeration

#fenster_breite = 400
Global fenster_breite.i = Gadget(0)\Breite.i
#fenster_hoehe = 200
#text_hoehe = 12
fenstertitel.s = "Workbench:Test"
#aktiv = 1
#inaktiv = 0
amiga_fenster_aktiv.b = #aktiv
beenden.b = #False


CompilerIf 1 ;1=Fixedsys, 0=Amiga
  #font = "Fixedsys"
CompilerElse
  #font = "Amiga"
CompilerEndIf
font_geladen.b = #False


;Macros:
;Das Makro IsInRectangle prüft, ob ein Punkt (x,y)
;innerhalb eines Rechtecks liegt, das durch seine
;obere linke Ecke (rx, ry) und seine Dimensionen (rw, rh) definiert ist.
Macro IsInRectangle(x, y, rx, ry, rw, rh)
  ((x) >= (rx) And (x) < (rx) + (rw) And (y) >= (ry) And (y) < (ry) + (rh))
EndMacro

Procedure DrawWindow(Array Gadget.Gadgets(1))
  With Gadget(0)
  If Not \Flags.i & #PB_Window_NoActivate
    amiga_farbe.i = #amiga_farbe_bl
  Else
    amiga_farbe.i = #amiga_farbe_gr
  EndIf
  StartDrawing(WindowOutput(#amigaWindow))
  DrawingFont(FontID(#amiga_font))
  DrawingMode(#PB_2DDrawing_Default)
  ;Box(0, 0, \Breite.i, Hoehe.i , #amiga_farbe_gr) ;Hintergrund, ganzes Fenster
  LineXY(0, 0, 0, Hoehe.i, #amiga_farbe_ws) ;Links senkrecht weiss
  LineXY(0, 0, \Breite.i, 0, #amiga_farbe_ws);Oben waagerecht weiss
  LineXY(0, 1, \Breite.i, 1, #amiga_farbe_ws);Oben waagerecht weiss
  Box(1, 2, \Breite.i-1, TextHeight(\Text.s)+1, amiga_farbe.i) ;Titelleiste blau durchgehend
  LineXY(1, TextHeight(\Text.s)+3, 1, \Hoehe.i, amiga_farbe.i) ;Links senkrecht blau
  LineXY(2, TextHeight(\Text.s)+3, 2, \Hoehe.i, amiga_farbe.i) ;Links senkrecht blau
  LineXY(3, TextHeight(\Text.s)+3, 3, \Hoehe.i, #amiga_farbe_sw) ;Links senkrecht schwarz
  Box(7, 6, 5, 7, #amiga_farbe_sw) ;Rahmen Schliessen schwarz
  Box(8, 7, 3, 5, #amiga_farbe_ws)  ;Rahmen Schliessen weiss innen
  LineXY(18, 2, 18, TextHeight(\Text.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(19, 2, 19, TextHeight(\Text.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  DrawText(29, 2, \Text.s , #amiga_farbe_sw, amiga_farbe.i)
  LineXY(1, TextHeight(\Text.s)+2, \Breite.i-2, TextHeight(\Text.s)+2, #amiga_farbe_sw) ;Linie unter TL schwarz
  LineXY(1, TextHeight(\Text.s)+3, \Breite.i-2, TextHeight(\Text.s)+3, #amiga_farbe_sw) ;Linie unter TL schwarz
  LineXY(0, \Hoehe.i-1, \Breite.i-1, \Hoehe.i-1, #amiga_farbe_sw) ;Linie ganz unten schwarz
  LineXY(0, \Hoehe.i-2, \Breite.i-1, \Hoehe.i-2, #amiga_farbe_sw) ;Linie ganz unten schwarz
  LineXY(\Breite.i-1, 1, \Breite.i-1, \Hoehe.i-1, #amiga_farbe_sw);Linie ganz rechts schwarz
  LineXY(\Breite.i-2, TextHeight(\Text.s)+4, \Breite.i-2, \Hoehe.i-3, amiga_farbe.i) ;Linie ganz rechts blau
  LineXY(\Breite.i-3, TextHeight(\Text.s)+4, \Breite.i-3, \Hoehe.i-3, amiga_farbe.i) ;Linie ganz rechts blau
  LineXY(\Breite.i-4, TextHeight(\Text.s)+4, \Breite.i-4, \Hoehe.i-3, #amiga_farbe_ws) ;Linie ganz rechts weiss
  LineXY(4, \Hoehe.i-3, \Breite.i-4, \Hoehe.i-3, #amiga_farbe_ws);Linie ganz unten weiss
  LineXY(4, \Hoehe.i-4, \Breite.i-4, \Hoehe.i-4, #amiga_farbe_ws);Linie ganz unten weiss
  ;nach Vorne
  Box(\Breite.i-18, 4, 10, 8, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(\Breite.i-17, 5, 8, 6, #amiga_farbe_gr)  ;Rahmen Vorne grau innen
  Box(\Breite.i-14, 8, 10, 8, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(\Breite.i-13, 9, 8, 6, #amiga_farbe_ws)  ;Rahmen Vorne weiss innen
  LineXY(\Breite.i-23, 2, \Breite.i-23, TextHeight(\Text.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(\Breite.i-22, 2, \Breite.i-22, TextHeight(\Text.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  ;Minimieren
  Box(\Breite.i-39, 4, 13, 12, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(\Breite.i-38, 5, 11, 10, amiga_farbe.i)  ;Rahmen Vorne blau innen
  Box(\Breite.i-39, 4, 7, 7, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(\Breite.i-38, 5, 5, 5, #amiga_farbe_ws)  ;Rahmen Vorne weiss innen
  LineXY(\Breite.i-44, 2, \Breite.i-44, TextHeight(\Text.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(\Breite.i-43, 2, \Breite.i-43, TextHeight(\Text.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  ;Rechtecktests
  ;Box(2, 2, 16, #text_hoehe+3, $0000ff) ;Schliessen
  ;Box(20, 2, \Breite.i-63, #text_hoehe+3, $0000ff) ;Titelleiste
  ;Box(\Breite.i-42, 2, 19, #text_hoehe+3, $0000ff) ;Minimieren
  ;Box(\Breite.i-22, 2, 19, #text_hoehe+3, $0000ff) ;nach Vorne
  StopDrawing()
  EndWith
EndProcedure

Procedure amigaStringGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i=0)
  If Not IsGadget(nummer.i)
    StringGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i | #PB_String_BorderLess)
    SetGadgetColor(nummer.i, #PB_Gadget_BackColor, #amiga_farbe_gr)
    ;If font_geladen.b = #True
      SetGadgetFont(nummer.i, FontID(#amiga_font))
      ;EndIf
  EndIf
  ;Die übergebenenen Koordinaten entsprechen genau den Ausgelesenen:
  ;Debug Str(x.i) + " " + Str(GadgetX(nummer.i))
  ;Debug Str(b.i) + " " + Str(GadgetWidth(nummer.i))
  StartDrawing(WindowOutput(#amigaWindow))
  ; +--------------------2--------------------+
  ; | +------------------1------------------+ |
  ; | |                                     | |
  ; 4 3             StringGadget            7 8
  ; | |                                     | |
  ; | +------------------5------------------+ |
  ; +--------------------6--------------------+
  LineXY(x.i-1, y.i-1, x.i+b.i+0, y.i-1, #amiga_farbe_sw) ;Linie 1
  LineXY(x.i-2, y.i-2, x.i+b.i+1, y.i-2, #amiga_farbe_sw) ;Linie 2
  LineXY(x.i-1, y.i-1, x.i-1, y.i+h.i-0, #amiga_farbe_sw) ;Linie 3
  LineXY(x.i-2, y.i-2, x.i-2, y.i+h.i+1, #amiga_farbe_sw) ;Linie 4
  LineXY(x.i+0, y.i+h.i-0, x.i+b.i-0, y.i+h.i-0, #amiga_farbe_ws) ;Linie 5
  LineXY(x.i-1, y.i+h.i+1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_ws) ;Linie 6
  LineXY(x.i+b.i+0, y.i+0, x.i+b.i+0, y.i+h.i-0, #amiga_farbe_ws) ;Linie 7
  LineXY(x.i+b.i+1, y.i-1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_ws) ;Linie 8
  ;LineXY(x.i-1, y.i-1, x.i+b.i+1, y.i-1, $0000ff)
  StopDrawing()
EndProcedure

Procedure amigaTextGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i=0)
  If Not IsGadget(nummer.i)
    TextGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i & ~#PB_Text_Border)
    SetGadgetColor(nummer.i, #PB_Gadget_BackColor, #amiga_farbe_gr)
    SetGadgetFont(nummer.i, FontID(#amiga_font))
  EndIf
EndProcedure

Procedure amigaButtonGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i=0)
  StartDrawing(WindowOutput(#amigaWindow))
  DrawingFont(FontID(#amiga_font))
  DrawText(x.i+(b.i-TextWidth(text.s))/2, y.i+(h.i-TextHeight(text.s))/2, text.s , #amiga_farbe_sw, #amiga_farbe_gr)
  LineXY(x.i-1, y.i-1, x.i+b.i+0, y.i-1, #amiga_farbe_ws) ;Linie 1
  LineXY(x.i-2, y.i-2, x.i+b.i+1, y.i-2, #amiga_farbe_ws) ;Linie 2
  LineXY(x.i-1, y.i-1, x.i-1, y.i+h.i-0, #amiga_farbe_ws) ;Linie 3
  LineXY(x.i-2, y.i-2, x.i-2, y.i+h.i+1, #amiga_farbe_ws) ;Linie 4
  LineXY(x.i+0, y.i+h.i-0, x.i+b.i-0, y.i+h.i-0, #amiga_farbe_sw) ;Linie 5
  LineXY(x.i-1, y.i+h.i+1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_sw) ;Linie 6
  LineXY(x.i+b.i+0, y.i+0, x.i+b.i+0, y.i+h.i-0, #amiga_farbe_sw) ;Linie 7
  LineXY(x.i+b.i+1, y.i-1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_sw) ;Linie 8

  StopDrawing()
EndProcedure

Procedure amigaCheckBoxGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i=#PB_Checkbox_Unchecked) ;#PB_CheckBox_Checked = Häkchen gesetzt
  StartDrawing(WindowOutput(#amigaWindow))
  DrawingFont(FontID(#amiga_font))
  b.i = 20 : h.i = 16
  DrawText(x.i+28, y.i+(h.i-TextHeight(text.s))/2, text.s , #amiga_farbe_sw, #amiga_farbe_gr)
  LineXY(x.i-1, y.i-1, x.i+b.i+0, y.i-1, #amiga_farbe_ws) ;Linie 1
  LineXY(x.i-2, y.i-2, x.i+b.i+1, y.i-2, #amiga_farbe_ws) ;Linie 2
  LineXY(x.i-1, y.i-1, x.i-1, y.i+h.i-0, #amiga_farbe_ws) ;Linie 3
  LineXY(x.i-2, y.i-2, x.i-2, y.i+h.i+1, #amiga_farbe_ws) ;Linie 4
  LineXY(x.i+0, y.i+h.i-0, x.i+b.i-0, y.i+h.i-0, #amiga_farbe_sw) ;Linie 5
  LineXY(x.i-1, y.i+h.i+1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_sw) ;Linie 6
  LineXY(x.i+b.i+0, y.i+0, x.i+b.i+0, y.i+h.i-0, #amiga_farbe_sw) ;Linie 7
  LineXY(x.i+b.i+1, y.i-1, x.i+b.i+1, y.i+h.i+1, #amiga_farbe_sw) ;Linie 8
  If flags.i = #PB_Checkbox_Checked
    LineXY(x.i+6, y.i+8, x.i+8, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+7, y.i+8, x.i+9, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+8, y.i+8, x.i+10, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+13, y.i+4, x.i+9, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+14, y.i+4, x.i+10, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+14, y.i+4, x.i+15, y.i+4, #amiga_farbe_sw)
  Else
    Box(x.i+1, y.i+1, b.i-2, h.i-2, #amiga_farbe_gr)
  EndIf
  StopDrawing()
EndProcedure

; WindowCallback Prozedur zur Verarbeitung von Nachrichten
Procedure.i WindowCallback(hWnd, Msg, wParam, lParam)
  If hWnd = WindowID(#amigaWindow)
    Select Msg
      Case #WM_NCHITTEST
        ; Hole die absolute X- und Y-Koordinate vom Bildschirm
        ; X ist im niederwertigen Wort, Y im höherwertigen
        Screen_X = lParam & $FFFF
        Screen_Y = lParam >> 16
        ; Holen Sie die absolute Position des Fensters
        Window_X = WindowX(#amigaWindow)
        Window_Y = WindowY(#amigaWindow)
        ; Berechne die Maus-Y-Koordinate relativ zum Fenster
        Mouse_X = Screen_X - Window_X
        Mouse_Y = Screen_Y - Window_Y
        ; Wenn die Maus sich in der Titelleiste befindet...
        If IsInRectangle(Mouse_X, Mouse_Y, 20, 2, fenster_breite.i-63, #text_hoehe+3)
          ; ...sende die Anweisung an Windows, das Fenster zu verschieben
          ProcedureReturn #HTCAPTION
        EndIf
      Case #WM_MOUSEACTIVATE
        ; Hier können Sie entscheiden, ob das Fenster aktiviert werden soll oder nicht.
        ; #MA_NOACTIVATE: Fenster nicht aktivieren, aber den Mausklick normal verarbeiten
        ; #MA_NOACTIVATEANDEAT: Fenster nicht aktivieren und den Mausklick "verschlucken"
        ;                       Das bedeutet, EventID = #PB_Event_LButtonDown würde nicht ausgelöst.
        ProcedureReturn #MA_NOACTIVATE ; Beispiel: Fenster nicht aktivieren
        ; ProcedureReturn #MA_NOACTIVATEANDEAT ; Wenn auch der Klick ignoriert werden soll
    EndSelect
  EndIf
  ProcedureReturn #PB_ProcessPureBasicEvents
EndProcedure


Procedure amigaWindow(Array Gadget.Gadgets(1))
  If OpenWindow(#amigaWindow, Gadget(0)\PosX.i, Gadget(0)\PosY.i,
                Gadget(0)\Breite.i, Gadget(0)\Hoehe.i,
                Gadget(0)\Text.s, #PB_Window_BorderLess)
    ;Funktioniert noch nicht:
  ;If OpenWindow(window.i, x.i, y.i, b.i, h.i, fenstertitel.s, flags.i & ~#PB_Window_BorderLess)
    SetWindowCallback(@WindowCallback())
    SetWindowColor(#amigaWindow, #amiga_farbe_gr)
    If LoadFont(#amiga_font, #font, #text_hoehe)
      font_geladen.b = #True
    EndIf
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

Procedure DrawGadgets(Array Gadget.Gadgets(1))
    For nummer.l = 1 To ArraySize(Gadget.Gadgets())
    If Gadget(nummer.l)\Typ = 0 And nummer.l > 0
      Break
    EndIf
    With Gadget(nummer.l) ;Auch das geht!
      If \Typ.i = #amigaStringGadget
        amigaStringGadget(nummer.l, \PosX.i, \PosY.i, \Breite.i, \Hoehe.i, \Text.s)
      ElseIf \Typ.i = #amigaTextGadget
        amigaTextGadget(nummer.l, \PosX.i, \PosY.i, \Breite.i, \Hoehe.i, \Text.s)
      ElseIf \Typ.i = #amigaButtonGadget
        amigaButtonGadget(nummer.l, \PosX.i, \PosY.i, \Breite.i, \Hoehe.i, \Text.s)
      ElseIf \Typ.i = #amigaCheckBoxGadget
        amigaCheckBoxGadget(nummer.l, \PosX.i, \PosY.i, \Breite.i, \Hoehe.i, \Text.s, \Flags.i)
      EndIf
    EndWith
  Next nummer.l
EndProcedure



If amigaWindow(Gadget())
  DrawWindow(Gadget())
  Repeat
    EventID = WaitWindowEvent()
    
    Select EventID
      Case #PB_Event_CloseWindow
        beenden.b = #True
      Case #PB_Event_LeftClick ; Ein Mausklick wurde registriert
                               ; Holen Sie die Mauskoordinaten relativ zum Fenster
        Mouse_X = WindowMouseX(#amigaWindow) ;Hole die aktuellen Mauskoordinaten relativ zum Fenster
        Mouse_Y = WindowMouseY(#amigaWindow)
        If IsInRectangle(Mouse_X, Mouse_Y, 20, 2, #fenster_breite-63, #text_hoehe+3) ;Titelleiste
          SendMessage_(WindowID(#amigaWindow), #WM_SYSCOMMAND, #SC_SIZE_MOVE, 0)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, #fenster_breite-42, 2, 19, #text_hoehe+3) ;Minimieren
          SetWindowState(#amigaWindow, #PB_Window_Minimize)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, #fenster_breite-22, 2, 19, #text_hoehe+3) ;nach Vorne
          SetWindowState(#amigaWindow, #PB_Window_Normal)
          SetActiveWindow(#amigaWindow)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, Gadget(4)\PosX, Gadget(4)\PosY.i,
                             Gadget(4)\Breite.i, Gadget(4)\Hoehe.i) ;CheckBoxGadget
          If Gadget(4)\Flags.i = #PB_Checkbox_Unchecked
            Gadget(4)\Flags.i = #PB_Checkbox_Checked
          Else
            Gadget(4)\Flags.i = #PB_Checkbox_Unchecked
          EndIf
          DrawGadgets(Gadget())
        ElseIf  IsInRectangle(Mouse_X, Mouse_Y, Gadget(3)\PosX, Gadget(3)\PosY.i,
                              Gadget(3)\Breite.i, Gadget(3)\Hoehe.i) ;ButtonGadget
          SetGadgetText(1, "Button gedrückt")
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, 2, 2, 16, #text_hoehe+3) ;Beenden
          beenden.b = #True
        Else
          ;Amiga-Verhalten: Fenster kommt nicht automatisch in Vordergrund
          ;Diese gehen nicht, kommt immer in den Vordergrund:
          ;SetFocus_(WindowID(#amigaWindow))
          ;SetActiveWindow_(WindowID(#amigaWindow))
          ;SetActiveWindow(#amigaWindow)
          ;So geht es:
          DrawWindow(Gadget())
        EndIf
      Case #PB_Event_ActivateWindow
        Gadget(0)\Flags.i = 0
        DrawWindow(Gadget())
        DrawGadgets(Gadget())
      Case #PB_Event_DeactivateWindow
        Gadget(0)\Flags.i = #PB_Window_NoActivate
        DrawWindow(Gadget())
        DrawGadgets(Gadget())
      Case #PB_Event_Repaint
        DrawWindow(Gadget())
        DrawGadgets(Gadget())
    EndSelect
  Until (EventID = #PB_Event_CloseWindow) Or beenden.b  
  If OpenPreferences("Preferences.prefs")
    PreferenceGroup("Window")
    WritePreferenceInteger("Position_X", WindowX(#amigaWindow))
    WritePreferenceInteger("Position_Y", WindowY(#amigaWindow))
  Else
    CreatePreferences("Preferences.prefs")
    PreferenceGroup("Window")
    WritePreferenceInteger("Position_X", WindowX(#amigaWindow))
    WritePreferenceInteger("Position_Y", WindowY(#amigaWindow))
  EndIf
Else
  ClosePreferences()
EndIf



; IDE Options = PureBasic 6.21 (Windows - x64)
; CursorPosition = 35
; FirstLine = 16
; Folding = --
; EnableXP
; UseIcon = boing32.ico
; Executable = Amiga-Window.exe
