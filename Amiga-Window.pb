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
  #Window_0
  #amiga_font
EndEnumeration

#fenster_breite = 400
#fenster_hoehe = 200
#text_hoehe = 12
fenstertitel.s = "Workbench:Test"
#aktiv = 1
#inaktiv = 0
amiga_fenster_aktiv.b = #aktiv
beenden.b = #False

Enumeration
  #amigaWindow
  #amigaStringGadget
  #amigaTextGadget
  #amigaButtonGadget
  #amigaCheckBoxGadget
EndEnumeration

CompilerIf 1 ;1=Fixedsys, 0=Amiga
  #font = "Fixedsys"
CompilerElse
  #font = "Amiga"
CompilerEndIf
font_geladen.b = #False

;Definiere die Höhe der ziehbaren Zone
#DragZoneHeight = 30
;Definiere einen weiteren Bereich unten
#ActionZoneBottom = 20

;Macros:
;Das Makro IsInRectangle prüft, ob ein Punkt (x,y)
;innerhalb eines Rechtecks liegt, das durch seine
;obere linke Ecke (rx, ry) und seine Dimensionen (rw, rh) definiert ist.
Macro IsInRectangle(x, y, rx, ry, rw, rh)
  ((x) >= (rx) And (x) < (rx) + (rw) And (y) >= (ry) And (y) < (ry) + (rh))
EndMacro

Procedure DrawWindow(fenstertitel.s, aktiv.b)
  If aktiv.b
    amiga_farbe.i = #amiga_farbe_bl
  Else
    amiga_farbe.i = #amiga_farbe_gr
  EndIf
  StartDrawing(WindowOutput(#amigaWindow))
  DrawingFont(FontID(#amiga_font))
  DrawingMode(#PB_2DDrawing_Default)
  ;Box(0, 0, #fenster_breite, #fenster_hoehe , #amiga_farbe_gr) ;Hintergrund, ganzes Fenster
  LineXY(0, 0, 0, #fenster_hoehe, #amiga_farbe_ws) ;Links senkrecht weiss
  LineXY(0, 0, #fenster_breite, 0, #amiga_farbe_ws);Oben waagerecht weiss
  LineXY(0, 1, #fenster_breite, 1, #amiga_farbe_ws);Oben waagerecht weiss
  Box(1, 2, #fenster_breite-1, TextHeight(fenstertitel.s)+1, amiga_farbe.i) ;Titelleiste blau durchgehend
  LineXY(1, TextHeight(fenstertitel.s)+3, 1, #fenster_hoehe, amiga_farbe.i) ;Links senkrecht blau
  LineXY(2, TextHeight(fenstertitel.s)+3, 2, #fenster_hoehe, amiga_farbe.i) ;Links senkrecht blau
  LineXY(3, TextHeight(fenstertitel.s)+3, 3, #fenster_hoehe, #amiga_farbe_sw) ;Links senkrecht schwarz
  Box(7, 6, 5, 7, #amiga_farbe_sw) ;Rahmen Schliessen schwarz
  Box(8, 7, 3, 5, #amiga_farbe_ws)  ;Rahmen Schliessen weiss innen
  LineXY(18, 2, 18, TextHeight(fenstertitel.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(19, 2, 19, TextHeight(fenstertitel.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  DrawText(29, 2, fenstertitel.s , #amiga_farbe_sw, amiga_farbe.i)
  LineXY(1, TextHeight(fenstertitel.s)+2, #fenster_breite-2, TextHeight(fenstertitel.s)+2, #amiga_farbe_sw) ;Linie unter TL schwarz
  LineXY(1, TextHeight(fenstertitel.s)+3, #fenster_breite-2, TextHeight(fenstertitel.s)+3, #amiga_farbe_sw) ;Linie unter TL schwarz
  LineXY(0, #fenster_hoehe-1, #fenster_breite-1, #fenster_hoehe-1, #amiga_farbe_sw) ;Linie ganz unten schwarz
  LineXY(0, #fenster_hoehe-2, #fenster_breite-1, #fenster_hoehe-2, #amiga_farbe_sw) ;Linie ganz unten schwarz
  LineXY(#fenster_breite-1, 1, #fenster_breite-1, #fenster_hoehe-1, #amiga_farbe_sw);Linie ganz rechts schwarz
  LineXY(#fenster_breite-2, TextHeight(fenstertitel.s)+4, #fenster_breite-2, #fenster_hoehe-3, amiga_farbe.i) ;Linie ganz rechts blau
  LineXY(#fenster_breite-3, TextHeight(fenstertitel.s)+4, #fenster_breite-3, #fenster_hoehe-3, amiga_farbe.i) ;Linie ganz rechts blau
  LineXY(#fenster_breite-4, TextHeight(fenstertitel.s)+4, #fenster_breite-4, #fenster_hoehe-3, #amiga_farbe_ws) ;Linie ganz rechts weiss
  LineXY(4, #fenster_hoehe-3, #fenster_breite-4, #fenster_hoehe-3, #amiga_farbe_ws);Linie ganz unten weiss
  LineXY(4, #fenster_hoehe-4, #fenster_breite-4, #fenster_hoehe-4, #amiga_farbe_ws);Linie ganz unten weiss
  ;nach Vorne
  Box(#fenster_breite-18, 4, 10, 8, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(#fenster_breite-17, 5, 8, 6, #amiga_farbe_gr)  ;Rahmen Vorne grau innen
  Box(#fenster_breite-14, 8, 10, 8, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(#fenster_breite-13, 9, 8, 6, #amiga_farbe_ws)  ;Rahmen Vorne weiss innen
  LineXY(#fenster_breite-23, 2, #fenster_breite-23, TextHeight(fenstertitel.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(#fenster_breite-22, 2, #fenster_breite-22, TextHeight(fenstertitel.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  ;Minimieren
  Box(#fenster_breite-39, 4, 13, 12, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(#fenster_breite-38, 5, 11, 10, amiga_farbe.i)  ;Rahmen Vorne blau innen
  Box(#fenster_breite-39, 4, 7, 7, #amiga_farbe_sw) ;Rahmen Vorne schwarz
  Box(#fenster_breite-38, 5, 5, 5, #amiga_farbe_ws)  ;Rahmen Vorne weiss innen
  LineXY(#fenster_breite-44, 2, #fenster_breite-44, TextHeight(fenstertitel.s)+1, #amiga_farbe_sw) ;Linie senkrecht rechts Schliessen schwarz
  LineXY(#fenster_breite-43, 2, #fenster_breite-43, TextHeight(fenstertitel.s)+1, #amiga_farbe_ws) ;Linie senkrecht rechts Schliessen weiss
  ;Rechtecktests
  ;Box(2, 2, 16, #text_hoehe+3, $0000ff) ;Schliessen
  ;Box(20, 2, #fenster_breite-63, #text_hoehe+3, $0000ff) ;Titelleiste
  ;Box(#fenster_breite-42, 2, 19, #text_hoehe+3, $0000ff) ;Minimieren
  ;Box(#fenster_breite-22, 2, 19, #text_hoehe+3, $0000ff) ;nach Vorne
  StopDrawing()
EndProcedure

Procedure amigaStringGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i=0)
  If Not IsGadget(nummer.i)
    StringGadget(nummer.i, x.i, y.i, b.i, h.i, text.s, flags.i | #PB_String_BorderLess)
    SetGadgetColor(nummer.i, #PB_Gadget_BackColor, #amiga_farbe_gr)
    ;If font_geladen.b = #True
      SetGadgetFont(nummer.i, #amiga_font)
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
    SetGadgetFont(nummer.i, #amiga_font)
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
  If #PB_Checkbox_Checked
    LineXY(x.i+6, y.i+8, x.i+8, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+7, y.i+8, x.i+9, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+8, y.i+8, x.i+10, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+13, y.i+4, x.i+9, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+14, y.i+4, x.i+10, y.i+12, #amiga_farbe_sw)
    LineXY(x.i+14, y.i+4, x.i+15, y.i+4, #amiga_farbe_sw)
  Else
    Box(x.i-1, y.i-1, x.i+b.i+0, y.i-1, #amiga_farbe_gr)
  EndIf
  StopDrawing()
EndProcedure

; WindowCallback Prozedur zur Verarbeitung von Nachrichten
Procedure.i WindowCallback(hWnd, Msg, wParam, lParam)
  If hWnd = WindowID(0)
    Select Msg
      Case #WM_NCHITTEST
        ; Hole die absolute X- und Y-Koordinate vom Bildschirm
        ; X ist im niederwertigen Wort, Y im höherwertigen
        Screen_X = lParam & $FFFF
        Screen_Y = lParam >> 16
        ; Holen Sie die absolute Position des Fensters
        Window_X = WindowX(0)
        Window_Y = WindowY(0)
        ; Berechne die Maus-Y-Koordinate relativ zum Fenster
        Mouse_X = Screen_X - Window_X
        Mouse_Y = Screen_Y - Window_Y
        ; Wenn die Maus sich in der Titelleiste befindet...
        If IsInRectangle(Mouse_X, Mouse_Y, 20, 2, #fenster_breite-63, #text_hoehe+3)
          ; ...sende die Anweisung an Windows, das Fenster zu verschieben
          ProcedureReturn #HTCAPTION
        EndIf
    EndSelect
  EndIf
  ProcedureReturn #PB_ProcessPureBasicEvents
EndProcedure


Procedure amigaWindow(window.i, x.i, y.i, b.i, h.i, fenstertitel.s, flags.i=0)
  If OpenWindow(window.i, x.i, y.i, b.i, h.i, fenstertitel.s, #PB_Window_BorderLess)
    ;Funktioniert noch nicht:
  ;If OpenWindow(window.i, x.i, y.i, b.i, h.i, fenstertitel.s, flags.i & ~#PB_Window_BorderLess)
    SetWindowCallback(@WindowCallback())
    SetWindowColor(#Window_0, #amiga_farbe_gr)
    If LoadFont(#amiga_font, #font, #text_hoehe)
      font_geladen.b = #True
    EndIf
    DrawWindow(fenstertitel.s, #aktiv)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

Procedure DrawGadgets()
  amigaStringGadget(1, 50, 50, 50, 20, "Test")
  amigaTextGadget(2, 10, 50, 30, 20, "Test:")
  amigaButtonGadget(3, 50, 100, 100, 40, "Button")
  amigaCheckBoxGadget(4, 200, 100, 100, 20, "CheckBox", #PB_Checkbox_Checked)
EndProcedure



OpenPreferences("Preferences.prefs")
PreferenceGroup("Window")
If amigaWindow(#amigaWindow,
               ReadPreferenceInteger("Position_X", 50),
               ReadPreferenceInteger("Position_X", 50),
               #fenster_breite,
               #fenster_hoehe,
               fenstertitel.s)
  ClosePreferences()
  Repeat
    EventID = WaitWindowEvent()
    
    Select EventID
      Case #PB_Event_CloseWindow
        beenden.b = #True
        
      Case #PB_Event_LeftClick ; Ein Mausklick wurde registriert
                               ; Holen Sie die Mauskoordinaten relativ zum Fenster
        Mouse_X = WindowMouseX(#Window_0) ;Hole die aktuellen Mauskoordinaten relativ zum Fenster
        Mouse_Y = WindowMouseY(#Window_0)
        If IsInRectangle(Mouse_X, Mouse_Y, 20, 2, #fenster_breite-63, #text_hoehe+3) ;Titelleiste
          SendMessage_(WindowID(#Window_0), #WM_SYSCOMMAND, #SC_SIZE_MOVE, 0)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, #fenster_breite-42, 2, 19, #text_hoehe+3) ;Minimieren
          SetWindowState(#Window_0, #PB_Window_Minimize)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, #fenster_breite-22, 2, 19, #text_hoehe+3) ;nach Vorne
          SetWindowState(#Window_0, #PB_Window_Normal)
          SetActiveWindow(#Window_0)
        ElseIf IsInRectangle(Mouse_X, Mouse_Y, 2, 2, 16, #text_hoehe+3) ;Beenden
          beenden.b = #True
        EndIf
        
      Case #PB_Event_ActivateWindow
        DrawWindow(fenstertitel.s, #aktiv)
        DrawGadgets()
      Case #PB_Event_DeactivateWindow
        DrawWindow(fenstertitel.s, #inaktiv)
        DrawGadgets()
      Case #PB_Event_Repaint
        DrawWindow(fenstertitel.s, #aktiv)
        DrawGadgets()
        
    EndSelect
    
  Until (EventID = #PB_Event_CloseWindow) Or beenden.b  
  If OpenPreferences("Preferences.prefs")
    PreferenceGroup("Window")
    WritePreferenceInteger("Position_X", WindowX(0))
    WritePreferenceInteger("Position_Y", WindowY(0))
  Else
    CreatePreferences("Preferences.prefs")
    PreferenceGroup("Window")
    WritePreferenceInteger("Position_X", WindowX(0))
    WritePreferenceInteger("Position_Y", WindowY(0))
  EndIf
Else
  ClosePreferences()
EndIf



; IDE Options = PureBasic 6.21 (Windows - x86)
; CursorPosition = 255
; FirstLine = 226
; Folding = --
; EnableXP
; UseIcon = boing32.ico
; Executable = Amiga-Window.exe
