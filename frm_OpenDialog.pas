unit frm_OpenDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, FileCtrl, Buttons,shlobj, JCLShell, JvExStdCtrls, JvCombobox,
  JvDriveCtrls, JvListBox;

type
  TfrmOpenDialog = class(TForm)
    lblFilter: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdMyDocuments: TBitBtn;
    cmdDesktop: TBitBtn;
    cmdApplicationDirectory: TBitBtn;
    lblOpenAs: TLabel;
    cbDataFile: TComboBox;
    chkAutoCheckROMType: TCheckBox;
    DirectoryListBox: TJvDirectoryListBox;
    FileListBox: TJvFileListBox;
    DriveComboBox: TJvDriveCombo;
    cbFilter: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdMyDocumentsClick(Sender: TObject);
    procedure cmdMyComputerClick(Sender: TObject);
    procedure cmdDesktopClick(Sender: TObject);
    procedure cmdApplicationDirectoryClick(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
  private
    procedure LoadDataFiles();
    { Private declarations }
  public
    Filename,OpenDir,DataFile : String;
    AutoCheck : Boolean;
    { Public declarations }
  end;

var
  frmOpenDialog: TfrmOpenDialog;

implementation

{$R *.dfm}

uses Unit_Global;

procedure TfrmOpenDialog.FormShow(Sender: TObject);
begin
  LoadDataFiles();
  chkAutoCheckROMType.Checked := RNAOptions.AutoCheck;
  cbDataFile.ItemIndex := cbDataFile.Items.IndexOf(RNAOptions.DataFileName);
  DirectoryListBox.Directory := OpenDir;

end;

procedure TfrmOpenDialog.LoadDataFiles();
begin
  cbDataFile.Items.Clear;
  cbDataFile.Items.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');
end;

procedure TfrmOpenDialog.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    close;
end;

procedure TfrmOpenDialog.cmdOKClick(Sender: TObject);
begin
  if FileExists(FileListBox.Filename) = true then
  begin
    Filename := FileListBox.Filename;
    DataFile := ExtractFileDir(Application.ExeName) + '\Data\' + cbDataFile.Items[cbDataFile.ItemIndex];
    AutoCheck := chkAutoCheckROMType.Checked;
    modalresult := mrOK;
  end
  else
    messagebox(handle,'Please select a valid file.',PChar(Application.Title),0);
end;

procedure TfrmOpenDialog.cmdMyDocumentsClick(Sender: TObject);
begin
  DirectoryListBox.Directory := GetSpecialFolderLocation(CSIDL_PERSONAL);

end;

procedure TfrmOpenDialog.cmdMyComputerClick(Sender: TObject);
begin
  DirectoryListBox.Directory := GetSpecialFolderLocation(CSIDL_DRIVES);
end;

procedure TfrmOpenDialog.cmdDesktopClick(Sender: TObject);
begin
  DirectoryListBox.Directory := GetSpecialFolderLocation(CSIDL_DESKTOP);
end;

procedure TfrmOpenDialog.cmdApplicationDirectoryClick(Sender: TObject);
begin
  DirectoryListBox.Directory := ExtractFileDir(Application.ExeName);
end;

procedure TfrmOpenDialog.cbFilterChange(Sender: TObject);
begin
  if cbFilter.ItemIndex = 0 then
    FileListBox.Mask := '*.nes'
  else
    FileListBox.Mask := '*.*';
end;

end.
