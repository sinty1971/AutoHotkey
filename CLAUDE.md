# CLAUDE.md

このファイルは、このリポジトリでコードを扱う際のClaude Code (claude.ai/code)への指針を提供します。

## プロジェクト概要

Windows上でキーボードの動作をカスタマイズするためのAutoHotkey v2.0設定リポジトリです。メインスクリプトはCapsLockの機能を再マッピングし、Vimライクなナビゲーションコントロールを提供します。

## 主な機能

スクリプト（`default.ahk`）は以下を実装しています：
- CapsLockをナビゲーション用の修飾キーとして使用（i/j/k/l → 矢印キー）
- 選択モードのサポート（CapsLock + F + ナビゲーション）
- 単語ジャンプのサポート（CapsLock + G + ナビゲーション）
- CapsLock単独押しは無効化
- Ctrl + CapsLockで本来のCapsLock機能を実行

## スクリプトの実行方法

このAutoHotkeyスクリプトを使用するには：
1. AutoHotkey v2.0がインストールされていることを確認
2. `default.ahk`をダブルクリックするか、AutoHotkeyで実行
3. スクリプトはシステムトレイで実行されます

## 開発メモ

- SC03AはCapsLockキーのスキャンコード
- スクリプトはAutoHotkey v2.0の構文を使用（`#Requires`ディレクティブに注意）
- キーの組み合わせは`&`演算子で処理
- GetKeyStateを使用して複合アクション用の修飾キーの状態を確認