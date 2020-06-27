﻿; Generated by AutoGUI 2.6.2
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
bEditMode = false

IniRead, HToggleReplay , cfg.ini, Hotkeys, HToggleReplay , !+F10
IniRead, HSaveReplay   , cfg.ini, Hotkeys, HSaveReplay   , !F10
IniRead, HToggleRecord , cfg.ini, Hotkeys, HToggleRecord , !F9
IniRead, HOpenOverlay  , cfg.ini, Hotkeys, HOpenOverlay  , !z

Gui Color, White

Menu FileMenu, Add, Toggle edit mode, MenuEdit
Menu FileMenu, Icon, Toggle edit mode, shell32.dll, 166
Menu FileMenu, Add, &Save, MenuSave
Menu FileMenu, Icon, &Save, shell32.dll, 259
Menu MenuBar, Add, &File, :FileMenu
Gui Menu, MenuBar

Gui Font, s15
Gui Add, Button, x8   y7 w100 h100, Toggle Replay
Gui Add, Button, x128 y7 w100 h100, Save Replay
Gui Add, Button, x248 y7 w100 h100, Toggle Record
Gui Add, Button, x368 y7 w100 h100, Open Overlay
Gui Font, s10
Gui Add, Hotkey, vHToggleReplay x8   y117 w100 h23 +Disabled, %HToggleReplay%
Gui Add, Hotkey, vHSaveReplay   x128 y117 w100 h23 +Disabled, %HSaveReplay%
Gui Add, Hotkey, vHToggleRecord x248 y117 w100 h23 +Disabled, %HToggleRecord%
Gui Add, Hotkey, vHOpenOverlay  x368 y117 w100 h23 +Disabled, %HOpenOverlay%
Gui Add, Edit, vEToggleReplay x8   y117 w100 h23 +Hidden, %HToggleReplay%
Gui Add, Edit, vESaveReplay   x128 y117 w100 h23 +Hidden, %HSaveReplay%
Gui Add, Edit, vEToggleRecord x248 y117 w100 h23 +Hidden, %HToggleRecord%
Gui Add, Edit, vEOpenOverlay  x368 y117 w100 h23 +Hidden, %HOpenOverlay%

Gui Show, w478 h150, NVIDIA Share Control Panel
Return

GuiEscape:
GuiClose:
    ExitApp
    
WrapFKeys(str) {
    return RegExReplace(str, "(F\d{1,2})", "{$1}")
}

Blink:
    Gui Color, Green
    sleep 1000
    Gui Color, White
Return

MenuEdit:
    bEditMode := !bEditMode
    if (!bEditMode) { 
        GuiControl, Hide, HToggleReplay
        GuiControl, Hide, HSaveReplay
        GuiControl, Hide, HToggleRecord
        GuiControl, Hide, HOpenOverlay

        GuiControl, Show, EToggleReplay
        GuiControl, Show, ESaveReplay
        GuiControl, Show, EToggleRecord
        GuiControl, Show, EOpenOverlay
    } else {
        GuiControl, Show, HToggleReplay
        GuiControl, Show, HSaveReplay
        GuiControl, Show, HToggleRecord
        GuiControl, Show, HOpenOverlay

        GuiControl, Hide, EToggleReplay
        GuiControl, Hide, ESaveReplay
        GuiControl, Hide, EToggleRecord
        GuiControl, Hide, EOpenOverlay
    }
    Gui, Submit, NoHide
    HToggleReplay := EToggleReplay
    HSaveReplay   := ESaveReplay
    HToggleRecord := EToggleRecord
    HOpenOverlay  := EOpenOverlay
    GuiControl, , HToggleReplay , %EToggleReplay%
    GuiControl, , HSaveReplay   , %ESaveReplay%
    GuiControl, , HToggleRecord , %EToggleRecord%
    GuiControl, , HOpenOverlay  , %EOpenOverlay%
Return

MenuSave:
    bEditMode := false
    GoSub, MenuEdit
    FileDelete, cfg.ini
    IniWrite, %EToggleReplay% , cfg.ini, Hotkeys, HToggleReplay
    IniWrite, %ESaveReplay%   , cfg.ini, Hotkeys, HSaveReplay
    IniWrite, %EToggleRecord% , cfg.ini, Hotkeys, HToggleRecord
    IniWrite, %EOpenOverlay%  , cfg.ini, Hotkeys, HOpenOverlay
    if (ErrorLevel == 0) {
        MsgBox Saved succesfully
    } else {
        MsgBox Save failed
    }
Return

ButtonToggleReplay:
    Send % WrapFKeys(HToggleReplay)
    GoSub, Blink
Return

ButtonSaveReplay:
    Send % WrapFKeys(HSaveReplay)
    GoSub, Blink
Return

ButtonToggleRecord:
    Send % WrapFKeys(HToggleRecord)
    GoSub, Blink
Return

ButtonOpenOverlay:
    Send % WrapFKeys(HOpenOverlay)
    GoSub, Blink
Return