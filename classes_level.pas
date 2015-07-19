unit classes_level;

interface
uses contnrs, sysutils;

type

  TEnemy = class
  private
    _X : Byte;
    _Y : Byte;
    _ID : Byte;
    _Screen : Byte;
  public
    property X : Byte read _X write _X;
    property Y : Byte read _Y write _Y;
    property ID : Byte read _ID write _ID;
    property Screen : Byte read _Screen write _Screen;
  end;

  { This is a class that will be used to store the
    enemies. This is a descendant of the TObjectList class.
    The reason that I am not using a TObjectList, is that
    for every access, you have to explicitly cast your objects
    to their correct type.}
  TEnemyList = class(TObjectList)
  protected
    function GetEnemyItem(Index: Integer) : TEnemy;
    procedure SetEnemyItem(Index: Integer; const Value: TEnemy);
  public
    function Last : TEnemy;
    function Add(AObject: TEnemy) : Integer;
    property Items[Index: Integer] : TEnemy read GetEnemyItem write SetEnemyItem;default;
    function NumberOfEnemiesInScreen(index : Integer) : Integer;
  end;


  { This is our level class. It essentially stores
    the data that is in our datafile.}
  TLevel = class
  private
    _PatternTable : Integer;
    _TSAPointerLocation : Integer;
    _AttributeData : Integer;
    _Palette : Integer;
    _LevelDataOffset : Integer;
    _EnemyPointersOffset : Integer;
    _NumOfBlocks : Integer;
    _NumOfScreens : Integer;
    _TSAOffsets : Array [0..255] of Integer;
    _EnemyOffsets : Array Of Integer;
    function GetTSAOffset(index: Integer): Integer;

  public
    ScreenEnemies : TEnemyList;
    destructor destroy;override;
    { Procedure to work out the offsets of the various enemies
     from the pointers.}
    procedure LoadEnemyOffset;
    function GetEnemyOffset(index : Integer) : Integer;
    // Procedure to load in the offsets of the various TSA blocks.
    procedure LoadTSAOffset;
    // The offset of the level's pattern table.
    property PatternTableOffset : Integer read _PatternTable write _PatternTable;
    // The offset of the first pointer of TSA data.
    property TSAPointersLocation : Integer read _TSAPointerLocation write _TSAPointerLocation;
    // The offset of the attribute data.
    property AttributeDataOffset : Integer read _AttributeData write _AttributeData;
    // The offset of the palette data for this level.
    property PaletteOffset : Integer read _Palette write _Palette;
    // The offset of the level data.
    property LevelDataOffset : Integer read _LevelDataOffset write _LevelDataOffset;
    // The offset of the enemy pointers.
    property EnemyPointerOffset : Integer read _EnemyPointersOffset write _EnemyPointersOffset;
    // The offset of whatever TSA block you want by Index.
    property TSAOffset [index : Integer] : Integer read GetTSAOffset;
    // The number of screens that are in this level.
    property NumberOfScreens : Integer read _NumOfScreens write _NumOfScreens;
    // The number of blocks that are used in this level.
    property NumberOfBlocks : Integer read _NumOfBlocks write _NumOfBlocks;
    function ReturnEnemyOffset(pScreenID: Integer) : Integer;
  end;

  { This is a class that will be used to store the
    levels. This is a descendant of the TObjectList class.
    The reason that I am not using a TObjectList, is that
    for every access, you have to explicitly cast your objects
    to their correct type.}
  TLevelList = class(TObjectList)
  protected
    function GetLevelItem(Index: Integer) : TLevel;
    procedure SetLevelItem(Index: Integer; const Value: TLevel);
  public
    function Last : TLevel;
    function Add(AObject: TLevel) : Integer;
    property Items[Index: Integer] : TLevel read GetLevelItem write SetLevelItem;default;
  end;

implementation

uses classes_ROM;

{ TLevel }

function TLevel.GetTSAOffset(index: Integer): Integer;
begin
  result := self._TSAOffsets[index];
end;

function TLevel.GetEnemyOffset(index : Integer) : Integer;
begin
  if index = 0 then
    result := 0
  else
    result := self._EnemyPointersOffset + ((index-1)* 2);
end;

procedure TLevel.LoadEnemyOffset;
var
  i : Integer;
begin

  // Resize the enemy array to be the number of
  // screens. I presume that the first
  // screen doesn't have enemy data, but I cannot be sure.
  SetLength(Self._EnemyOffsets,self.NumberOfScreens);

  // I think the first screen does not have enemy data,
  // so ignore it.
  for i := 0 to self.NumberOfScreens - 2 do
    self._EnemyOffsets[i + 1] := ROM.ReturnPointerOffset(self.EnemyPointerOffset +  (i *2),$18010);

end;

procedure TLevel.LoadTSAOffset;
var
  i : Integer;
begin
  for i := 0 to self._NumOfBlocks - 1 do
    self._TSAOffsets[i] := ROM.ReturnPointerOffset(self._TSAPointerLocation +  (i *2),$14010);
end;

{ TLevelList Public functions}

function TLevelList.Add(AObject: TLevel): Integer;
begin
  Result := inherited Add(AObject);
end;

function TLevelList.GetLevelItem(Index: Integer): TLevel;
begin
  Result := TLevel(inherited Items[Index]);
end;

function TLevelList.Last: TLevel;
begin
  result := TLevel(inherited Last);
end;

procedure TLevelList.SetLevelItem(Index: Integer; const Value: TLevel);
begin
  inherited Items[Index] := Value;
end;

function TLevel.ReturnEnemyOffset(pScreenID: Integer) : Integer;
begin
  result := self._EnemyOffsets[pScreenID];
end;

destructor TLevel.destroy;
begin
  FreeAndNil(ScreenEnemies);
end;

{ TEnemyList}

function TEnemyList.Add(AObject: TEnemy): Integer;
begin
  Result := inherited Add(AObject);
end;

function TEnemyList.GetEnemyItem(Index: Integer): TEnemy;
begin
  Result := TEnemy(inherited Items[Index]);
end;

function TEnemyList.Last: TEnemy;
begin
  result := TEnemy(inherited Last);
end;

procedure TEnemyList.SetEnemyItem(Index: Integer; const Value: TEnemy);
begin
  inherited Items[Index] := Value;
end;

function TEnemyList.NumberOfEnemiesInScreen(index : Integer) : Integer;
var
  count,i : Integer;
begin
  count := 0;
  for i := 0 to self.Count - 1 do
    if self[i]._Screen = index then
      inc(count);

  result := count;
end;

end.
