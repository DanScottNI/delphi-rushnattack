unit frm_JumpTo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmJumpTo = class(TForm)
    lblSelectText: TLabel;
    lstLevels: TListBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    _SelectedLevel : Byte;
    { Private declarations }
  public
    property SelectedLevel : Byte read _SelectedLevel write _SelectedLevel;
    { Public declarations }
  end;

var
  frmJumpTo: TfrmJumpTo;

implementation

{$R *.dfm}

uses unit_Global;

procedure TfrmJumpTo.FormShow(Sender: TObject);
var
  i : Integer;
begin
  lstLevels.Items.BeginUpdate;
  for i := 0 to RNAROM.Levels.Count - 1 do
    lstLevels.Items.Add('Level ' + IntToStr(i + 1));
  lstLevels.Items.EndUpdate;
  lstLevels.ItemIndex := RNAROM.Level;
end;

procedure TfrmJumpTo.cmdOKClick(Sender: TObject);
begin
  SelectedLevel := lstLevels.ItemIndex;
  if SelectedLevel = RNAROM.Level then
    modalresult := mrCancel;
end;

end.
