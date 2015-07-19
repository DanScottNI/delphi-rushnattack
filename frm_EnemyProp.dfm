object frmEnemyProperties: TfrmEnemyProperties
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Enemy Properties'
  ClientHeight = 99
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblID: TLabel
    Left = 8
    Top = 8
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object lblEnemyName: TLabel
    Left = 8
    Top = 40
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object txtID: TEdit
    Left = 40
    Top = 8
    Width = 57
    Height = 21
    MaxLength = 2
    TabOrder = 0
    OnKeyPress = txtIDKeyPress
    OnKeyUp = txtIDKeyUp
  end
  object cmdOK: TButton
    Left = 40
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 120
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
