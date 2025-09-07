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

#fenster_breite = 300
#fenster_hoehe = 300
#text_hoehe = 12
fenstertitel.s = "Workbench:Tools"
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
  StartDrawing(WindowOutput(#Window_0))
  DrawingFont(FontID(#amiga_font))
  DrawingMode(#PB_2DDrawing_Default)
  Box(0, 0, #fenster_breite, #fenster_hoehe , #amiga_farbe_gr) ;Hintergrund, ganzes Fenster
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

If OpenWindow(#Window_0, 0, 0, #fenster_breite, #fenster_hoehe, fenstertitel.s, #PB_Window_BorderLess | #PB_Window_ScreenCentered)
  If LoadFont(#amiga_font, #font, #text_hoehe)
    font_geladen.b = #True
  EndIf
  DrawWindow(fenstertitel.s, #aktiv)

  Repeat
    EventID = WindowEvent()
    Select EventID
      Case #PB_Event_None
        Message.MSG
        While PeekMessage_(@Message, WindowID(#Window_0), 0, 0, #PM_REMOVE)
          If Message\message = #WM_LBUTTONDOWN
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
          EndIf
          TranslateMessage_(@Message)
          DispatchMessage_(@Message)
        Wend
      Case #PB_Event_ActivateWindow
        DrawWindow(fenstertitel.s, #aktiv)
      Case #PB_Event_DeactivateWindow
        DrawWindow(fenstertitel.s, #inaktiv)
      Case #PB_Event_Repaint
        DrawWindow(fenstertitel.s, 1)
    EndSelect
    ;Delay(1)
  Until (EventID = #PB_Event_CloseWindow) Or beenden.b
  
EndIf
; IDE Options = PureBasic 6.21 (Windows - x86)
; CursorPosition = 20
; FirstLine = 9
; Folding = -
; EnableXP
; UseIcon = icons8-commodore-amiga-48.ico
; Executable = Amiga-Window.exe