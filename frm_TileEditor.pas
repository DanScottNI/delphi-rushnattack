unit frm_TileEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32, GR32_Image, GR32_layers,StdCtrls;

type
  Tfrm8x8TileEditor = class(TForm)
    imgTile: TImage32;
    imgAvailPal: TImage32;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure imgTileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgTileMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure imgAvailPalMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure cmdOKClick(Sender: TObject);
  private
    SelPalLeft,SelPalRight : Byte;
    procedure Draw8x8Tile;
    procedure DisplayPalette;
    { Private declarations }
  public
    TileID : Integer;
    { Public declarations }
  end;

var
  frm8x8TileEditor: Tfrm8x8TileEditor;


implementation

uses unit_global, classes_Graphics;

var
  DaTile : T8x8Graphic;

{$R *.dfm}

procedure Tfrm8x8TileEditor.FormShow(Sender: TObject);
begin
  DaTile := RNAROM.Export8x8Pat(TileID);
//  showmessage(IntToStr(DaTile.Pixels[0,0]));
  Draw8x8Tile();
  DisplayPalette();
end;

procedure Tfrm8x8TileEditor.DisplayPalette();
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 40;
    TempBitmap.Height := 25;
    TempBitmap.FillRect(0,0,10,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[RNAOptions.LastPaletteTileEditor,0]));
    TempBitmap.FillRect(10,0,20,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[RNAOptions.LastPaletteTileEditor,1]));
    TempBitmap.FillRect(20,0,30,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[RNAOptions.LastPaletteTileEditor,2]));
    TempBitmap.FillRect(30,0,40,25, RNAROM.ReturnColor32NESPal(RNAROM.Palette[RNAOptions.LastPaletteTileEditor,3]));
    if SelPalLeft = SelPalRight then
    begin
      TempBitmap.Line(SelPalLeft*10,0,SelPalLeft*10, 25,RNAOptions.LeftTextColour);
      TempBitmap.Line(SelPalLeft*10,0,SelPalLeft*10 + 10,0,RNAOptions.LeftTextColour);
      TempBitmap.Line(SelPalRight*10 + 9,1,SelPalRight*10 + 9,25,RNAOptions.MiddleTextColour);
      TempBitmap.Line(SelPalRight*10,24,SelPalRight*10 + 9,24,RNAOptions.MiddleTextColour);      
//      TempBitmap.Line(SelPalRight*10 + 0,SelPalRight*32+31,32,SelPalRight* 32+31,RNAOptions.MiddleTextColour);
//      TempBitmap.FrameRectS(SelPalLeft * 10,0,SelPalLeft * 10 + 10,25,RNAOptions.LeftTextColour);
//      TempBitmap.FrameRectS(SelPalRight * 10,0,SelPalRight * 10 + 10,25,RNAOptions.MiddleTextColour);
    end
    else
    begin
      TempBitmap.FrameRectS(SelPalLeft * 10,0,SelPalLeft * 10 + 10,25,RNAOptions.LeftTextColour);
      TempBitmap.FrameRectS(SelPalRight * 10,0,SelPalRight * 10 + 10,25,RNAOptions.MiddleTextColour);
    end;
    imgAvailPal.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure Tfrm8x8TileEditor.Draw8x8Tile();
var
  i,x : Integer;
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 8;
    TempBitmap.Height := 8;
    for x := 0 to 7 do
      for i := 0 to 7 do
        TempBitmap.Pixel[x,i] := RNAROM.ReturnColor32NESPal(RNAROM.Palette[RNAOptions.LastPaletteTileEditor,DaTile.Pixels[i,x]]);
    imgTile.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure Tfrm8x8TileEditor.imgTileMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if Button = mbLeft then
  begin
    if (y div 20 > 7) or (x div 20 > 7) then exit;
    DaTile.Pixels[Y div 20,X div 20] := SelPalLeft;
    Draw8x8Tile();
  end
  else if Button = mbRight then
  begin
    if (y div 20 > 7) or (x div 20 > 7) then exit;
    DaTile.Pixels[Y div 20,X div 20] := SelPalRight;
    Draw8x8Tile();
  end;
end;

procedure Tfrm8x8TileEditor.imgTileMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  if ssLeft in Shift then
  begin
    if x < 0 then exit;  
    if (y div 20 > 7) or (x div 20 > 7) then exit;
    DaTile.Pixels[Y div 20,X div 20] := SelPalLeft;
    Draw8x8Tile();
  end
  else if ssRight in Shift then
  begin
    if x < 0 then exit;
    if (y div 20 > 7) or (x div 20 > 7) then exit;
    DaTile.Pixels[Y div 20,X div 20] := SelPalRight;
    Draw8x8Tile();
  end;
end;

procedure Tfrm8x8TileEditor.imgAvailPalMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if button = mbLeft then
  begin
    SelPalLeft := X div 20;
    DisplayPalette();
  end
  else if Button = mbRight then
  begin
    SelPalRight := X div 20;
    DisplayPalette();
  end
  else if Button = mbMiddle then
  begin
    if RNAOptions.LastPaletteTileEditor = 3 then
      RNAOptions.LastPaletteTileEditor := 0
    else
      RNAOptions.LastPaletteTileEditor := RNAOptions.LastPaletteTileEditor +1;

    DisplayPalette;
    Draw8x8Tile();
  end;
end;

procedure Tfrm8x8TileEditor.cmdOKClick(Sender: TObject);
begin
  RNAROM.Import8x8Pat(TileID,DaTile);
end;

end.
