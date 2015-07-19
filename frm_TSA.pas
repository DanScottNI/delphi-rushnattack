unit frm_TSA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, GR32, GR32_Layers, GR32_Image, ComCtrls;

type
  TfrmTSAEditor = class(TForm)
    imgTSA: TImage32;
    StatusBar: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure imgTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgTSAMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
  private
    TileX, TileY : Integer;
    { Private declarations }
  public
    procedure DrawPatternTable;  
    { Public declarations }
  end;

var
  frmTSAEditor: TfrmTSAEditor;

implementation

uses unit_Global,frm_RushNAttackMain, frm_TileEditor;

{$R *.dfm}

procedure TfrmTSAEditor.DrawPatternTable();
var
  TSA : TBitmap32;
begin
  TSA := TBitmap32.Create;
  try
    TSA.Width := 128;
    TSA.Height := 128;
    RNAROM.DrawPatternTable(TSA,RNAOptions.LastPaletteTSA);
    TSA.FrameRectS(TileX,TileY,TileX+8,TileY + 8,clRed32);
    imgTSA.Bitmap := TSA;
  finally
    FreeAndNil(TSA);
  end;
end;

procedure TfrmTSAEditor.FormShow(Sender: TObject);
begin
  DrawPatternTable();
  frmRushNAttackEditor.CurTSABlock := 0;
end;

procedure TfrmTSAEditor.imgTSAMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  Tile : Integer;
  TilEd : Tfrm8x8TileEditor;
begin
  if (Button = mbMiddle) or ((ssShift in Shift) and (Button = mbLeft)) then
  begin
    Tile := ((y div 16) * 16 * 16) + ((X div 16) * 16);
    TileX := (X div 16) * 8;
    TileY := (y div 16) * 8;
    //showmessage(IntToStr(Y));
    frmRushNAttackEditor.CurTSABlock := Tile div 16;
    TilEd := Tfrm8x8TileEditor.Create(self);
    try
      TilEd.TileID := frmRushNAttackEditor.CurTSABlock;
      DrawPatternTable();      
      TilEd.ShowModal;
      if TilEd.ModalResult = mrOK then
      begin
        DrawPatternTable();
        RNAROM.SavePatternTable();
        frmRushNAttackEditor.RedrawScreen;
        frmRushNAttackEditor.UpdateTitleCaption;
      end;
    finally
      FreeAndNil(TilEd);
    end;
  end
  else if button = mbLeft then
  begin
    Tile := ((y div 16) * 16 * 16) + ((X div 16) * 16);
    TileX := (X div 16) * 8;
    TileY := (y div 16) * 8;
    //showmessage(IntToStr(Y));
    frmRushNAttackEditor.CurTSABlock := Tile div 16;
  end
  else if button = mbRight then
  begin
    if RNAOptions.LastPaletteTSA = 3 then
      RNAOptions.LastPaletteTSA := 0
    else
      RNAOptions.LastPaletteTSA := RNAOptions.LastPaletteTSA + 1;
  end;
  DrawPatternTable();

end;

procedure TfrmTSAEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmRushNAttackEditor.CurTSABlock := -1;
  Action := caFree;
end;

procedure TfrmTSAEditor.imgTSAMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  StatusBar.Panels[0].Text := 'Selected: ' + IntToHex(frmRushNAttackEditor.CurTSABlock,2);
  StatusBar.Panels[1].Text := IntToHex((((y div 16) * 16 * 16) + ((X div 16) * 16)) div 16,2);
end;

end.
