object frmJumpTo: TfrmJumpTo
  Left = 192
  Top = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Jump To...'
  ClientHeight = 199
  ClientWidth = 264
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
  object lblSelectText: TLabel
    Left = 8
    Top = 8
    Width = 162
    Height = 13
    Caption = 'Please select the level to jump to:'
  end
  object lstLevels: TListBox
    Left = 8
    Top = 32
    Width = 249
    Height = 129
    ItemHeight = 13
    TabOrder = 0
  end
  object cmdOK: TButton
    Left = 104
    Top = 168
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 184
    Top = 168
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
