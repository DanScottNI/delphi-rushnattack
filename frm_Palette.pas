unit frm_Palette;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_Image, GR32, GR32_Layers;

type
  TfrmPaletteEditor = class(TForm)
    lbl000F: TLabel;
    lbl101F: TLabel;
    lbl202F: TLabel;
    lbl303F: TLabel;
    lblCurrentPalette: TLabel;
    imgLevelPal1: TImage32;
    imgLevelPal2: TImage32;
    imgLevelPal3: TImage32;
    imgLevelPal4: TImage32;
    imgNESColours: TImage32;
    cmdOK: TButton;
    cmdCancel: TButton;
    lblLevelPalette: TLabel;
    imgSprPal1: TImage32;
    imgSprPal2: TImage32;
    imgSprPal3: TImage32;
    imgSprPal4: TImage32;
    lblSpritePalette: TLabel;
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgNESColoursMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer; Layer: TCustomLayer);
    procedure imgNESColoursMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelPal1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelPal2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelPal3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelPal4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgSprPal1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgSprPal2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgSprPal3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgSprPal4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    TileX, TileY : Integer;
    CurColour : Byte;
    procedure DrawNESColours;
    procedure DisplayPalette;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPaletteEditor: TfrmPaletteEditor;

implementation

uses unit_Global, frm_RushNAttackMain;

{$R *.dfm}

procedure TfrmPaletteEditor.cmdOKClick(Sender: TObject);
begin
  RNAROM.SaveCurrentPalette;
end;

procedure TfrmPaletteEditor.cmdCancelClick(Sender: TObject);
begin
  RNAROM.LoadCurrentPalette;
  frmRushNAttackEditor.RedrawScreen;
end;

procedure TfrmPaletteEditor.DrawNESColours();
var
  i,x : Integer;
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 287;
    TempBitmap.Height := 74;

    for i := 0 to 3 do
      for x :=0 to 15 do
        TempBitmap.FillRect(x*18,i*18 + 1,(x*18)+17,i*18+18,RNAROM.ReturnColor32NESPal((i*16) + x));

    tempbitmap.Line(0,0,0,74, clBlack32);


    if TileX = 0 then
      TempBitmap.FrameRectS(TileX,TileY,TileX+18,TileY+19,clRed32)

    else
      TempBitmap.FrameRectS(TileX-1,TileY,TileX+18,TileY+19,clRed32);

    imgNESColours.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmPaletteEditor.DisplayPalette();
var
  TempBitmap : TBitmap32;
  i : Integer;
begin
  TempBitmap := TBitmap32.Create;
  try
    with TempBitmap do
    begin
      Width := 100;
      Height := 25;
      imgLevelPal1.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[0,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgLevelPal1.Hint := imgLevelPal1.Hint + '$' + IntToHex(RNAROM.Palette[0,i],2)  + ' ';
      end;
      imgLevelPal1.Hint := TrimRight(imgLevelPal1.Hint);
      imgLevelPal1.Bitmap := TempBitmap;

      imgLevelPal2.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[1,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgLevelPal2.Hint := imgLevelPal2.Hint + '$' + IntToHex(RNAROM.Palette[1,i],2)  + ' ';
      end;
      imgLevelPal2.Hint := TrimRight(imgLevelPal2.Hint);
      imgLevelPal2.Bitmap := TempBitmap;

      imgLevelPal3.Hint := '';

      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[2,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgLevelPal3.Hint := imgLevelPal3.Hint + '$' + IntToHex(RNAROM.Palette[2,i],2)  + ' ';
      end;
      imgLevelPal3.Hint := TrimRight(imgLevelPal3.Hint);
      imgLevelPal3.Bitmap := TempBitmap;

      imgLevelPal4.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[3,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgLevelPal4.Hint := imgLevelPal4.Hint + '$' + IntToHex(RNAROM.Palette[3,i],2)  + ' ';
      end;
      imgLevelPal4.Hint := TrimRight(imgLevelPal4.Hint);
      imgLevelPal4.Bitmap := TempBitmap;

      // Sprite Palette
      imgSprPal1.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[4,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgSprPal1.Hint := imgSprPal1.Hint + '$' + IntToHex(RNAROM.Palette[4,i],2)  + ' ';
      end;
      imgSprPal1.Hint := TrimRight(imgSprPal1.Hint);
      imgSprPal1.Bitmap := TempBitmap;

      // Sprite Palette
      imgSprPal2.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[5,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgSprPal2.Hint := imgSprPal2.Hint + '$' + IntToHex(RNAROM.Palette[5,i],2)  + ' ';
      end;
      imgSprPal2.Hint := TrimRight(imgSprPal2.Hint);
      imgSprPal2.Bitmap := TempBitmap;

      // Sprite Palette
      imgSprPal3.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[6,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgSprPal3.Hint := imgSprPal1.Hint + '$' + IntToHex(RNAROM.Palette[6,i],2)  + ' ';
      end;
      imgSprPal3.Hint := TrimRight(imgSprPal3.Hint);
      imgSprPal3.Bitmap := TempBitmap;

      // Sprite Palette
      imgSprPal4.Hint := '';
      for i := 0 to 3 do
      begin
        FillRect(i * 25,0,i *25 + 25,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[7,i]) );
        FrameRectS(i * 25,0,i * 25 + 25,25,clBlack32);
        imgSprPal4.Hint := imgSprPal4.Hint + '$' + IntToHex(RNAROM.Palette[7,i],2)  + ' ';
      end;
      imgSprPal4.Hint := TrimRight(imgSprPal4.Hint);
      imgSprPal4.Bitmap := TempBitmap;

    end;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmPaletteEditor.FormShow(Sender: TObject);
begin
  DrawNESColours();
  DisplayPalette();
end;

procedure TfrmPaletteEditor.imgNESColoursMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  lblCurrentPalette.Caption := 'Current Palette Colour: $' + IntToHex(((X div 18) + (Y div 18) * 16),2);
end;

procedure TfrmPaletteEditor.imgNESColoursMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  CurColour := ((X div 18) + (Y div 18) * 16);
  TileX := (X div 18) * 18;
  TileY := (y div 18) * 18;
  DrawNESColours();
end;

procedure TfrmPaletteEditor.imgLevelPal1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[0, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgLevelPal2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[1, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgLevelPal3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[2, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgLevelPal4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin

  RNAROM.Palette[3, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();

end;

procedure TfrmPaletteEditor.imgSprPal1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[4, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgSprPal2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[5, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgSprPal3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[6, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

procedure TfrmPaletteEditor.imgSprPal4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  RNAROM.Palette[7, x div 25] := CurColour;
  DisplayPalette();
  frmRushNAttackEditor.RedrawScreen();
end;

end.
