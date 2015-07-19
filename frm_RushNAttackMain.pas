unit frm_RushNAttackMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, shellapi, MemINIHexFile,iNESImage,
  ActnList, ImgList, StdCtrls, GR32_Image, Buttons, GR32, GR32_Layers,
  XPMan, AbBase, AbBrowse, AbZBrows, AbZipper, DragDrop, DropTarget,
  DragDropFile;

type
  TfrmRushNAttackEditor = class(TForm)
    cmdRight: TBitBtn;
    cmdLeft: TBitBtn;
    imgLevel: TImage32;
    imgCurTile: TImage32;
    TileScrollBar: TScrollBar;
    ImageList: TImageList;
    ActionList: TActionList;
    actOpenROM: TAction;
    actCreatePaletteEditor: TAction;
    actCreateTSAEditor: TAction;
    actCreateAbout: TAction;
    actSaveROM: TAction;
    actCloseROM: TAction;
    actCreatePreferences: TAction;
    actCreateJumpTo: TAction;
    actCreateROMProperties: TAction;
    Toolbar: TToolBar;
    tlbOpenROM: TToolButton;
    tlbSaveROM: TToolButton;
    tlbCloseROM: TToolButton;
    ToolButton4: TToolButton;
    tlbJumpTo: TToolButton;
    tlbSep1: TToolButton;
    tlbTSAEditor: TToolButton;
    tlbPaletteEditor: TToolButton;
    tlbROMProperties: TToolButton;
    tlbSep2: TToolButton;
    tlbEnableGridlines: TToolButton;
    lblScreenNumber: TLabel;
    actEnableGridlines: TAction;
    XPManifest: TXPManifest;
    abZip: TAbZipper;
    MainMenu: TMainMenu;
    mnuFile: TMenuItem;
    mnuOpenROM: TMenuItem;
    mnuRecent: TMenuItem;
    mnuRecentItem1: TMenuItem;
    mnuRecentItem2: TMenuItem;
    mnuRecentItem3: TMenuItem;
    mnuRecentItem4: TMenuItem;
    mnuRecentItem5: TMenuItem;
    mnuSaveROM: TMenuItem;
    mnuCloseROM: TMenuItem;
    N1: TMenuItem;
    mnuOptions: TMenuItem;
    mnuLaunchAssociatedEmulator: TMenuItem;
    N3: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuMapEditingMode: TMenuItem;
    mnuObjectEditingMode: TMenuItem;
    mnuView: TMenuItem;
    mnuGridlines: TMenuItem;
    mnuViewEnemies: TMenuItem;
    mnuTools: TMenuItem;
    mnuPaletteEditor: TMenuItem;
    mnuTSAEditor: TMenuItem;
    mnuROMProperties: TMenuItem;
    mnuHelp: TMenuItem;
    mnuAbout: TMenuItem;
    StatusBar: TStatusBar;
    tlbSetMapEditingMode: TToolButton;
    tlbSetObjEditingMode: TToolButton;
    actSetMapEditingMode: TAction;
    actSetObjEditingMode: TAction;
    lblEnemy: TLabel;
    actCreateProperties: TAction;
    mnuProperties: TMenuItem;
    N2: TMenuItem;
    mnuJumpTo: TMenuItem;
    DropFileTarget: TDropFileTarget;
    mnuSaveAsIPS: TMenuItem;
    actSaveAsIPS: TAction;
    mnuHomepage: TMenuItem;
    tlbsep3: TToolButton;
    tlbAddNewEnemy: TToolButton;
    actNewEnemy: TAction;
    N4: TMenuItem;
    mnuAddNewEnemy: TMenuItem;
    N5: TMenuItem;
    procedure actCreateAboutExecute(Sender: TObject);
    procedure actOpenROMExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdLeftClick(Sender: TObject);
    procedure cmdRightClick(Sender: TObject);
    procedure imgLevelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure TileScrollBarChange(Sender: TObject);
    procedure TileScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure imgCurTileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure actEnableGridlinesExecute(Sender: TObject);
    procedure actCreateTSAEditorExecute(Sender: TObject);
    procedure actCreatePaletteEditorExecute(Sender: TObject);
    procedure actSaveROMExecute(Sender: TObject);
    procedure actCloseROMExecute(Sender: TObject);
    procedure actCreatePreferencesExecute(Sender: TObject);
    procedure mnuLaunchAssociatedEmulatorClick(Sender: TObject);
    procedure mnuRecentItem1Click(Sender: TObject);
    procedure imgLevelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actSetObjEditingModeExecute(Sender: TObject);
    procedure actSetMapEditingModeExecute(Sender: TObject);
    procedure imgLevelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure mnuViewEnemiesClick(Sender: TObject);
    procedure actCreatePropertiesExecute(Sender: TObject);
    procedure actCreateROMPropertiesExecute(Sender: TObject);
    procedure actCreateJumpToExecute(Sender: TObject);
    procedure TileScrollBarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DropFileTargetDrop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure actSaveAsIPSExecute(Sender: TObject);
    procedure mnuHomepageClick(Sender: TObject);
    procedure actNewEnemyExecute(Sender: TObject);
  private
    TSA : TForm;
    CurTilePos, CurTileLeft, CurTileMid : Byte;
    _EditingMode : Byte;
    _CurrentObj : Smallint;
    procedure DrawLevelData;
    procedure SetVisibleStatus(pVisible: Boolean);
    procedure SetEnabledButtonState;
    procedure SetScreenLabel;
    procedure DrawTileSelector;
    procedure LoadROM(pROMFile,pDataFile: String;pAutoCheck : Boolean);
    procedure SetEmuMenuText();
    procedure ExecuteEmulator;
    procedure CreateRecentMenu();
    procedure BackupFile();
    procedure SetupLevel();
    procedure DisableImages();
    function  AutoCheckROMType(pFilename : String) : String;
    procedure CloseROM(pDisableCancel : Boolean);
    procedure SetIPSEnabled();
    { Private declarations }
  public
    CurTSABlock : Integer;
    procedure RedrawScreen;
    procedure UpdateTitleCaption();
    { Public declarations }
  end;

var
  frmRushNAttackEditor: TfrmRushNAttackEditor;

implementation

uses frm_preferences,frm_About,unit_Global, frm_TSA, frm_Palette, classes_RNAROM,
  classes_configuration, frm_opendialog, frm_EnemyProp, frm_Prop, frm_ROMProp, frm_JumpTo, unit_lunarcompress;

const
  MAPEDITINGMODE : Byte = 0;
  OBJEDITINGMODE : Byte = 1;
  NOTSET = -1;
{$R *.dfm}

procedure TfrmRushNAttackEditor.actCreateAboutExecute(Sender: TObject);
var
  About : TfrmAbout;
begin
  About := TfrmAbout.Create(self);
  try
    About.ShowModal;
  finally
    FreeAndNil(About);
  end;
end;

procedure TfrmRushNAttackEditor.DrawLevelData();
var
  LevelBMP : TBitmap32;
  i : Integer;
  DrawOpt : Byte;
begin
  LevelBMP := TBitmap32.Create;
  try
    LevelBMP.Width := 256;
    LevelBMP.Height := 192;

    DrawOpt := 0;

    if mnuViewEnemies.Checked = True then
      DrawOpt := DrawOpt + 1;

    RNAROM.DrawCurrentScreen(LevelBMP, RNAOptions.DrawTransparentIcons,RNAOptions.IconTransparency,DrawOpt);
    if RNAOptions.GridlinesOn = True then
    begin
      for i := 1 to 7 do
        LevelBMP.Line(i*32,0,i*32,LevelBMP.Height,RNAOptions.GridlineColour);
      for i := 1 to 5 do
        LevelBMP.Line(0,i*32,LevelBMP.Width,i*32,RNAOptions.GridlineColour);
    end;
    imgLevel.Bitmap := LevelBMP;
//    LevelBMP.SaveToFile('C:\test.bmp');
  finally
    freeandnil(LevelBMP);
  end;
end;

procedure TfrmRushNAttackEditor.actOpenROMExecute(Sender: TObject);
var
  OpDlg : TfrmOpenDialog;
begin
  OpDlg := TfrmOpenDialog.Create(self);
  try
    if (RNAOptions.RecentFile[0] <> '') and (FileExists(RNAOptions.RecentFile[0])) then
      OpDlg.OpenDir := ExtractFileDir(RNAOptions.RecentFile[0]);

    DropFileTarget.Dragtypes := [];
    OpDlg.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];

    if OpDlg.ModalResult = mrOK then
    begin

      if FileExists(OpDlg.Filename) = true then
      begin
        LoadROM(OpDlg.Filename,OpDlg.DataFile,OpDlg.AutoCheck);
        RNAOptions.AddRecentFile(OpDlg.Filename);
      end;

    end;
  finally
    FreeAndNil(OpDlg);
  end;
{begin
  if (RNAOptions.RecentFile[0] <> '') and (FileExists(RNAOptions.RecentFile[0])) then
    OpenDialog.InitialDir :=  ExtractFileDir(RNAOptions.RecentFile[0]);
  if OpenDialog.Execute then
  begin
    if FileExists(OpenDialog.Filename) = true then
    begin
      LoadROM(OpenDialog.Filename);


    end;
  end;}

end;

procedure TfrmRushNAttackEditor.UpdateTitleCaption();
begin
  if Assigned(RNAROM) = True then
  begin
    Caption := ApplicationName + ' - [' + ExtractFilename(RNAROM.Filename) + ']';
    if RNAROM.Changed = True then Caption := Caption + ' *';
  end
  else
  begin
    Caption := ApplicationName;
  end;
end;

procedure TfrmRushNAttackEditor.LoadROM(pROMFile,pDataFile: String;pAutoCheck : Boolean);
var
  TempFilename : String;
begin
  // If the ROM file does not exist then exit the subroutine.
  if FileExists(pROMFile) = False then
    exit;
  // Transfer the datafile's filename over to another variable.
  TempFilename := pDataFile;
  // If the user wants to automatically check the ROM type then
  // check it. If there is no matches, reset the TempFileName variable
  // back to pDataFile (Usually the default datafile).
  if pAutoCheck = True then
  begin
    TempFilename := AutoCheckROMType(pROMFile);
    if TempFilename = '' then
      TempFilename := pDataFile
    else
      TempFilename := ExtractFileDir(Application.ExeName) + '\Data\' + TempFilename;
  end;

  // If the datafile does not exist, then exit the subroutine.
  if FileExists(TempFileName) = False then
    exit;
  // If there is a ROM loaded with Trip'n Slip, then
  // call the Close ROM routine, to take care of it.
  if Assigned(RNAROM) then
    CloseROM(True);

  // If the TSA form is loaded into memory, then get rid of it.
  if Assigned(TSA) then
    FreeAndNil(TSA);

  // Reinitialise the variables.
  CurTSABlock := -1;
  CurTilePos := 0;
  CurTileLeft := 0;
  CurTileMid := 0;
  // Load the ROM into memory.
  RNAROM := TRushNAttackImage.Create(pROMFile,TempFilename,RNAOptions.FullPaletteName);

  // Check if the ROM type matches that of a standard Rush'n Attack ROM.
  // If it doesn't, then depending on how the user has configured Trip'n Slip
  // to act, perform the appropriate action.
  if RNAROM.IsRushNAttackROM = false then
  begin
    // If the user elects to not load the ROM, then
    // display a prompt informing the user that the ROM will
    // not be loaded, free the ROM, and exit the subroutine.
    if RNAOptions.MapperWarnings = 0 then
    begin
        Messagebox(handle,'This is not a Rush''n Attack ROM.',PChar(Application.Title),0);
        FreeAndNil(RNAROM);
        exit;
    end
    // If the user has elected to be prompted about the
    // ROM not conforming to the standard Rush'n Attack settings
    // tell the user, and give them the choice of whether or not to load it.
    else if RNAOptions.MapperWarnings = 1 then
    begin
      if MessageBox(Handle,'The memory mapper of this ROM does not match the specifications of'
        + chr (13) + chr(10) + 'the Rush''n Attack ROMs. Do you wish to continue?',
            PChar(Application),MB_YESNO) = IDNO	then
      begin
        FreeAndNil(RNAROM);
        exit;
      end;
    end;
  end;
  // All final checks have passed.

  // Display the datafile's name in the right of the statusbar.
  StatusBar.Panels[2].Text := ExtractFileName(TempFilename);
  // Set the ROM's level to 0.
  RNAROM.Level :=0;
  // Display all controls which are usually disabled/invisible when
  // the ROM is not loaded.
  SetVisibleStatus(True);
  SetupLevel();
  actSetMapEditingMode.Execute;
  TileScrollbar.Max := RNAROM.Levels[RNAROM.Level].NumberOfBlocks - 6;
  SetEmuMenuText();
  SetIPSEnabled;
  RNAOptions.AddRecentFile(pROMFile);
  CreateRecentMenu();
  UpdateTitleCaption();
  actNewEnemy.enabled := False;
end;

procedure TfrmRushNAttackEditor.SetVisibleStatus(pVisible : Boolean);
begin
  imgLevel.Visible := pVisible;
  cmdLeft.Visible := pVisible;
  cmdRight.Visible := pVisible;
  imgCurTile.Visible := pVisible;
  TileScrollBar.Visible := pVisible;
  lblScreenNumber.Visible := pVisible;
  actEnableGridlines.Enabled := pVisible;
  actCreateTSAEditor.Enabled := pVisible;
  actCreatePaletteEditor.Enabled := pVisible;
  actCreateJumpTo.Enabled := pVisible;
  actSaveROM.Enabled := pVisible;
  actCloseROM.Enabled := pVisible;
  actSetMapEditingMode.Enabled := pVisible;
  actSetObjEditingMode.Enabled := pVisible;
  mnuViewEnemies.Enabled := pVisible;
  actCreateProperties.Enabled := pVisible;
  actCreateROMProperties.Enabled := pVisible;
  StatusBar.Visible := pVisible;
  actSaveAsIPS.Enabled := pVisible;
  actNewEnemy.Enabled := pVisible;
end;

procedure TfrmRushNAttackEditor.FormCreate(Sender: TObject);
begin
  // Register the drag dropping mechanism.
  DropFileTarget.Register(frmRushNAttackEditor);
  // Disable the images that are linked to menus
  // through the Action Lists.
  DisableImages;
  // Create the options class.
  RNAOptions := TRNAConfig.Create(ExtractFileDir(Application.ExeName) + '\options.ini');
  // Update the title caption with the name of the application.
  UpdateTitleCaption();
  // Initialise some variables.
  CurTSABlock := -1;
  _CurrentObj := -1;
  SetEmuMenuText();
  SetIPSEnabled;
  CreateRecentMenu();
  SetVisibleStatus(False);
  mnuViewEnemies.Checked := True;
  // to whether the gridlines are actually on.
  actEnableGridlines.Checked := RNAOptions.GridlinesOn;

  // Now look up the commandline parameters. If the user has
  // passed a ROM's filename along with EXE name, open the ROM.
  if ParamCount = 1 then
    if FileExists(ParamStr(1)) then
      LoadROM(ParamStr(1),RNAOptions.FullDataFileName, RNAOptions.AutoCheck);

end;

procedure TfrmRushNAttackEditor.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRushNAttackEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  if RNAOptions.Changed = True then
    RNAOptions.Save;

  FreeAndNil(RNAOptions);

  DropFileTarget.Unregister; 

  if Assigned(RNAROM) = True then
  begin
    if RNAROM.Changed = True then
    begin
      if MessageDlg('This ROM has some changes. Do you wish to save?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
        RNAROM.Save;
    end;

    FreeAndNil(RNAROM);
  end;
end;

procedure TfrmRushNAttackEditor.SetEnabledButtonState;
begin
  cmdLeft.Enabled := False;
  cmdRight.Enabled := False;

  if RNAROM.Screen > 0 then
    cmdLeft.Enabled := True;

  if RNAROM.Screen < RNAROM.Levels[RNAROM.Level].NumberOfScreens -1 then
    cmdRight.Enabled := True;
  
end;

procedure TfrmRushNAttackEditor.SetScreenLabel;
begin
  lblScreenNumber.Caption := 'Level: ' + IntToStr(RNAROM.Level  + 1) +   ' Screen Number: ' + IntToHex(RNAROM.Screen,2);
end;

procedure TfrmRushNAttackEditor.cmdLeftClick(Sender: TObject);
begin
  RNAROM.Screen := RNAROM.Screen - 1;
  DrawLevelData;
  SetEnabledButtonState;
  SetScreenLabel;
  UpdateTitleCaption();
  lblEnemy.Caption := IntToHex(RNAROM.Levels[RNAROM.Level].ReturnEnemyOffset(RNAROM.Screen),1);
  if RNAROM.Screen = 0 then
    actNewEnemy.Enabled := False
  else
    actNewEnemy.Enabled := True;
end;

procedure TfrmRushNAttackEditor.cmdRightClick(Sender: TObject);
begin
  RNAROM.Screen := RNAROM.Screen + 1;
  DrawLevelData;
  SetEnabledButtonState;
  SetScreenLabel;
  UpdateTitleCaption();
  lblEnemy.Caption := IntToHex(RNAROM.Levels[RNAROM.Level].ReturnEnemyOffset(RNAROM.Screen),1);
  if RNAROM.Screen = 0 then
    actNewEnemy.Enabled := False
  else
    actNewEnemy.Enabled := True;
end;

procedure TfrmRushNAttackEditor.imgLevelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  EnemyProp : TfrmEnemyProperties;
begin
  if _EditingMode = MAPEDITINGMODE then
  begin
    if (Button = mbMiddle) or ((ssShift in Shift) and (Button = mbLeft)) then
    begin
      RNAROM.EditLevel(x div 64, y div 64,CurTileMid);
      DrawLevelData();
    end
    else if button = mbLeft then
    begin
      RNAROM.EditLevel(x div 64, y div 64,CurTileLeft);
      DrawLevelData();
    end
    else if Button = mbRight then
    begin
      CurTilePos := RNAROM.GetLevelTile(y div 64,x div 64);
      if ssShift in Shift then
        CurTileMid := CurTilePos
      else
        CurTileLeft := CurTilePos;
      if CurTilePos > TileScrollBar.Max then CurTilePos := TileScrollBar.Max;
      if (CurTilePos <= TileScrollBar.Position) or (CurTilePos >= TileScrollBar.Position + 5) then
        TileScrollBar.Position := CurTilePos;
      DrawTileSelector();
    end;
  end
  else if _EditingMode = OBJEDITINGMODE then
  begin
    _CurrentObj := RNAROM.GetCurrentEnemy(X div 2, Y div 2);
//    showmessage(IntToStr(_CurrentObj));
    if _CurrentObj > -1 then
    begin
      StatusBar.Panels[1].Text := RNAROM.EnemyNames[RNAROM.Levels[RNAROM.Level].ScreenEnemies[_CurrentObj].ID];
      if Button = mbRight then
      begin
        if ssShift in Shift then
        begin
          EnemyProp := TfrmEnemyProperties.Create(self);
          try
            EnemyProp.ID := _CurrentObj;
            EnemyProp.ShowModal;
            _CurrentObj := -1;
            StatusBar.Panels[1].Text := '';
          finally
            FreeAndNil(EnemyProp);
          end;
        end
        else if ssCtrl in Shift then
        begin
          if messagedlg('Are you sure that you wish to delete this enemy?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
            RNAROM.DeleteEnemy(_CurrentObj);
          _CurrentObj := -1;
          StatusBar.Panels[1].Text := '';           
        end
        else
        begin
          RNAROM.IncrementEnemyID(_CurrentObj);
        end;
        DrawLevelData();
      end
      else if Button = mbMiddle then
      begin
        RNAROM.Increment10EnemyID(_CurrentObj);
        DrawLevelData();
      end;
    end;
  end;
//  showmessage(IntToStr(RNAROM.GetCurrentEnemy(X div 2, Y div 2)));
end;

procedure TfrmRushNAttackEditor.DrawTileSelector();
var
  TileSelector : TBitmap32;
  tlFont : TFont;
begin
  TileSelector := TBitmap32.Create;
  try
    TileSelector.Height := 192;
    TileSelector.Width := 32;
    RNAROM.DrawTileSelector(TileScrollbar.Position,TileSelector);
    tlFont := TFont.Create;
    tlFont.Name := 'Tahoma';
    tlFont.Size := 7;

    tlFont.Color := wincolor(RNAOptions.LeftTextColour);
    TileSelector.Font := tlFont;
    if (CurTileLeft >= TileScrollbar.Position) and (CurTileLeft <= TileScrollbar.Position + 5) then
    begin
      if CurTileLeft = CurTileMid then
      begin
        TileSelector.Line(0,(CurTileLeft - TileScrollBar.Position)*32,0,(CurTileLeft-TileScrollBar.Position)* 32 + 32,RNAOptions.LeftTextColour);
        TileSelector.Line(0,(CurTileLeft - TileScrollBar.Position)*32,32,(CurTileLeft-TileScrollBar.Position)* 32,RNAOptions.LeftTextColour);
      end
      else
        TileSelector.FrameRectS(0,(CurTileLeft - TileScrollBar.Position)*32,32,(CurTileLeft-TileScrollBar.Position)* 32 + 32,RNAOptions.LeftTextColour);
//      TileSelector.FrameRectS(0,(CurTileLeft - TileScrollBar.Position)*32,32,(CurTileLeft-TileScrollBar.Position)* 32 + 32,clRed32);
      if RNAOptions.DispLeftMidText = true then
        TileSelector.Textout(1,(CurTileLeft - TileScrollBar.Position)*32,'Left');
    end;
    TileSelector.Font.Color := wincolor(RNAOptions.MiddleTextColour);
    if (CurTileMid >= TileScrollbar.Position) and (CurTileMid <= TileScrollbar.Position + 5) then
    begin
      if CurTileLeft = CurTileMid then
      begin
        TileSelector.Line(31,(CurTileMid - TileScrollBar.Position)*32,31,(CurTileMid-TileScrollBar.Position)* 32 + 32,RNAOptions.MiddleTextColour);
        TileSelector.Line(0,(CurTileMid - TileScrollBar.Position)*32+31,32,(CurTileMid-TileScrollBar.Position)* 32+31,RNAOptions.MiddleTextColour);
      end
      else
        TileSelector.FrameRectS(0,(CurTileMid - TileScrollBar.Position)*32,32,(CurTileMid-TileScrollBar.Position)* 32 + 32,RNAOptions.MiddleTextColour);

//      TileSelector.FrameRectS(0,(CurTileMid - TileScrollBar.Position)*32,32,(CurTileMid-TileScrollBar.Position)* 32 + 32,clGreen32);
      if RNAOptions.DispLeftMidText = true then
        TileSelector.Textout(1,(CurTileMid - TileScrollBar.Position)*32+16,'Middle');
    end;
    imgCurTile.Bitmap := TileSelector;
  finally
    FreeAndNil(tlFont);
    FreeAndNil(TileSelector);
  end;
end;


procedure TfrmRushNAttackEditor.TileScrollBarChange(Sender: TObject);
begin
  DrawTileSelector();
end;

procedure TfrmRushNAttackEditor.TileScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  DrawTileSelector();
end;

procedure TfrmRushNAttackEditor.imgCurTileMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if CurTSABlock = -1 then
  begin
    if Button = mbLeft then
      CurTileLeft := TileScrollBar.Position + (Y div 64)
    else if (Button = mbMiddle) or ((ssShift in Shift) and (Button = mbLeft)) then
      CurTileMid := TileScrollBar.Position + (Y div 64);
    DrawTileSelector();
  end
  else
  begin
    if Button = mbLeft then
    begin
      RNAROM.EditTSA(TileScrollBar.Position + (Y div 64),(y mod 64) div 16,x div 16,CurTSABlock);
    end
    else if Button = mbRight then
    begin
      RNAROM.IncrementBlockAttributes(TileScrollBar.Position + (Y div 64),(y mod 64) div 32, x div 32);
    end;
    DrawLevelData();
    DrawTileSelector();
    UpdateTitleCaption;
  end;
end;

procedure TfrmRushNAttackEditor.actEnableGridlinesExecute(Sender: TObject);
begin
  RNAOptions.GridlinesOn := not(RNAOptions.GridlinesOn);
  tlbEnableGridlines.Down := RNAOptions.GridlinesOn;
  mnuGridlines.Checked := RNAOptions.GridlinesOn;
  DrawLevelData();
end;


procedure TfrmRushNAttackEditor.RedrawScreen;
begin
  RNAROM.RefreshOnScreenTiles(TileScrollbar.Position);
  DrawLevelData;
  DrawTileSelector;
  if CurTSABlock > -1 then
    TfrmTSAEditor(TSA).DrawPatternTable;  
end;

procedure TfrmRushNAttackEditor.actCreateTSAEditorExecute(Sender: TObject);
begin
  if CurTSABlock = -1 then
    TSA := TfrmTSAEditor.Create(self);

  TSA.Show;
end;

procedure TfrmRushNAttackEditor.actCreatePaletteEditorExecute(
  Sender: TObject);
var
  Palette : TfrmPaletteEditor;
begin
  Palette := TfrmPaletteEditor.Create(self);
  try
    DropFileTarget.Dragtypes := [];
    Palette.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];
    UpdateTitleCaption;    
  finally
    FreeAndNil(Palette);
  end;
end;

procedure TfrmRushNAttackEditor.actSaveROMExecute(Sender: TObject);
begin

  if Assigned(RNAROM)  then
  begin
    if RNAOptions.BackupFilesWhenSaving = True then
      BackupFile();
    if RNAROM.Save = True then
      messagebox(Handle,'Changes Saved.',PChar(APPLICATIONNAME),0)
    else
      messagebox(Handle,'Save failed. Another program probably has the ROM opened.',PChar(APPLICATIONNAME),0);
    UpdateTitleCaption;
  end;

end;

procedure TfrmRushNAttackEditor.actCloseROMExecute(Sender: TObject);
begin
  CloseROM(False);
end;

procedure TfrmRushNAttackEditor.CloseROM(pDisableCancel : Boolean);
var
  MsgRes : Integer;
begin
  if RNAOptions.Changed = True then
    RNAOptions.Save;

  if Assigned(RNAROM) = True then
  begin
    if RNAROM.Changed = True then
    begin
      if pDisableCancel = True then
        MsgRes := MessageDlg('This ROM has some changes. Do you wish to save?',mtConfirmation,[mbYes, mbNo],0)
      else
        MsgRes := MessageDlg('This ROM has some changes. Do you wish to save?',mtConfirmation,[mbYes, mbNo,mbCancel],0);
      if MsgRes = mrYes then
        RNAROM.Save;

      if MsgRes <> mrCancel then
      begin
        FreeAndNil(RNAROM);
        UpdateTitleCaption;
        if pDisableCancel = True then
          SetVisibleStatus(False);
      end;
    end
    else
    begin
      FreeAndNil(RNAROM);
      UpdateTitleCaption;
      if pDisableCancel = True then
        SetVisibleStatus(False);
    end;
  end;

end;

procedure TfrmRushNAttackEditor.actCreatePreferencesExecute(
  Sender: TObject);
var
  Pref : TfrmPreferences;
begin
  Pref := TfrmPreferences.Create(self);
  try
    DropFileTarget.Dragtypes := [];
    Pref.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];
    if Pref.ModalResult = mrOk then
    begin
      RNAOptions.Save;
      SetEmuMenuText();
      SetIPSEnabled;
      if RNAROM <> nil then
      begin
        RNAROM.LoadPaletteFile(RNAOptions.FullPaletteName);
        RNAROM.RefreshOnScreenTiles(TileScrollBar.Position);
//        SetIconTransparency();
        DrawLevelData();
        DrawTileSelector();
        actEnableGridlines.Checked := RNAOptions.GridlinesOn;
      end;
    end;
  finally
    FreeAndNil(Pref);
  end;

end;

procedure TfrmRushNAttackEditor.SetEmuMenuText();
begin
  if (RNAOptions.EmulatorPath <> '') and (FileExists(RNAOptions.EmulatorPath) = True) then
  begin
    mnuLaunchAssociatedEmulator.Caption := 'Launch ' + ExtractFileName(RNAOptions.EmulatorPath);
    mnuLaunchAssociatedEmulator.Enabled := True;
  end
  else
  begin
    mnuLaunchAssociatedEmulator.Caption := 'No Emulator Associated';
    mnuLaunchAssociatedEmulator.Enabled := False;
  end;
  if Assigned(RNAROM) = False then
    mnuLaunchAssociatedEmulator.Enabled := False;
end;

procedure TfrmRushNAttackEditor.SetIPSEnabled();
begin
  if FileExists(RNAOptions.OriginalROMFile) = True then
    actSaveAsIPS.Enabled := True
  else
    actSaveAsIPS.Enabled := False;

  if Assigned(RNAROM) = False then
    actSaveAsIPS.Enabled := False;
end;

procedure TfrmRushNAttackEditor.ExecuteEmulator;
begin
  if Assigned(RNAROM) = False then
  begin
    messagebox(handle,'Please load the ROM first.',PChar(Application.Title),0);
    exit;
  end;

  if (FileExists(RNAOptions.EmulatorPath) = false) or (RNAOptions.EmulatorPath = '') then
  begin
    messagebox(handle,'There is no emulator currently setup with Rock And Roll,' + chr(13) + chr(10)+'or the emulator cannot be found.',PChar(Application.Title),0);
    exit;
  end;
  if RNAOptions.EmulatorDisplaySaveWarning = true then
  begin
    if MessageDlg('Warning: This will save all currently made changes to the ROM. Do you wish to proceed?'+chr(13) + chr(10) + chr(13) + chr(10) + 'Please note, this warning can be disabled in the Preferences dialog.',mtWarning,[mbYes, mbNo],0) = mrNo then
      exit;
  end;

  RNAROM.Save;
  if RNAOptions.EmulatorFileSettings = 0 then
    ShellExecute(Handle,'open',PChar(RNAOptions.EmulatorPath),PChar(' ' + RNAROM.Filename),'',SW_SHOW)
  else if RNAOptions.EmulatorFileSettings = 1 then
    ShellExecute(Handle,'open',PChar(RNAOptions.EmulatorPath),PChar(' ' + ExtractShortPathName(RNAROM.Filename)),'',SW_SHOW)
  else if RNAOptions.EmulatorFileSettings = 2 then
    ShellExecute(Handle,'open',PChar(RNAOptions.EmulatorPath),PChar(' "' + RNAROM.Filename + '"'),'',SW_SHOW);
end;

procedure TfrmRushNAttackEditor.mnuLaunchAssociatedEmulatorClick(
  Sender: TObject);
begin
  ExecuteEmulator();
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRushNAttackEditor.CreateRecentMenu
  Author:    Dan
  Date:      26-Feb-2004
  Arguments:
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRushNAttackEditor.CreateRecentMenu();
begin
  if RNAOptions.NumberOfRecentlyOpenedFiles = 0 then
    mnuRecent.Visible := False
  else
    mnuRecent.Visible := True;

  if RNAOptions.RecentFile[0] = '' then
    mnuRecentItem1.Visible := False
  else
    mnuRecentItem1.Visible := True;

  if RNAOptions.RecentFile[1] = '' then
    mnuRecentItem2.Visible := False
  else
    mnuRecentItem2.Visible := True;

  if RNAOptions.RecentFile[2] = '' then
    mnuRecentItem3.Visible := False
  else
    mnuRecentItem3.Visible := True;

  if RNAOptions.RecentFile[3] = '' then
    mnuRecentItem4.Visible := False
  else
    mnuRecentItem4.Visible := True;
    
  if RNAOptions.RecentFile[4] = '' then
    mnuRecentItem5.Visible := False
  else
    mnuRecentItem5.Visible := True;

  mnuRecentItem1.Caption := '1. ' + RNAOptions.RecentFile[0];
  mnuRecentItem2.Caption := '2. ' + RNAOptions.RecentFile[1];
  mnuRecentItem3.Caption := '3. ' + RNAOptions.RecentFile[2];
  mnuRecentItem4.Caption := '4. ' + RNAOptions.RecentFile[3];
  mnuRecentItem5.Caption := '5. ' + RNAOptions.RecentFile[4];

end;

procedure TfrmRushNAttackEditor.mnuRecentItem1Click(Sender: TObject);
begin
  LoadROM(RNAOptions.RecentFile[TMenuItem(sender).MenuIndex],RNAOptions.FullDataFileName,RNAOptions.AutoCheck);
end;

procedure TfrmRushNAttackEditor.BackupFile();
begin

  if DirectoryExists(ExtractFileDir(ParamStr(0))+'\Backups') = false then
  begin
    CreateDir(ExtractFileDir(ParamStr(0))+'\Backups');
  end;
  ShortDateFormat := 'dd-mm-yyyy';
  TimeSeparator	:= '-';

  AbZip.FileName := ExtractFileDir(ParamStr(0))+'\Backups\RNA ' + DateTimeToStr(Now) + '.zip';
  AbZip.AddFiles(RNAROM.Filename,0);
  AbZip.ZipfileComment := 'ZIP Created By Trip N Slip on: ' + DateTimeToStr(Now);
  AbZip.Save;
end;

procedure TfrmRushNAttackEditor.imgLevelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  Draw : Boolean;
  TempX, TempY : Integer;
begin
  if _EditingMode = MAPEDITINGMODE then
  begin
    if (ssMiddle in Shift) or ((ssShift in Shift) and (ssLeft in Shift)) then
    begin
      RNAROM.EditLevel(x div 64, y div 64,CurTileMid);
      DrawLevelData();
    end
    else if ssLeft in Shift then
    begin
      RNAROM.EditLevel(x div 64, y div 64,CurTileLeft);
      DrawLevelData();
    end;
  end
  else if _EditingMode = OBJEDITINGMODE then
  begin
    if _CurrentObj > -1 then
    begin

      if ssCtrl in Shift then
      begin
        TempX := X div 2;
        TempY := Y div 2;
      end
      else
      begin
        TempX := (((X div 2) div 8) *8);
        TempY := (((Y div 2) div 8) *8);
      end;

      if (X div 2 >= 255) or (Y div 2 >= 255) then exit;
      Draw := False;

      if RNAROM.GetEnemyXY(0,_CurrentObj) <> TempX then
      begin
        RNAROM.SetEnemyXY(TempX,NOTSET,_CurrentObj);
        Draw := True;
      end;

      if RNAROM.GetEnemyXY(1,_CurrentObj) <> TempY then
      begin
        RNAROM.SetEnemyXY(NOTSET,TempY,_CurrentObj);
        Draw := True;
      end;

      if Draw = true then DrawLevelData();

    end;
  end;
end;

procedure TfrmRushNAttackEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if assigned(RNAROM) = True then
  begin

    if Key = VK_PRIOR	then
    begin
      if RNAROM.Level = RNAROM.Levels.Count - 1 then
        RNAROM.Level := 0
      else
        RNAROM.Level := RNAROM.Level + 1;
    end
    else if Key = VK_NEXT	then
    begin
      if RNAROM.Level = 0 then
        RNAROM.Level := RNAROM.Levels.Count - 1
      else
        RNAROM.Level  := RNAROM.Level - 1;
    end
    else
      exit;

    SetupLevel();

{    if CurTSABlock > -1 then
      TfrmTSAEditor(TSA).DrawPatternTable;

    XPos := CVROM.LevelStartX;
    YPos := CVROM.LevelStartY;
    CVROM.ScreenID := CVROM.Map[XPos,YPos];
    SetScreenIDLabel();
    DrawLevelData();
    TileScrollbar.Position := 0;
    DrawTileSelector();
    SetButtonsEnable();}
  end;
end;

procedure TfrmRushNAttackEditor.SetupLevel();
begin
  DrawLevelData();
  SetEnabledButtonState;
  SetScreenLabel;
  TileScrollBar.Position := 0;
  TileScrollbar.Max := RNAROM.Levels[RNAROM.Level].NumberOfBlocks - 6;
  DrawTileSelector();
  UpdateTitleCaption();
  actNewEnemy.Enabled := False;
end;

procedure TfrmRushNAttackEditor.actSetObjEditingModeExecute(
  Sender: TObject);
begin
  actSetObjEditingMode.Checked := True;
  actSetMapEditingMode.Checked := False;

  // Set the toolbar buttons
  tlbSetMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbSetObjEditingMode.Down := actSetObjEditingMode.Checked;

  _EditingMode := OBJEDITINGMODE;

  Statusbar.Panels[0].Text := 'Object Editing Mode';
end;

procedure TfrmRushNAttackEditor.actSetMapEditingModeExecute(
  Sender: TObject);
begin
  actSetObjEditingMode.Checked := False;
  actSetMapEditingMode.Checked := True;

  // Set the toolbar buttons
  tlbSetMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbSetObjEditingMode.Down := actSetObjEditingMode.Checked;

  _EditingMode := MAPEDITINGMODE;

  Statusbar.Panels[0].Text := 'Map Editing Mode';
end;

procedure TfrmRushNAttackEditor.imgLevelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if _EditingMode = OBJEDITINGMODE then
  begin
    _CurrentObj := -1;
  end;
  UpdateTitleCaption();
  StatusBar.Panels[1].Text := '';
end;

procedure TfrmRushNAttackEditor.mnuViewEnemiesClick(Sender: TObject);
begin
  DrawLevelData();
end;

procedure TfrmRushNAttackEditor.DisableImages();
begin
  mnuGridlines.ImageIndex := -1;
  mnuObjectEditingMode.ImageIndex := -1;
  mnuMapEditingMode.ImageIndex := -1;
end;

procedure TfrmRushNAttackEditor.actCreatePropertiesExecute(
  Sender: TObject);
var
  Prop : TfrmProperties;
begin
  Prop := TfrmProperties.Create(self);
  try
    DropFileTarget.Dragtypes := [];
    Prop.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];
  finally
    FreeAndNil(Prop);
  end;
end;

procedure TfrmRushNAttackEditor.actCreateROMPropertiesExecute(
  Sender: TObject);
var
  ROMProp : TfrmROMProperties;
begin
  ROMProp := TfrmROMProperties.Create(self);
  try
    DropFileTarget.Dragtypes := [];
    ROMProp.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];
    UpdateTitleCaption;
  finally
    FreeAndNil(ROMProp);
  end;
end;

function TfrmRushNAttackEditor.AutoCheckROMType(pFilename : String) : String;
var
  DataFiles : TStringList;
  INI : TMemINIHexFile;
  i : Integer;
  Loc : Integer;
  Auto1,Auto2,Auto3,Auto4 : Byte;
  TempROM : TiNESImage;
begin
  result := '';
  DataFiles := TStringList.Create;
  try
    DataFiles.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');

    for i := 0 to DataFiles.Count -1 do
    begin
      INI := TMemINIHexFile.Create(ExtractFileDir(Application.ExeName) + '\Data\' + DataFiles[i]);
      try
        Loc := INI.ReadHexValue('AutoCheck','Location');
        Auto1 := INI.ReadHexValue('AutoCheck','Auto1');
        Auto2 := INI.ReadHexValue('AutoCheck','Auto2');
        Auto3 := INI.ReadHexValue('AutoCheck','Auto3');
        Auto4 := INI.ReadHexValue('AutoCheck','Auto4');
        TempROM := TiNESImage.Create(pFilename);
        if TempROM.ROM[Loc] = Auto1 then
          if TempROM.ROM[Loc+1] = Auto2 then
            if TempROM.ROM[Loc+2] = Auto3 then
              if TempROM.ROM[Loc+3] = Auto4 then
              begin
                result := DataFiles[i];
                break;
              end;
      finally
        FreeAndNil(TempROM);
        FreeAndNil(INI);
      end;
    end;
  finally
    FreeAndNil(DataFiles);
  end;
end;

procedure TfrmRushNAttackEditor.actCreateJumpToExecute(Sender: TObject);
var
  JumpTo : TfrmJumpTo;
begin
  JumpTo := TfrmJumpTo.Create(self);
  try
    DropFileTarget.Dragtypes := [];
    JumpTo.ShowModal;
    DropFileTarget.Dragtypes := [dtCopy];
    if JumpTo.ModalResult = mrOK then
    begin
      if JumpTo.SelectedLevel <= RNAROM.Levels.Count -1 then
        RNAROM.Level := JumpTo.SelectedLevel;
      SetupLevel();
    end;
  finally
    FreeAndNil(JumpTo);
  end;
end;

procedure TfrmRushNAttackEditor.TileScrollBarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then
    Key := 0;
end;

procedure TfrmRushNAttackEditor.DropFileTargetDrop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  LoadROM(dropfiletarget.Files[0],RNAOptions.FullDataFileName,RNAOptions.AutoCheck);
  RNAOptions.AddRecentFile(dropfiletarget.Files[0]);

end;

procedure TfrmRushNAttackEditor.actSaveAsIPSExecute(Sender: TObject);
var
  output : String;
begin
  if Assigned(RNAROM) then
  begin
    if (FileExists(RNAOptions.OriginalROMFile) = true) then
    begin
      if RNAOptions.IPSOutput = '' then
        Output := ChangeFileExt(RNAROM.Filename,'.ips')
      else
        Output := RNAOptions.IPSOutput;

      RNAROM.Save;
      LunarIPSCreate(handle,PChar(Output),PChar(RNAOptions.OriginalROMFile),PChar(RNAROM.Filename),0);
      UpdateTitleCaption;
    end;
  end;
end;

procedure TfrmRushNAttackEditor.mnuHomepageClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('http://dan.panicus.org'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmRushNAttackEditor.actNewEnemyExecute(Sender: TObject);
begin
  RNAROM.AddNewEnemy();
  DrawLevelData();
  UpdateTitleCaption;
  if (RNAOptions.ChangeToObjectModeWhenAddingEnemy = True) and (_EditingMode = MAPEDITINGMODE) then
    actSetObjEditingMode.Execute;

end;

end.
