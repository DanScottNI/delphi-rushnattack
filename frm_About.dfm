object frmAbout: TfrmAbout
  Left = 313
  Top = 184
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'About Rush'#39'n Attack Editor'
  ClientHeight = 232
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblHomepage: TLabel
    Left = 4
    Top = 200
    Width = 58
    Height = 13
    Cursor = crHandPoint
    Hint = 'http://dan.panicus.org'
    Caption = 'Dan'#39's Space'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = lblHomepageClick
    OnMouseEnter = lblHomepageMouseEnter
    OnMouseLeave = lblHomepageMouseLeave
  end
  object cmdOK: TButton
    Left = 406
    Top = 201
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object pgcAbout: TPageControl
    Left = 8
    Top = 8
    Width = 465
    Height = 190
    ActivePage = tshAbout
    Style = tsFlatButtons
    TabOrder = 1
    object tshAbout: TTabSheet
      Caption = 'About'
      object lblDescription: TLabel
        Left = 4
        Top = 4
        Width = 441
        Height = 30
        Caption = 
          'Trip'#39'n Slip is a level editor for the NES game, Rush'#39'n Attack. '#13 +
          #10'It was written by Dan (dan@panicus.org).'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblCopyright: TLabel
        Left = 4
        Top = 45
        Width = 469
        Height = 45
        Caption = 
          'This program is not in any way associated with Konami, Nintendo,' +
          ' '#13#10'or any other companies. Do not email me for the Rush'#39'n Attack' +
          ' ROM, '#13#10'because I won'#39't send it to you.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object tshSpecialThanksGreetings: TTabSheet
      Caption = 'Special Thanks/Greetings'
      ImageIndex = 1
      object lblThanks: TLabel
        Left = 4
        Top = 4
        Width = 126
        Height = 150
        Caption = 
          'Special Thanks To:'#13#10#13#10'- Solid T-Bone'#13#10'- John'#13#10'- Martin Strand'#13#10'-' +
          ' FuSoYa'#13#10'- Ultima 4701'#13#10'- Muldoon'#13#10'- Gavin'#13#10'- The Fake God'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblGreetings: TLabel
        Left = 160
        Top = 4
        Width = 294
        Height = 150
        Caption = 
          'Greetings To (in no particular order):'#13#10#13#10'- Disch               ' +
          '     - JCE3000GT'#13#10'- Thaddeus                 - Dr. Mario'#13#10'- Dahr' +
          'kDaiz                - Mogster'#13#10'- redrum                   - Vag' +
          #13#10'- Gil-Galad                - JaSp'#13#10'- Atma                     ' +
          '- Victor Alonzo'#13#10'- bbitmaster               - Weasel '#13#10'- UfoThea' +
          'tre               - Skiffles'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
    object tshTripnSlipProgInfo: TTabSheet
      Caption = 'Program Information'
      ImageIndex = 2
      object lblComponents: TLabel
        Left = 4
        Top = 4
        Width = 217
        Height = 90
        Caption = 
          'Components used in Trip'#39'n Slip:'#13#10#13#10'- Turbopower Abbrevia'#13#10'- Jedi' +
          '-VCL v3.0 Beta'#13#10'- Drag And Drop Suite'#13#10'- Graphics32'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object lblCompiled: TLabel
        Left = 0
        Top = 104
        Width = 280
        Height = 15
        Caption = 'Compiled Under Delphi 7 Personal Edition'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
