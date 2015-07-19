unit frm_Prop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmProperties = class(TForm)
    lblFilename: TLabel;
    lblMemoryMapper: TLabel;
    lblPRGCount: TLabel;
    lblCHRCount: TLabel;
    lblFileSize: TLabel;
    txtFilename: TEdit;
    cmdOK: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProperties: TfrmProperties;

implementation

{$R *.dfm}

uses unit_Global;

procedure TfrmProperties.FormShow(Sender: TObject);
begin
  txtFilename.Text := RNAROM.Filename;
  lblCHRCount.Caption := 'CHR Count: ' + IntToStr(RNAROM.CHRCount);
  lblPRGCount.Caption := 'PRG Count: ' + IntToStr(RNAROM.PRGCount);
  lblMemoryMapper.Caption := 'Memory Mapper: ' + IntToStr(RNAROM.MemoryMapper) + ' (' + RNAROM.MemoryMapperStr + ')';
  lblFilesize.Caption := 'File Size: ' + IntToStr(RNAROM.FileSize) + ' bytes';
end;

end.
