object frmPreferences: TfrmPreferences
  Left = 367
  Top = 273
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Preferences'
  ClientHeight = 272
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cmdOK: TButton
    Left = 324
    Top = 240
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 404
    Top = 240
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cmdRestoreDefaults: TButton
    Left = 8
    Top = 240
    Width = 113
    Height = 25
    Caption = 'Restore Defaults'
    TabOrder = 2
    OnClick = cmdRestoreDefaultsClick
  end
  object pgcPreferences: TPageControl
    Left = 8
    Top = 8
    Width = 473
    Height = 225
    ActivePage = tshGeneral
    TabOrder = 3
    object tshGeneral: TTabSheet
      Caption = 'General'
      object lblDatafile: TLabel
        Left = 8
        Top = 8
        Width = 84
        Height = 13
        Caption = 'Default Data File:'
      end
      object lblPalette: TLabel
        Left = 8
        Top = 32
        Width = 38
        Height = 13
        Caption = 'Palette:'
      end
      object cbDataFile: TComboBox
        Left = 104
        Top = 8
        Width = 353
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object cbPaletteFile: TComboBox
        Left = 104
        Top = 32
        Width = 353
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object chkBackupFiles: TCheckBox
        Left = 8
        Top = 64
        Width = 161
        Height = 17
        Caption = 'Backup Files When Saving'
        TabOrder = 2
      end
      object rdgWhenIncorrectMapper: TRadioGroup
        Left = 8
        Top = 92
        Width = 449
        Height = 41
        Caption = 'When Mapper and PRG counts don'#39't match:'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          'Don'#39't Load ROM'
          'Prompt'
          'Ignore')
        TabOrder = 3
      end
      object chkAutoCheck: TCheckBox
        Left = 224
        Top = 64
        Width = 233
        Height = 17
        Caption = 'Attempt to select correct data file for ROM'
        TabOrder = 4
      end
      object chkChangeToObjModeWhenAdd: TCheckBox
        Left = 8
        Top = 140
        Width = 273
        Height = 17
        Caption = 'Change To Object Mode When Adding New Enemy'
        TabOrder = 5
      end
    end
    object tshDisplayOptions: TTabSheet
      Caption = 'Display Options'
      ImageIndex = 2
      object lblLeftTextColour: TLabel
        Left = 8
        Top = 32
        Width = 168
        Height = 13
        Caption = 'Left Text/Left Selected Tile Colour:'
      end
      object lblMiddleTextColour: TLabel
        Left = 8
        Top = 56
        Width = 193
        Height = 13
        Caption = 'Middle Text/Middle Selected Tile  Colour:'
      end
      object lblGridlineColour: TLabel
        Left = 8
        Top = 80
        Width = 73
        Height = 13
        Caption = 'Gridline Colour:'
      end
      object lblIconTransparency: TLabel
        Left = 168
        Top = 124
        Width = 94
        Height = 13
        Caption = 'Icon Transparency:'
      end
      object chkShowLeftMidText: TCheckBox
        Left = 8
        Top = 8
        Width = 177
        Height = 17
        Caption = 'Show Left && Middle Tile Text'
        TabOrder = 0
      end
      object imgLeftText: TImage32
        Left = 224
        Top = 32
        Width = 25
        Height = 20
        BitmapAlign = baTopLeft
        Color = clBtnFace
        ParentColor = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        TabOrder = 1
      end
      object cmdBrowseLeft: TButton
        Left = 256
        Top = 32
        Width = 25
        Height = 20
        Caption = '...'
        TabOrder = 2
        OnClick = cmdBrowseLeftClick
      end
      object cmdBrowseRight: TButton
        Left = 256
        Top = 56
        Width = 25
        Height = 20
        Caption = '...'
        TabOrder = 3
        OnClick = cmdBrowseRightClick
      end
      object imgRightText: TImage32
        Left = 224
        Top = 56
        Width = 25
        Height = 20
        BitmapAlign = baTopLeft
        Color = clBtnFace
        ParentColor = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        TabOrder = 4
      end
      object imgGridlineColour: TImage32
        Left = 224
        Top = 80
        Width = 25
        Height = 20
        BitmapAlign = baTopLeft
        Color = clBtnFace
        ParentColor = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        TabOrder = 5
      end
      object cmdBrowseGridlines: TButton
        Left = 256
        Top = 80
        Width = 25
        Height = 20
        Caption = '...'
        TabOrder = 6
        OnClick = cmdBrowseGridlinesClick
      end
      object chkShowGridlinesByDefault: TCheckBox
        Left = 8
        Top = 104
        Width = 161
        Height = 17
        Caption = 'Show Gridlines By Default'
        TabOrder = 7
      end
      object chkDrawTransparentIcons: TCheckBox
        Left = 8
        Top = 124
        Width = 145
        Height = 17
        Caption = 'Draw Transparent Icons'
        TabOrder = 8
      end
      object txtIconTransparency: TSpinEdit
        Left = 272
        Top = 124
        Width = 121
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
    end
    object tshEmulatorSettings: TTabSheet
      Caption = 'Emulator Settings'
      ImageIndex = 1
      object lblEmulatorPath: TLabel
        Left = 8
        Top = 8
        Width = 71
        Height = 13
        Caption = 'Emulator Path:'
      end
      object rdgEmuFileSettings: TRadioGroup
        Left = 8
        Top = 32
        Width = 449
        Height = 41
        Caption = 'Emulator Filename Settings'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Normal'
          'Use 8.3 DOS Filename'
          'Surround with quotes')
        TabOrder = 0
      end
      object txtEmulatorPath: TEdit
        Left = 88
        Top = 8
        Width = 329
        Height = 21
        TabOrder = 1
      end
      object cmdBrowse: TButton
        Left = 424
        Top = 8
        Width = 33
        Height = 21
        Caption = '. . .'
        TabOrder = 2
        OnClick = cmdBrowseClick
      end
      object chkDisplayEmulatorSaveWarning: TCheckBox
        Left = 8
        Top = 80
        Width = 185
        Height = 17
        Caption = 'Display Emulator Save Warning'
        TabOrder = 3
      end
    end
    object tshIPS: TTabSheet
      Caption = 'IPS'
      ImageIndex = 3
      object lblOriginalFile: TLabel
        Left = 8
        Top = 8
        Width = 111
        Height = 13
        Caption = 'Original ROM Filename:'
      end
      object lblSaveAsIPS: TLabel
        Left = 8
        Top = 40
        Width = 61
        Height = 13
        Caption = 'Save IPS as:'
      end
      object lblIPSNoteSaveAs: TLabel
        Left = 128
        Top = 64
        Width = 292
        Height = 26
        Caption = 
          '(If left unspecified, IPS is dumped to the same directory and '#13#10 +
          'with same name as ROM)'
      end
      object txtOriginalROMFilename: TEdit
        Left = 128
        Top = 8
        Width = 289
        Height = 21
        TabOrder = 0
      end
      object cmdIPSBrowse: TButton
        Left = 424
        Top = 8
        Width = 33
        Height = 21
        Caption = '. . .'
        TabOrder = 1
        OnClick = cmdIPSBrowseClick
      end
      object grpPatching: TGroupBox
        Left = 8
        Top = 120
        Width = 449
        Height = 65
        Caption = 'Patching Facilities Provided By:'
        TabOrder = 2
        object imgLunarIPS: TImage
          Left = 8
          Top = 16
          Width = 32
          Height = 32
          AutoSize = True
          Picture.Data = {
            07544269746D61705E060000424D5E0600000000000036040000280000002000
            000020000000010008000100000028020000130B0000130B0000000100000001
            000000000000CECECE004A4AFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF000C0108000C0100000C0108000C0100000801040008020400080100000801
            0400080204000801000006010100010010020100010006010000060101000100
            1002010001000601000004010100010014020100010004010000040101000100
            140201000100040100000004010100000C020600060200040000010100000004
            010100000C020600060200040000010100000101010106000602010001000602
            0100010004020004000001010000010101010600060201000100060201000100
            0402000400000101000008010400000402020000080201000100040201000100
            00000801040000040202000008020100010004020100010000000C0101000100
            10020100010000000C010100010010020100010000000E01000A000002020000
            0202000006020100010000000E01000A00000202000002020000060201000100
            00000E01000A0000020200000202000006020100010000000E01000A00000202
            00000202000006020100010000000E01000A0000020200000202000004020004
            0000010100000E01000A00000202000002020000040200040000010100000C01
            010001000E0200040000010100000C01010001000E0200040000010100000C01
            010001000C0201000100040100000C01010001000C0201000100040100000A01
            010001000C0201000100060100000A01010001000C0201000100060100000801
            010001000A020400080100000801010001000A0204000801000008010C000C01
            000008010C000C010001}
          Transparent = True
        end
        object lblLunarCompress: TLabel
          Left = 56
          Top = 16
          Width = 100
          Height = 13
          Caption = 'Lunar Compress.dll v'
        end
        object lblFuSoYa: TLabel
          Left = 56
          Top = 40
          Width = 302
          Height = 13
          Caption = 'Created by FuSoYa (c) 2003,2004 http://fusoya.cg-games.net'
        end
      end
      object txtSaveAsIPS: TEdit
        Left = 128
        Top = 40
        Width = 289
        Height = 21
        TabOrder = 3
      end
      object cmdBrowseIPSSaveAs: TButton
        Left = 424
        Top = 40
        Width = 33
        Height = 21
        Caption = '. . .'
        TabOrder = 4
        OnClick = cmdBrowseIPSSaveAsClick
      end
    end
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 376
    Top = 120
  end
  object OpenDialog: TOpenDialog
    Filter = 'NES Emulator (*.exe)|*.exe'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Please select a NES emulator'
    Left = 408
    Top = 120
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.ips'
    Filter = 'IPS File (*.ips)|*.ips'
    Title = 'Please select the name of your IPS file'
    Left = 444
    Top = 120
  end
end
