object frmPaletteEditor: TfrmPaletteEditor
  Left = 405
  Top = 305
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Palette Editor'
  ClientHeight = 239
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl000F: TLabel
    Left = 296
    Top = 9
    Width = 34
    Height = 13
    Caption = '00 - 0F'
  end
  object lbl101F: TLabel
    Left = 296
    Top = 27
    Width = 34
    Height = 13
    Caption = '10 - 1F'
  end
  object lbl202F: TLabel
    Left = 296
    Top = 45
    Width = 34
    Height = 13
    Caption = '20 - 2F'
  end
  object lbl303F: TLabel
    Left = 296
    Top = 63
    Width = 34
    Height = 13
    Caption = '30 - 3F'
  end
  object lblCurrentPalette: TLabel
    Left = 8
    Top = 88
    Width = 133
    Height = 13
    Caption = 'Current Palette Colour: $00'
  end
  object lblLevelPalette: TLabel
    Left = 8
    Top = 112
    Width = 106
    Height = 13
    Caption = 'Current Level Palette:'
  end
  object lblSpritePalette: TLabel
    Left = 8
    Top = 160
    Width = 137
    Height = 13
    Caption = 'Current Level Sprite Palette:'
  end
  object imgLevelPal1: TImage32
    Left = 8
    Top = 128
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 0
    OnMouseUp = imgLevelPal1MouseUp
  end
  object imgLevelPal2: TImage32
    Left = 117
    Top = 128
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 1
    OnMouseUp = imgLevelPal2MouseUp
  end
  object imgLevelPal3: TImage32
    Left = 226
    Top = 128
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 2
    OnMouseUp = imgLevelPal3MouseUp
  end
  object imgLevelPal4: TImage32
    Left = 336
    Top = 128
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 3
    OnMouseUp = imgLevelPal4MouseUp
  end
  object imgNESColours: TImage32
    Left = 8
    Top = 8
    Width = 286
    Height = 73
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 4
    OnMouseMove = imgNESColoursMouseMove
    OnMouseUp = imgNESColoursMouseUp
  end
  object cmdOK: TButton
    Left = 280
    Top = 208
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DragCursor = crDefault
    ModalResult = 1
    TabOrder = 5
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 360
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 6
    OnClick = cmdCancelClick
  end
  object imgSprPal1: TImage32
    Left = 8
    Top = 176
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 7
    OnMouseUp = imgSprPal1MouseUp
  end
  object imgSprPal2: TImage32
    Left = 117
    Top = 176
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 8
    OnMouseUp = imgSprPal2MouseUp
  end
  object imgSprPal3: TImage32
    Left = 226
    Top = 176
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 9
    OnMouseUp = imgSprPal3MouseUp
  end
  object imgSprPal4: TImage32
    Left = 336
    Top = 176
    Width = 100
    Height = 25
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 10
    OnMouseUp = imgSprPal4MouseUp
  end
end
