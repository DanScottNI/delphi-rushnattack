unit classes_RNAROM;

interface

uses Dialogs,SysUtils, Contnrs, INIFiles, Classes, iNESImage,
  GR32,types, MemINIHexFile, classes_Graphics, classes_level, forms;

type

  { This class is designed to store general stuff, such
    as the level data array, and crap like that. }
  TRushNAttackImage = class
  private
    _DrawBlock : Array [0..255] of Boolean;
    _Palette : Array [0..7,0..3] of Byte;
    _PatternTable : Array [0.. 4095] of Byte;
    _TextOffset : Integer;
    _Tiles : TBitmap32;
    _Level : Integer;
    _ScreenNumber : Integer;
    _LevelData : Array [0 .. 7, 0..5] of Byte;
    _Player1LivesOffset : Integer;
    _Player2LivesOffset : Integer;
    _EnemyDataStart : Integer;
    _EnemyDataMaxSize : Integer;    
    procedure LoadDataFile(pDataFileName : String);
    function GetMapperStatus: Boolean;
    function GetLevel: Integer;
    procedure SetLevel(const Value: Integer);
    procedure LoadScreenData;
    procedure SaveScreenData;
    procedure DrawLevelTile(pTileNumber: Byte);
    procedure DrawPatternTableTile(pOffset: Integer; pBitmap: TBitmap32;
      pX, pY, pIndex: Integer);
    procedure LoadPatternTable;
    procedure DumpPatternTable(pFilename: String);
    function GetScreen: Integer;
    procedure SetScreen(const Value: Integer);
    function GetPal(index1, index2: Integer): Byte;
    procedure SetPal(index1, index2: Integer; const Value: Byte);
    function GetROMFilename: String;
    function GetCHRCount : Integer;
    function GetPRGCount : Integer;
    function GetMemMap : Integer;
    function GetFileSize : Integer;
    function GetMemMapName : String;
    function GetChanged: Boolean;
    procedure SetPlayer1Lives(pNewLives : Byte);
    procedure SetPlayer2Lives(pNewLives : Byte);
    function GetPlayer1Lives : Byte;
    function GetPlayer2Lives : Byte;
  public
    Levels : TLevelList;
    EnemyNames : TStringList;
    // Draw the tile selector, starting at pIndex.
    function DrawTileSelector(pIndex: Integer;
      pBitmap: TBitmap32): Boolean;
    // The constructor for the class.
    constructor Create(pROMFilename,pDataFileName,pPaletteFile : String);
    destructor Destroy;override;
    // Draw the current screen, as defined by the ScreenNumber property.
    procedure DrawCurrentScreen(pBitmap: TBitmap32;pIconTransparency : Boolean;pTransSetting : Byte;pDrawOpt : Byte);
    // Saves the pattern table after editing.
    procedure SavePatternTable;
    // Edits TSA.
    function EditTSA(pBlock, pTileIndex1, pTileIndex2: Integer;
      pNewTile: Byte): Integer;
    // Increments the block attributes, resetting to 0 if the attribute is at 3.
    function IncrementBlockAttributes(pBlock, pTileIndex1,
      pTileIndex2: Integer): Integer;
    // Edits a screen's tile.
    function EditLevel(pX, pY, pBlockNo: Integer): Boolean;
    // Retrieves the current level tile at pX and pY.
    function GetLevelTile(pY, pX: integer): Integer;
    // Exports a 8x8 graphic for the tile editor from the pattern table.
    function Export8x8Pat(pID: Integer): T8x8Graphic;
    // Returns the color32 in the NES palette array.
    function ReturnColor32NESPal(pIndex : Byte) : TColor32;
    // Returns the index of the selected enemy
    function GetCurrentEnemy(pX,pY : Integer): Integer;
    // Imports an 8x8 graphic from the tile editor into the pattern table.
    procedure Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
    // Slip 'N' Trip will redraw all the screen tiles, and the tile selector tiles.
    procedure RefreshOnScreenTiles(pTileSelectorValue: Byte);
    // Draw the pattern table.
    procedure DrawPatternTable(pBitmap: TBitmap32; pPal: Integer);
    // Save the current palette.
    procedure SaveCurrentPalette;
    // Load the current palette.
    procedure LoadCurrentPalette;
    // Save the entire ROM to disk.
    function Save : Boolean;
    // Sets a part of the palette array.
    property Palette[index1 : Integer; index2 : Integer] : Byte read GetPal write SetPal;
    // Detects whether this is a Rush 'N' Attack ROM by the Mapper.
    property IsRushNAttackROM : Boolean read GetMapperStatus;
    // The level that we are on.
    property Level : Integer read GetLevel write SetLevel;
    // The screen that we are on.
    property Screen : Integer read GetScreen write SetScreen;
    property Filename : String read GetROMFilename;
    property CHRCount : Integer read GetCHRCount;
    property PRGCount : Integer read GetPRGCount;
    property MemoryMapper : Integer read GetMemMap;
    property MemoryMapperStr : String read GetMemMapName;
    property FileSize : Integer read GetFileSize;
    property Changed : Boolean read GetChanged;
    procedure LoadPaletteFile(pFilename : String);
    procedure IncrementEnemyID(pID : Integer);
    procedure Increment10EnemyID(pID : Integer);
    procedure SetEnemyXY(pX,pY : SmallInt;pID : Integer);
    function GetEnemyXY(pXY : Byte; pID : Integer) : Integer;
    procedure LoadEnemyData();
    function SaveEnemyData(): Boolean;
    procedure LoadEnemyNames;
    procedure AddNewEnemy();
    procedure DeleteEnemy(pID : Integer);
    property Player1Lives : Byte read GetPlayer1Lives write SetPlayer1Lives;
    property Player2Lives : Byte read GetPlayer2Lives write SetPlayer2Lives;
  end;

implementation

uses classes_ROM;

const
  VIEWENEMIES : Byte = 1;
  UNKNOWNENEMY : String = '???';
{ TRushNAttackImage internal functions}

{ Public Functions }

constructor TRushNAttackImage.Create(pROMFilename, pDataFileName,pPaletteFile: String);
begin
  ROM := TiNESImage.Create(pROMFilename);
  ROM.LoadPaletteFile(pPaletteFile);
  self.LoadDataFile(pDataFileName);
  self._ScreenNumber := -1;

  _tiles := TBitmap32.Create;
  try
    _tiles.width := 8192;
    _tiles.Height := 32;
  except
    freeandNil(_Tiles);
  end;
  LoadEnemyNames;
  LoadEnemyData;

end;

procedure TRushNAttackImage.LoadEnemyNames;
var
  EnemyFile : TStringList;
  EnemyIndex : String;
  i, count : Integer;
begin
  if Assigned(EnemyNames) = True then
    FreeAndNil(EnemyNames);

  EnemyNames := TStringList.Create;

  for i := 0 to 255 do
    EnemyNames.Add(UNKNOWNENEMY);

  // Now load in the enemy names from the file 'enemy.dat' in the data directory.
  if FileExists(ExtractFileDir(Application.EXEName) + '\Data\enemy.dat') = True then
  begin
    EnemyFile := TStringList.Create;
    EnemyFile.LoadFromFile(ExtractFileDir(Application.EXEName) + '\Data\enemy.dat');

    for i := 0 to EnemyFile.Count - 1 do
    begin
      count := 1;
      EnemyIndex := '';
      while ((EnemyFile[i][count] <> ':') or (count = length(enemyfile[i]))) do
      begin
        EnemyIndex := EnemyIndex + EnemyFile[i][count];
        inc(Count);
      end;
      inc(Count);
      EnemyNames[StrToInt('$' + EnemyIndex)] := copy(EnemyFile[i],Count,Length(EnemyFile[i]) - count +1);

    end;

  end;

end;


procedure TRushNAttackImage.SavePatternTable;
var
  i : Integer;
begin

  for i := 0 to 623 do
  begin

//    if ROM[self._TextOffset + i] <> self._PatternTable[i] then
//      ROM.Changed := True;

    ROM[self._TextOffset + i] := self._PatternTable[i];
  end;
  for i :=0 to 3471 do
  begin

//    if ROM[Levels[self._Level].PatternTableOffset + i] <> self._PatternTable[i+624] then
//      ROM.Changed := True;

    ROM[Levels[self._Level].PatternTableOffset + i] := self._PatternTable[i+624];
  end;
end;

procedure TRushNAttackImage.SaveCurrentPalette;
var
  i,x : Integer;
begin

  for i := 0 to 7 do
    for x := 0 to 3 do
    begin
{      if ROM[Levels[self._Level].PaletteOffset + (i*4)+x] <> self._Palette[i,x] then
      begin
        ROM.Changed := True;}
        ROM[Levels[self._Level].PaletteOffset + (i*4)+x] := self._Palette[i,x];
//      end;
    end;
end;

function TRushNAttackImage.Save : Boolean;
begin
  SaveScreenData();
  if self.SaveEnemyData = false then
    showmessage('Enemy data is too big.');

  result := ROM.Save;
end;

{ Graphics Related Functions }

procedure TRushNAttackImage.DrawCurrentScreen(pBitmap : TBitmap32;pIconTransparency : Boolean;pTransSetting : Byte;pDrawOpt : Byte);
var
  i, x : Integer;
  NumbersBMP : TBitmap32;
  BlankBMP : TBitmap32;
begin

  for i := 0 to 7 do
    for x := 0 to 5 do
      pBitmap.Draw(bounds(i*32,x * 32,32,32),bounds(self._LevelData[i,x] * 32,0,32,32),_Tiles);
  NumbersBMP := TBitmap32.Create;
  BlankBMP := TBitmap32.Create;
  try
    NumbersBMP.Width := 136;
    NumbersBMP.Height := 8;
    NumbersBMP.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\numbers.bmp');
    BlankBMP.Width := 16;
    BlankBMP.Height := 16;
    BlankBMP.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\blank.bmp');
    if pIconTransparency = True then
    begin
      NumbersBMP.DrawMode := dmBlend;
      NumbersBMP.MasterAlpha := pTransSetting;
      BlankBMP.DrawMode := dmBlend;
      BlankBMP.MasterAlpha := pTransSetting;
    end;

    {if Length(Self.Levels[Self.Level].EnemyData[self.Screen]) > 0 then
    begin
      for i := 0 to Length(Self.Levels[Self.Level].EnemyData[Self.Screen]) -1 do
      begin
        pBitmap.Draw(Self.Levels[Self.Level].EnemyData[Self.Screen,i].X,Self.Levels[Self.Level].EnemyData[Self.Screen,i].Y,BlankBMP);
        pBitmap.Draw(bounds(Self.Levels[Self.Level].EnemyData[Self.Screen,i].X,Self.Levels[Self.Level].EnemyData[Self.Screen,i].Y,8,8),bounds(StrToInt('$' + IntToHex(Self.Levels[Self.Level].EnemyData[Self.Screen,i].ID,2)[1]) * 8,0,8,8),NumbersBMP);
        pBitmap.Draw(bounds(Self.Levels[Self.Level].EnemyData[Self.Screen,i].X+8,Self.Levels[Self.Level].EnemyData[Self.Screen,i].Y,8,8),bounds(StrToInt('$' + IntToHex(Self.Levels[Self.Level].EnemyData[Self.Screen,i].ID,2)[2]) * 8,0,8,8),NumbersBMP);
//        pBitmap.Textout(Self.Levels[Self.Level].EnemyData[Self.Screen,i].X,Self.Levels[Self.Level].EnemyData[Self.Screen,i].Y,IntToStr(Self.Levels[Self.Level].EnemyData[Self.Screen,i].ID))
      end;
    end;}
    if pDrawOpt and VIEWENEMIES = VIEWENEMIES then
    begin
      if Assigned(Levels[self.level].ScreenEnemies) = True then
      begin
        if Levels[self.level].ScreenEnemies.Count > 0 then
        begin
          for i := 0 to Levels[self.level].ScreenEnemies.Count -1 do
          begin
            if Levels[self.level].ScreenEnemies[i].Screen = self.Screen then
            begin
              pBitmap.Draw(Levels[self.level].ScreenEnemies[i].X,Levels[self.level].ScreenEnemies[i].Y,BlankBMP);
              pBitmap.Draw(bounds(Levels[self.level].ScreenEnemies[i].X,Levels[self.level].ScreenEnemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(Levels[self.level].ScreenEnemies[i].ID,2)[1]) * 8,0,8,8),NumbersBMP);
              pBitmap.Draw(bounds(Levels[self.level].ScreenEnemies[i].X+8,Levels[self.level].ScreenEnemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(Levels[self.level].ScreenEnemies[i].ID,2)[2]) * 8,0,8,8),NumbersBMP);
            end;
    //        pBitmap.Textout(Self.Levels[Self.Level].EnemyData[Self.Screen,i].X,Self.Levels[Self.Level].EnemyData[Self.Screen,i].Y,IntToStr(Self.Levels[Self.Level].EnemyData[Self.Screen,i].ID))
          end;
        end;
      end;
    end;

  finally
    FreeAndNil(NumbersBMP);
    FreeAndNil(BlankBMP);
  end;
end;

function TRushNAttackImage.DrawTileSelector(pIndex : Integer;pBitmap : TBitmap32): Boolean;
var
  i : Integer;
begin
  if _Tiles = nil then
  begin
    result := false;

  end
  else
  begin
    for i := 0 to 5 do
    begin
      if _DrawBlock[pindex + i] = False then
      begin
        if _tiles <> nil then DrawLevelTile(pindex + i);
        _DrawBlock[pindex + i] := True;
      end;
      pBitmap.Draw(bounds(0,i * 32,32,32),bounds((pindex+i) * 32,0,32,32),_tiles);
    end;
    result := true;
  end;
end;

function TRushNAttackImage.Export8x8Pat(pID: Integer) : T8x8Graphic;
var
  x,y : Integer;
  curBit, curBit2 : Char;
  TempBin1,TempBin2, TempBin3 : String;
  Tile1 : Array [0..15] of Byte;
  p8x8 : T8x8Graphic;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    TempBin1 := ROM.ByteToBin(Tile1[y]);
    TempBin2 := ROM.ByteToBin(Tile1[y + 8]);
    for x := 0  to 7 do
    begin
      CurBit := TempBin1[x + 1];
      CurBit2 := TempBin2[x + 1];
      TempBin3 := CurBit + CurBit2;

      if TempBin3 = '00' Then
        p8x8.Pixels[y,x] := 0
      else if TempBin3 = '10' Then
        p8x8.Pixels[y,x] := 1
      else if TempBin3 = '01' Then
        p8x8.Pixels[y,x] := 2
      else if TempBin3 = '11' Then
        p8x8.Pixels[y,x] := 3;
    end;
  end;
  result := p8x8;
end;

procedure TRushNAttackImage.Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
var
  x,y : Integer;
  TempBin1, TempBin2 : String;
  Tile1 : Array [0..15] of Byte;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    for x := 0  to 7 do
    begin

      TempBin1 := IntToStr(p8x8.Pixels[y,x] and 1) + TempBin1;
      TempBin2 := IntToStr(p8x8.Pixels[y,x] shr 1) + TempBin2;


    end;

    self._PatternTable[(pID * 16) +y] := ROM.BinToByte(TempBin1);
    self._PatternTable[(pID * 16) +y + 8] := ROM.BinToByte(TempBin2);

  end;

end;


{ TSA Related Functions }

function TRushNAttackImage.EditTSA(pBlock,pTileIndex1,pTileIndex2 : Integer; pNewTile : Byte): Integer;
begin
  ROM[Levels[self._Level].TSAOffset[pBlock] + (pTileIndex1 *4 + pTileIndex2)] := pNewTile;
  DrawLevelTile(pBlock);
  result := 1;
end;

function TRushNAttackImage.IncrementBlockAttributes(pBlock,pTileIndex1,pTileIndex2 : Integer): Integer;
var
  TilePal : Array [0..1,0..1] Of Byte;
begin

  TilePal[0,0] := (ROM[Levels[self._Level].AttributeDataOffset +pBlock]) and 3;
  tilepal[0,1] := (ROM[Levels[self._Level].AttributeDataOffset +pBlock] shr 2) and 3;
  tilepal[1,0] := (ROM[Levels[self._Level].AttributeDataOffset +pBlock] shr 4) and 3;
  tilepal[1,1] := (ROM[Levels[self._Level].AttributeDataOffset +pBlock] shr 6) and 3;

  if tilepal[pTileIndex1,pTileIndex2] = 3 then
    tilepal[pTileIndex1,pTileIndex2] := 0
  else
    inc(tilepal[pTileIndex1,pTileIndex2]);

  ROM[Levels[self._Level].AttributeDataOffset + pBlock] := (TilePal[1,1] shl 6) + (TilePal[1,0] shl 4) + (TilePal[0,1] shl 2) + (TilePal[0,0]);

  DrawLevelTile(pBlock);

  result := 1;

end;

{ Private Functions }

{ Property Getting Functions }

function TRushNAttackImage.GetLevel: Integer;
begin
  result := self._Level;
end;

function TRushNAttackImage.GetMapperStatus: Boolean;
begin
  if ROM.ValidImage = False then
  begin
    result := false;
    exit;
  end;
  if (ROM.MapperNumber = 2) and (ROM.PRGCount = 8) and (ROM.CHRCount = 0) then
    result := true
  else
    result := false;
end;

function TRushNAttackImage.GetScreen: Integer;
begin
  result := self._ScreenNumber;
end;

{ General Functions }

procedure TRushNAttackImage.LoadDataFile(pDataFileName: String);
var
  INI : TMemINIHexFile;
  NumberOfLevels,i : Integer;
  CurrentLevel : TLevel;
begin
  INI := TMemINIHexFile.Create(pDataFileName);
  try
    NumberOfLevels := INI.ReadInteger('General','NumberOfLevels');
    // Create the initial level list object.
    self.Levels := TLevelList.Create(True);
    self._TextOffset := INI.ReadHexValue('General','Text');
    self._Player1LivesOffset := INI.ReadHexValue('General','Player1Lives');
    self._Player2LivesOffset := INI.ReadHexValue('General','Player2Lives');
    self._EnemyDataStart := INI.ReadHexValue('General','EnemyDataStart');
    self._EnemyDataMaxSize := INI.ReadHexValue('General','EnemyMaxSize');

    // Loop through all the levels in the datafile
    // and retrieve the data about them.
    for i := 0 to NumberOfLevels - 1 do
    begin
      self.Levels.Add(TLevel.Create);
      CurrentLevel := self.Levels.Last;
      CurrentLevel.PatternTableOffset := INI.ReadHexValue('Level' + IntToStr(i),'PatternTable');
      CurrentLevel.TSAPointersLocation := INI.ReadHexValue('Level' + IntToStr(i),'TSAPointers');
      CurrentLevel.AttributeDataOffset := INI.ReadHexValue('Level' + IntToStr(i),'AttributeData');
      CurrentLevel.PaletteOffset := INI.ReadHexValue('Level' + IntToStr(i),'Palette');
      CurrentLevel.LevelDataOffset := INI.ReadHexValue('Level' + IntToStr(i),'LevelData');
      CurrentLevel.NumberOfBlocks := INI.ReadInteger('Level' + IntToStr(i),'NumOfBlocks');
      CurrentLevel.NumberOfScreens := INI.ReadInteger('Level' + IntToStr(i),'NumOfScreens');
      CurrentLevel.EnemyPointerOffset := INI.ReadHexValue('Level' + IntToStr(i),'EnemyPointers');
//      CurrentLevel.LoadTSAOffset;
    end;
  finally
    FreeAndNil(INI);
  end;
end;

procedure TRushNAttackImage.LoadPatternTable;
var
  i : Integer;
begin
  for i := 0 to 623 do
    self._PatternTable[i] := ROM[self._TextOffset + i];

  for i :=0 to 3471 do
    self._PatternTable[i+624] := ROM[Levels[self._Level].PatternTableOffset + i];

end;

procedure TRushNAttackImage.LoadScreenData();
var
  i, x : Integer;
begin

  For i := 0 To 7 do
  begin
    For x := 0 To 5 do
    begin
      _LevelData[i, x] := ROM[Levels[self._Level].LevelDataOffset + (self._ScreenNumber*48) + (i * 6) + x];

      if _DrawBlock[_LevelData[i,x]] = False then
      begin
        if _tiles <> nil then DrawLevelTile(_LevelData[i,x]);
        _DrawBlock[_LevelData[i, x]] := True;
      end;

    end;

  end;

end;

procedure TRushNAttackImage.SaveScreenData();
var
  i, x : Integer;
begin

  For i := 0 To 7 do
  begin
    For x := 0 To 5 do
    begin
{      if _LevelData[i,x] <> ROM[Levels[self._Level].LevelDataOffset + (self._ScreenNumber*48) + (i * 6) + x] then
      begin
        ROM.Changed := True;}
        ROM[Levels[self._Level].LevelDataOffset + (self._ScreenNumber*48) + (i * 6) + x] := _LevelData[i, x];
//      end;

    end;
  end;

end;

{ Debugging functions }

procedure TRushNAttackImage.DumpPatternTable(pFilename : String);
var
  Mem : TMemoryStream;
  i : Integer;
begin

  Mem := TMemoryStream.Create;
  try
    Mem.SetSize(high(self._PatternTable));

    Mem.Position :=0;

    for i := 0 to mem.Size do
      Mem.Write(self._PatternTable[i],1);

    Mem.SaveToFile(pFilename);
  finally
    FreeAndNil(Mem);
  end;

end;

{ Internal Graphics Functions }

procedure TRushNAttackImage.DrawLevelTile(pTileNumber : Byte);
var
  i,x : Integer;
  TilePal : Array [0..1,0..1] Of Byte;
begin

  if _Tiles = nil then
    exit;
  TilePal[0,0] := (ROM[Levels[self._Level].AttributeDataOffset +ptilenumber]) and 3;
  tilepal[0,1] := (ROM[Levels[self._Level].AttributeDataOffset +ptilenumber] shr 2) and 3;
  tilepal[1,0] := (ROM[Levels[self._Level].AttributeDataOffset +ptilenumber] shr 4) and 3;
  tilepal[1,1] := (ROM[Levels[self._Level].AttributeDataOffset +ptilenumber] shr 6) and 3;
  for i := 0 to 3 do
    for x := 0 to 3 do
      DrawPatternTableTile(ROM[Levels[self._Level].TSAOffset[pTileNumber] + (i *4 + x)]*16,_Tiles,(pTileNumber * 32) + x * 8,i*8,tilepal[i div 2,x div 2]);
//  _tiles.SaveToFile('C:\test.bmp');
end;

procedure TRushNAttackImage.DrawPatternTableTile(pOffset: Integer; pBitmap: TBitmap32; pX, pY,
      pIndex: Integer);
var
  x,y : Integer;
  curBit, curBit2 : Char;
  TempBin : String;
  Tile1 : Array [0..15] of Byte;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[pOffset+y];

  for y := 0 to 7 do
  begin
    for x := 0  to 7 do
    begin
      TempBin := ROM.ByteToBin(Tile1[y]);
      CurBit := TempBin[x + 1];
      TempBin := ROM.ByteToBin(Tile1[y + 8]);
      CurBit2 := TempBin[x + 1];

      TempBin := CurBit + CurBit2;

      if TempBin = '00' Then
        pBitmap.Pixel[pX + x,py+y] := ROM.ReturnColor32NESPal(self._Palette[pIndex,0])
      else if TempBin = '10' Then
        pBitmap.Pixel[pX + x,py+y] := ROM.ReturnColor32NESPal(self._Palette[pIndex,1])
      else if TempBin = '01' Then
        pBitmap.Pixel[pX + x,py+y] := ROM.ReturnColor32NESPal(self._Palette[pIndex,2])
      else if TempBin = '11' Then
        pBitmap.Pixel[pX + x,py+y] := ROM.ReturnColor32NESPal(self._Palette[pIndex,3]);
    end;
  end;


end;

procedure TRushNAttackImage.SetLevel(const Value: Integer);
var
  i : Integer;
begin
  if self._ScreenNumber > -1 then
  begin
    SaveScreenData();
    if self.SaveEnemyData = False then
      showmessage('Enemy data is too big to be saved. Delete a few enemies and switch levels.');
  end;
  for i := 0 to 255 do
    _DrawBlock[i] := False;
  self._Level := Value;
  self._ScreenNumber := 0;
  LoadPatternTable;
  LoadCurrentPalette;
  Levels[self._Level].LoadTSAOffset;
  LoadScreenData();

//  DumpPatternTable('C:\test.nes');
end;


procedure TRushNAttackImage.LoadCurrentPalette;
var
  i,x : Integer;
begin

  for i := 0 to 7 do
    for x := 0 to 3 do
      self._Palette[i,x] := ROM[Levels[self._Level].PaletteOffset + (i*4)+x];

end;

procedure TRushNAttackImage.SetScreen(const Value: Integer);
begin
  if self._ScreenNumber > -1 then
  begin
    SaveScreenData();
  end;

  self._ScreenNumber := Value;

  LoadScreenData();
end;

function TRushNAttackImage.EditLevel(pX,pY : Integer; pBlockNo : Integer): Boolean;
begin
  // Check if the pX/pY aren't greater than the
  // size of the array.
  // Also check that the block number that is being
  // passed is within the number of tiles limit for the level.
  if (pX > 7) or (pY > 5) or (pBlockNo > self.Levels[self._Level].NumberOfBlocks) then
  begin
    result := False;
  end
  else
  begin
    self._LevelData[pX,pY] := pBlockNo;
    result := True;
    ROM.Changed := True;
  end;
end;

function TRushNAttackImage.GetLevelTile(pY,pX : integer): Integer;
begin
  // Check if the pX/pY aren't greater than the
  // size of the array.
  // Also check that the block number that is being
  // passed is within the number of tiles limit for the level.
  if (pX > 7) or (pY > 7) then
    result := -1
  else
    result := self._LevelData[pX,pY];

end;

function TRushNAttackImage.ReturnColor32NESPal(pIndex: Byte): TColor32;
begin
  result := ROM.ReturnColor32NESPal(pIndex);
end;

procedure TRushNAttackImage.DrawPatternTable(pBitmap : TBitmap32; pPal : Integer);
var
  i,x : Integer;
begin
  for i := 0 to 15 do
    for x := 0 to 15 do
      DrawPatternTableTile((i*16 + x) * 16,pBitmap,x*8,i*8,pPal);
end;

procedure TRushNAttackImage.RefreshOnScreenTiles(pTileSelectorValue: Byte);
var
  i, x : integer;
begin

  // Reset all the tiles back to the false drawing state.
  for i := 0 to 255 do
    _DrawBlock[i] := false;

  for i := 0 to 7 do
    for x := 0 to 5 do
      if _DrawBlock[self._LevelData[i,x]] = false then
      begin
        DrawLevelTile(_Leveldata[i,x]);
        _DrawBlock[self._LevelData[i,x]] := True;
      end;


  // Now scroll through the blocks displayed in the tile selector
  for i := pTileSelectorValue to pTileSelectorValue + 5 do
    if _DrawBlock[i] = false then
    begin
      DrawLevelTile(i);
      _DrawBlock[i] := True;
    end;

end;


function TRushNAttackImage.GetPal(index1, index2: Integer): Byte;
begin
  result := self._Palette[index1,index2];
end;

procedure TRushNAttackImage.SetPal(index1, index2: Integer;
  const Value: Byte);
begin
  self._Palette[index1,index2] := Value;
end;

procedure TRushNAttackImage.LoadPaletteFile(pFilename : String);
begin
  ROM.LoadPaletteFile(pFilename);
end;

function TRushNAttackImage.GetROMFilename: String;
begin
  result := ROM.Filename;
end;

destructor TRushNAttackImage.Destroy;
begin
  FreeAndNil(_Tiles);
  FreeAndNil(ROM);
  Levels.Free;
  inherited;
end;

function TRushNAttackImage.GetCurrentEnemy(pX,pY : Integer): Integer;
var
  i : Integer;
begin
  result := -1;
  if Assigned(Levels[level].ScreenEnemies) = True then
  begin
    if Levels[level].ScreenEnemies.Count > 0 then
    begin
      for i := 0 to Levels[level].ScreenEnemies.Count -1 do
      begin
        if Levels[level].ScreenEnemies[i].Screen = self.Screen then
        begin
          if ((pX >= Levels[level].ScreenEnemies[i].X) and (pX <= Levels[level].ScreenEnemies[i].X + 16)) and ((pY >= Levels[level].ScreenEnemies[i].Y) and (pY <= Levels[level].ScreenEnemies[i].Y + 16)) then
          begin
            result := i;
            exit;
          end;
        end;
      end;
    end;
  end;

end;

procedure TRushNAttackImage.IncrementEnemyID(pID : Integer);
begin
  if Levels[level].ScreenEnemies[pID].ID = $FE then
    Levels[level].ScreenEnemies[pID].ID := 1
  else
    Levels[level].ScreenEnemies[pID].ID := Levels[level].ScreenEnemies[pID].ID + 1;
  ROM.Changed := True;
end;

procedure TRushNAttackImage.Increment10EnemyID(pID : Integer);
begin
  Levels[level].ScreenEnemies[pID].ID := Levels[level].ScreenEnemies[pID].ID + $10;
  if Levels[level].ScreenEnemies[pID].ID = $FF then
    Levels[level].ScreenEnemies[pID].ID := 1;
  if Levels[level].ScreenEnemies[pID].ID = $0 then
    Levels[level].ScreenEnemies[pID].ID := 1;
  ROM.Changed := True;
end;

procedure TRushNAttackImage.SetEnemyXY(pX,pY : SmallInt;pID : Integer);
begin
  if pX > -1 then
    Levels[level].ScreenEnemies[pID].X := pX;
  if pY > -1 then
    Levels[level].ScreenEnemies[pID].Y := pY;
  ROM.Changed := True;
end;

function TRushNAttackImage.GetEnemyXY(pXY : Byte; pID : Integer): Integer;
begin
  result := -1;
  if pXY = 0 then
    result := Levels[level].ScreenEnemies[pID].X
  else if pXY = 1 then
    result := Levels[level].ScreenEnemies[pID].Y;
end;

procedure TRushNAttackImage.LoadEnemyData();
var
  CurrentPos,i,x : Integer;
  TempEnemy : TEnemy;
begin
  for i := 0 to Levels.Count -1 do
  begin
    if Assigned(Levels[i].ScreenEnemies) = True then
      FreeAndNil(Levels[i].ScreenEnemies);
    Levels[i].ScreenEnemies := TEnemyList.Create(True);
    Levels[i].LoadEnemyOffset;
    for x := 0 to Levels[i].NumberOfScreens - 1 do
    begin

      if Levels[i].ReturnEnemyOffset(x) > 0 then
      begin

        CurrentPos := Levels[i].ReturnEnemyOffset(x);

        while(ROM[CurrentPos] < $FF) do
        begin
          Levels[i].ScreenEnemies.Add(TEnemy.Create);

          TempEnemy := Levels[i].ScreenEnemies.Last;

          TempEnemy.X := ROM[CurrentPos];
          TempEnemy.Y := ROM[CurrentPos+1] +2;
          TempEnemy.ID := ROM[CurrentPos+2];
          TempEnemy.Screen := x;
          CurrentPos := CurrentPos + 3;

        end; // end of while rom

      end; // end of if returnenemyoffset
    end; // end of for x  loop
  end; // end of for i loop


end;

function TRushNAttackImage.SaveEnemyData() : Boolean;
var
  TempLevel : TLevel;
  i,x,z,CurrentPos,size : Integer;
  EnePointer : String;
begin

  CurrentPos := Self._EnemyDataStart;

  size := 0;

  for i := 0 to levels.count -1 do
  begin
    size := size + (levels[i].screenenemies.count * 3) + (levels[i].NumberOfScreens -1);
  end;

  if size > self._EnemyDataMaxSize then
  begin
    result := False;
//    showmessage(inttohex(size,4));
    exit;
  end;
  for i := 0 to Levels.Count -1 do
  begin
    TempLevel := Levels[i];

    for x := 0 to TempLevel.NumberOfScreens -1 do
    begin

      if TempLevel.GetEnemyOffset(x) > 0 then
      begin
{        if (TempLevel.ScreenEnemies.NumberOfEnemiesInScreen(x) = 0)  then
        begin
          if (ROM[CurrentPos -1] = $FF) then
            EnePointer := IntToHex((CurrentPos-1 - $18010) + $8000,4)
          else
          begin
            EnePointer := IntToHex((CurrentPos - $18010) + $8000,4);
            ROM[CurrentPos] := $FF;
            inc(CurrentPos);
          end;
        end
        else}
        EnePointer := IntToHex((CurrentPos - $18010) + $8000,4);
        ROM[TempLevel.GetEnemyOffset(x)] := StrToInt('$' + EnePointer[3] + EnePointer[4]);
        ROM[TempLevel.GetEnemyOffset(x)+1] := StrToInt('$' + EnePointer[1] + EnePointer[2]);
        if TempLevel.ScreenEnemies.NumberOfEnemiesInScreen(x) > 0 then
        begin
          for z := 0 to TempLevel.ScreenEnemies.Count -1 do
          begin
            if TempLevel.ScreenEnemies[z].Screen = x then
            begin
              ROM[CurrentPos] := TempLevel.ScreenEnemies[z].X;
              ROM[CurrentPos+1] := TempLevel.ScreenEnemies[z].Y - 2;
              ROM[CurrentPos+2] := TempLevel.ScreenEnemies[z].ID;
              CurrentPos := CurrentPos + 3;

            end;

          end;

        end; // if templevel.screenenemies....

        ROM[CurrentPos] := $FF;
        inc(CurrentPos);
      end;// if levels[i].Getenemyoffset...
    end; // x
  end; // i

  result := True;

{var
  i, CurrentPos : Integer;
begin
  for i := 0 to Levels[}
  {if Assigned(Levels[level].ScreenEnemies) = True then
  begin
    if (Levels[level].ReturnEnemyOffset(Screen) > 0) and (ScreenEnemies.Count > 0)then
    begin
      CurrentPos := Levels[level].ReturnEnemyOffset(Screen);
      for i := 0 to ScreenEnemies.Count -1 do
      begin
        ROM[CurrentPos + (i *3)] := ScreenEnemies[i].X;
        ROM[CurrentPos + (i *3) + 1] := ScreenEnemies[i].Y - 2;
        ROM[CurrentPos + (i *3) + 2] := ScreenEnemies[i].ID;
      end;

    end;
  end;}
end;

function TRushNAttackImage.GetChanged: Boolean;
begin
  result := ROM.Changed;
end;

function TRushNAttackImage.GetCHRCount : Integer;
begin
  result := ROM.CHRCount;
end;

function TRushNAttackImage.GetPRGCount : Integer;
begin
  result := ROM.PRGCount;
end;

function TRushNAttackImage.GetMemMap : Integer;
begin
  result := ROM.MapperNumber;
end;

function TRushNAttackImage.GetMemMapName : String;
begin
  result := ROM.MapperName;
end;

function TRushNAttackImage.GetFileSize : Integer;
begin
  result := ROM.ROMSize;
end;

procedure TRushNAttackImage.SetPlayer1Lives(pNewLives : Byte);
begin
  ROM[self._Player1LivesOffset] := pNewLives;
end;

procedure TRushNAttackImage.SetPlayer2Lives(pNewLives : Byte);
begin
  ROM[self._Player2LivesOffset] := pNewLives;
end;

function TRushNAttackImage.GetPlayer1Lives : Byte;
begin
  result := ROM[self._Player1LivesOffset];
end;

function TRushNAttackImage.GetPlayer2Lives : Byte;
begin
  result := ROM[self._Player2LivesOffset];
end;

procedure TRushNAttackImage.AddNewEnemy();
var
  Enemy : TEnemy;
begin
  if Screen > 0 then
  begin
    Levels[Level].ScreenEnemies.Add(TEnemy.Create);
    Enemy := Levels[level].ScreenEnemies.Last;
    Enemy.Screen := Screen;
    Enemy.ID := 1;
    ROM.Changed := True;
  end;
end;

procedure TRushNAttackImage.DeleteEnemy(pID : Integer);
begin
  Levels[Level].ScreenEnemies.Delete(pId);
  ROM.Changed := True;
end;

end.
