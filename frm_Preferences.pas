unit frm_Preferences;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, GR32_Image, GR32, ComCtrls;

type
  TfrmPreferences = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdRestoreDefaults: TButton;
    pgcPreferences: TPageControl;
    tshGeneral: TTabSheet;
    tshEmulatorSettings: TTabSheet;
    rdgEmuFileSettings: TRadioGroup;
    txtEmulatorPath: TEdit;
    lblEmulatorPath: TLabel;
    cmdBrowse: TButton;
    chkDisplayEmulatorSaveWarning: TCheckBox;
    tshDisplayOptions: TTabSheet;
    chkShowLeftMidText: TCheckBox;
    lblLeftTextColour: TLabel;
    imgLeftText: TImage32;
    cmdBrowseLeft: TButton;
    ColorDialog: TColorDialog;
    cmdBrowseRight: TButton;
    imgRightText: TImage32;
    lblMiddleTextColour: TLabel;
    imgGridlineColour: TImage32;
    cmdBrowseGridlines: TButton;
    chkShowGridlinesByDefault: TCheckBox;
    OpenDialog: TOpenDialog;
    lblGridlineColour: TLabel;
    cbDataFile: TComboBox;
    lblDatafile: TLabel;
    lblPalette: TLabel;
    cbPaletteFile: TComboBox;
    chkBackupFiles: TCheckBox;
    rdgWhenIncorrectMapper: TRadioGroup;
    chkAutoCheck: TCheckBox;
    tshIPS: TTabSheet;
    lblOriginalFile: TLabel;
    txtOriginalROMFilename: TEdit;
    cmdIPSBrowse: TButton;
    grpPatching: TGroupBox;
    lblSaveAsIPS: TLabel;
    txtSaveAsIPS: TEdit;
    cmdBrowseIPSSaveAs: TButton;
    lblIPSNoteSaveAs: TLabel;
    imgLunarIPS: TImage;
    lblLunarCompress: TLabel;
    lblFuSoYa: TLabel;
    SaveDialog: TSaveDialog;
    chkChangeToObjModeWhenAdd: TCheckBox;
    chkDrawTransparentIcons: TCheckBox;
    lblIconTransparency: TLabel;
    txtIconTransparency: TSpinEdit;
    procedure cmdBrowseLeftClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdBrowseRightClick(Sender: TObject);
    procedure cmdBrowseGridlinesClick(Sender: TObject);
    procedure cmdBrowseClick(Sender: TObject);
    procedure cmdRestoreDefaultsClick(Sender: TObject);
    procedure cmdIPSBrowseClick(Sender: TObject);
    procedure cmdBrowseIPSSaveAsClick(Sender: TObject);
  private
    procedure LoadPreferences();
    procedure SavePreferences();
    procedure LoadDataFiles();
    procedure LoadPaletteFiles();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPreferences: TfrmPreferences;

implementation

{$R *.dfm}

uses unit_global, unit_lunarcompress;

procedure TfrmPreferences.cmdBrowseLeftClick(Sender: TObject);
begin
  ColorDialog.Color := imgLeftText.Color;
  if ColorDialog.Execute then
  begin
    imgLeftText.Color := ColorDialog.Color;
  end;
end;

procedure TfrmPreferences.LoadPreferences();
begin
  imgLeftText.Color := WinColor(RNAOptions.LeftTextColour);
  imgRightText.Color := WinColor(RNAOptions.MiddleTextColour);
  imgGridlineColour.Color := WinColor(RNAOptions.GridlineColour);
  cbDataFile.ItemIndex := cbDataFile.Items.IndexOf(RNAOptions.DataFileName);
  cbPaletteFile.ItemIndex := cbPaletteFile.Items.IndexOf(RNAOptions.Palette);
  if cbPaletteFile.ItemIndex = -1 then
    cbPaletteFile.ItemIndex := 0;
  chkShowLeftMidText.Checked := RNAOptions.DispLeftMidText;
  chkShowGridlinesByDefault.Checked := RNAOptions.GridlinesOnByDefault;
  chkBackupFiles.Checked := RNAOptions.BackupFilesWhenSaving;
  chkDisplayEmulatorSaveWarning.Checked := RNAOptions.EmulatorDisplaySaveWarning;
  rdgEmuFileSettings.ItemIndex := RNAOptions.EmulatorFileSettings;
  txtEmulatorPath.Text := RNAOptions.EmulatorPath;
  chkDrawTransparentIcons.Checked := RNAOptions.DrawTransparentIcons;
  txtIconTransparency.Value := RNAOptions.IconTransparency;
  rdgWhenIncorrectMapper.ItemIndex := RNAOptions.MapperWarnings;
  chkAutoCheck.Checked := RNAOptions.AutoCheck;
  txtOriginalROMFilename.Text := RNAOptions.OriginalROMFile;
  txtSaveAsIPS.Text := RNAOptions.IPSOutput;
  chkChangeToObjModeWhenAdd.Checked := RNAOptions.ChangeToObjectModeWhenAddingEnemy;
end;

procedure TfrmPreferences.SavePreferences();
begin
  RNAOptions.LeftTextColour := Color32(imgLeftText.Color);
  RNAOptions.MiddleTextColour := Color32(imgRightText.Color);
  RNAOptions.GridlineColour := Color32(imgGridlineColour.Color);
  RNAOptions.DataFileName := cbDataFile.Items[cbDataFile.ItemIndex];
  RNAOptions.Palette := cbPaletteFile.Items[cbPaletteFile.ItemIndex];
  RNAOptions.DispLeftMidText := chkShowLeftMidText.Checked;
  RNAOptions.GridlinesOnByDefault := chkShowGridlinesByDefault.Checked;
  RNAOptions.BackupFilesWhenSaving := chkBackupFiles.Checked;
  RNAOptions.EmulatorDisplaySaveWarning := chkDisplayEmulatorSaveWarning.Checked;
  RNAOptions.EmulatorFileSettings := rdgEmuFileSettings.ItemIndex;
  RNAOptions.EmulatorPath := txtEmulatorPath.Text;
  RNAOptions.DrawTransparentIcons := chkDrawTransparentIcons.Checked;
  RNAOptions.IconTransparency := txtIconTransparency.Value;
  RNAOptions.MapperWarnings :=rdgWhenIncorrectMapper.ItemIndex;
  RNAOptions.AutoCheck := chkAutoCheck.Checked;
  RNAOptions.OriginalROMFile := txtOriginalROMFilename.Text;
  RNAOptions.IPSOutput := txtSaveAsIPS.Text;
  RNAOptions.ChangeToObjectModeWhenAddingEnemy := chkChangeToObjModeWhenAdd.Checked;
end;

procedure TfrmPreferences.FormShow(Sender: TObject);
begin
  if Assigned(RNAROM) = False then
  begin
    cbDataFile.Enabled := True;
    lblDataFile.Enabled := True;
  end
  else
  begin
    cbDataFile.Enabled := False;
    lblDataFile.Enabled := False;
  end;

  LoadPaletteFiles();
  LoadDataFiles();

  LoadPreferences;
  lblLunarCompress.Caption := 'Lunar Compress.dll v'+ FloatToStr(LunarVersion / 100);
end;

procedure TfrmPreferences.cmdOKClick(Sender: TObject);
begin
  SavePreferences;
end;

procedure TfrmPreferences.cmdBrowseRightClick(Sender: TObject);
begin
  ColorDialog.Color := imgRightText.Color;
  if ColorDialog.Execute then
  begin
    imgRightText.Color := ColorDialog.Color;
  end;
end;

procedure TfrmPreferences.cmdBrowseGridlinesClick(Sender: TObject);
begin
  ColorDialog.Color := imgGridlineColour.Color;
  if ColorDialog.Execute then
  begin
    imgGridlineColour.Color := ColorDialog.Color;
  end;
end;

procedure TfrmPreferences.cmdBrowseClick(Sender: TObject);
begin
  OpenDialog.Title := 'Please select a NES emulator';
  OpenDialog.Filter := 'NES Emulator (*.exe)|*.exe';
  if (txtEmulatorPath.Text <> '') and (DirectoryExists(ExtractFileDir(txtEmulatorPath.Text))) then
    OpenDialog.InitialDir := ExtractFileDir(txtEmulatorPath.Text);

  if OpenDialog.Execute then
  begin
    if (OpenDialog.FileName <> '') and (FileExists(OpenDialog.Filename)) then
    begin
      txtEmulatorPath.Text := OpenDialog.FileName;
      txtEmulatorPath.SelStart := Length(txtEmulatorPath.Text);
    end;
  end;
end;

procedure TfrmPreferences.cmdRestoreDefaultsClick(Sender: TObject);
begin
  RNAOptions.LoadDefaultSettings;
  RNAOptions.Save;
  LoadPreferences;
end;

procedure TfrmPreferences.LoadDataFiles();
{var
  sr: TSearchRec;}
begin

  cbDataFile.Items.Clear;

  {if FindFirst(ExtractFileDir(Application.ExeName)+ '\Data\*.ini', faAnyFile, sr) = 0 then
  begin
    repeat
      cbDataFile.Items.Add(sr.Name);

    until FindNext(sr) <> 0;
    FindClose(sr);
  end;}

  cbDataFile.Items.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');
end;

procedure TfrmPreferences.LoadPaletteFiles();
var
  sr: TSearchRec;
begin

  cbPaletteFile.Items.Clear;

  if FindFirst(ExtractFileDir(Application.ExeName)+ '\Palettes\*.pal', faAnyFile, sr) = 0 then
  begin
    repeat
      cbPaletteFile.Items.Add(sr.Name);

    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

//  cbPaletteFile.Items.LoadFromFile(ExtractFileDir(Application.Exename) + '\Palettes\pal.dat');
end;

procedure TfrmPreferences.cmdIPSBrowseClick(Sender: TObject);
begin

  OpenDialog.Title := 'Select an original unmodified Rush''n Attack ROM';
  OpenDialog.Filter := 'iNES Image (*.nes)|*.nes';

  if (txtOriginalROMFilename.Text <> '') and (DirectoryExists(ExtractFileDir(txtOriginalROMFilename.Text))) then
    OpenDialog.InitialDir := ExtractFileDir(txtOriginalROMFilename.Text)
  else
    OpenDialog.InitialDir := ExtractFileDir(Application.ExeName);

  if OpenDialog.Execute then
  begin
    if (OpenDialog.FileName <> '') and (FileExists(OpenDialog.Filename)) then
    begin
      txtOriginalROMFilename.Text := OpenDialog.FileName;
      txtOriginalROMFilename.SelStart := Length(txtOriginalROMFilename.Text);
    end;
  end;

end;

procedure TfrmPreferences.cmdBrowseIPSSaveAsClick(Sender: TObject);
begin
  if (txtSaveAsIPS.Text <> '') and (DirectoryExists(ExtractFileDir(txtSaveAsIPS.Text))) then
    SaveDialog.InitialDir := ExtractFileDir(txtSaveAsIPS.Text)
  else
    SaveDialog.InitialDir := ExtractFileDir(Application.ExeName);

  if SaveDialog.Execute then
  begin
    txtSaveAsIPS.Text := SaveDialog.FileName;
    txtSaveAsIPS.SelStart := Length(txtSaveAsIPS.Text);
  end;
end;

end.
