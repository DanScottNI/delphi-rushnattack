object frmTSAEditor: TfrmTSAEditor
  Left = 772
  Top = 500
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'TSA Editor'
  ClientHeight = 273
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgTSA: TImage32
    Left = 0
    Top = 0
    Width = 256
    Height = 256
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
    OnMouseMove = imgTSAMouseMove
    OnMouseUp = imgTSAMouseUp
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 254
    Width = 256
    Height = 19
    Panels = <
      item
        Text = 'Selected: 00'
        Width = 128
      end
      item
        Alignment = taRightJustify
        Text = '00'
        Width = 50
      end>
  end
end
