unit frm_ROMProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmROMProperties = class(TForm)
    lblPlayer1Lives: TLabel;
    lblPlayer2Lives: TLabel;
    txtPlayer1Lives: TEdit;
    txtPlayer2Lives: TEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmROMProperties: TfrmROMProperties;

implementation

{$R *.dfm}

uses Unit_Global;

procedure TfrmROMProperties.FormShow(Sender: TObject);
begin
  txtPlayer1Lives.Text := IntToStr(RNAROM.Player1Lives);
  txtPlayer2Lives.Text := IntToStr(RNAROM.Player2Lives);
end;

procedure TfrmROMProperties.cmdOKClick(Sender: TObject);
begin
  RNAROM.Player1Lives := StrToInt(txtPlayer1Lives.Text);
  RNAROM.Player2Lives := StrToInt(txtPlayer2Lives.Text);
end;

end.
