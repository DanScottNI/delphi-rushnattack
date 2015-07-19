unit frm_EnemyProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmEnemyProperties = class(TForm)
    lblID: TLabel;
    txtID: TEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    lblEnemyName: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtIDKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    _ID : Integer;
    { Private declarations }
  public
    property ID : Integer read _ID write _ID;
    { Public declarations }
  end;

var
  frmEnemyProperties: TfrmEnemyProperties;

implementation

uses unit_global;

{$R *.dfm}

procedure TfrmEnemyProperties.FormShow(Sender: TObject);
begin
  txtID.Text := IntToHex(RNAROM.Levels[RNAROM.level].ScreenEnemies[_ID].ID,2);
  lblEnemyName.Caption := 'Name: ' + RNAROM.EnemyNames[RNAROM.Levels[RNAROM.level].ScreenEnemies[_ID].ID];
end;

procedure TfrmEnemyProperties.cmdOKClick(Sender: TObject);
begin
  if StrToInt('$' + txtID.Text) > $FE then
    txtID.Text := 'FE';
  if StrToInt('$' + txtID.Text) < $01 then
    txtID.Text := '01';
  RNAROM.Levels[RNAROM.level].ScreenEnemies[_ID].ID := StrToInt('$' + txtID.Text);
end;

procedure TfrmEnemyProperties.txtIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #8 then
    exit;
  if ord(key) < 48 then
    key := #0;
  if (ord(key) < 65) and (ord(key) > 57) then
    key := #0;
  if (ord(key) < 97) and (ord(key) > 70) then
    key := #0;
  if ord(key) > 102 then
    key := #0;
    
end;

procedure TfrmEnemyProperties.txtIDKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(txtID.Text) > 0 then
    lblEnemyName.Caption := 'Name: ' + RNAROM.EnemyNames[StrToInt('$' + txtID.Text)];
end;

end.
