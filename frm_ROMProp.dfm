object frmROMProperties: TfrmROMProperties
  Left = 226
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ROM Properties'
  ClientHeight = 99
  ClientWidth = 208
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
  object lblPlayer1Lives: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Player 1 Lives:'
  end
  object lblPlayer2Lives: TLabel
    Left = 8
    Top = 32
    Width = 70
    Height = 13
    Caption = 'Player 2 Lives:'
  end
  object txtPlayer1Lives: TEdit
    Left = 96
    Top = 8
    Width = 49
    Height = 21
    MaxLength = 1
    TabOrder = 0
  end
  object txtPlayer2Lives: TEdit
    Left = 96
    Top = 32
    Width = 49
    Height = 21
    MaxLength = 1
    TabOrder = 1
  end
  object cmdOK: TButton
    Left = 48
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 128
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
