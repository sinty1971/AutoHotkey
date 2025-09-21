#Requires AutoHotkey v2.0

; グローバル変数
global isTemporaryEnglishMode := false

; IMEの状態を取得する関数
GetIMEState(hwnd := 0) {
    if !hwnd
        hwnd := WinExist("A")

    ; IMEのコンテキストを取得
    IMEWnd := DllCall("Imm32.dll\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    if !IMEWnd {
        ; MsgBox("IMEWndが取得できません")
        return 0
    }

    ; IMEの状態を取得
    try {
        result := SendMessage(0x283, 0x5, 0, IMEWnd)  ; WM_IME_CONTROL, IMC_GETOPENSTATUS
        ; MsgBox("IME取得結果: " . result)
        return result
    } catch as e {
        ; MsgBox("エラー: " . e.Message)
        return 0
    }
}

; IMEの状態を設定する関数
SetIMEState(state, hwnd := 0) {
    if !hwnd
        hwnd := WinExist("A")

    IMEWnd := DllCall("Imm32.dll\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    if !IMEWnd
        return

    ; IMEの状態を設定
    try {
        SendMessage(0x283, 0x6, state, IMEWnd)  ; WM_IME_CONTROL, IMC_SETOPENSTATUS
    } catch {
        ; エラーが発生した場合は何もしない
    }
}

; 半角シングルクオーテーションのホットキー
$':: {
    global isTemporaryEnglishMode

    ; 現在のIME状態を取得
    imeState := GetIMEState()

    if (imeState = 1) {
        ; 日本語モードで半角バックティックが入力された場合
        ; IMEをOFFにして英語モードに切り替える
        isTemporaryEnglishMode := true
        SetIMEState(0)  ; 英語モードに切り替え
        Sleep(50)
        Send "'"  ; 半角バックティックを送信
    } else if (isTemporaryEnglishMode) {
        ; 一時的な英語モード中（2回目のバックティック）
        Send "'"
        SetIMEState(1)  ; 日本語モードに戻す
        isTemporaryEnglishMode := false
    } else {
        ; 通常の英語モード
        Send "'"
    }
}

; バッククオートのホットキー（半角スペースを入力）
$`:: {
    global isTemporaryEnglishMode

    ; 現在のIME状態を取得
    imeState := GetIMEState()

    if (imeState = 1) {
        ; 日本語モードでバッククオートが入力された場合
        ; IMEをOFFにして英語モードに切り替える
        isTemporaryEnglishMode := true
        SetIMEState(0)  ; 英語モードに切り替え
        Sleep(50)
        Send " "  ; 半角スペースを送信
    } else if (isTemporaryEnglishMode) {
        ; 一時的な英語モード中（2回目のバッククオート）
        Send " "  ; 半角スペースを送信
        SetIMEState(1)  ; 日本語モードに戻す
        isTemporaryEnglishMode := false
    } else {
        ; 通常の英語モード
        Send " "  ; 半角スペースを送信
    }
}

; SHIFT+スペースのホットキー
; +Space:: {
;     global isTemporaryEnglishMode

;     ; 現在のIME状態を取得
;     imeState := GetIMEState()

;     if (imeState = 1) {
;         ; 日本語モードでSHIFT+スペースが入力された場合
;         ; IMEをOFFにして英語モードに切り替える
;         isTemporaryEnglishMode := true
;         SetIMEState(0)  ; 英語モードに切り替え
;         Sleep(50)
;         Send " "  ; 半角スペースを送信
;     } else if (isTemporaryEnglishMode) {
;         ; 一時的な英語モード中（2回目のSHIFT+スペース）
;         Send " "  ; 半角スペースを送信
;         Sleep(50)
;         SetIMEState(1)  ; 日本語モードに戻す
;         isTemporaryEnglishMode := false
;     } else {
;         ; 通常の英語モード
;         Send " "
;     }
; }
