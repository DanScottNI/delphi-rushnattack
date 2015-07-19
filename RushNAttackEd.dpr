{
Copyright (c) 2004 Dan Scott
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

}

program RushNAttackEd;

uses
  Forms,
  frm_RushNAttackMain in 'frm_RushNAttackMain.pas' {frmRushNAttackEditor},
  classes_RNAROM in 'classes_RNAROM.pas',
  frm_About in 'frm_About.pas' {frmAbout},
  frm_TSA in 'frm_TSA.pas' {frmTSAEditor},
  frm_TileEditor in 'frm_TileEditor.pas' {frm8x8TileEditor},
  frm_Palette in 'frm_Palette.pas' {frmPaletteEditor},
  classes_configuration in 'classes_configuration.pas',
  frm_Preferences in 'frm_Preferences.pas' {frmPreferences},
  classes_ROM in 'classes_ROM.pas',
  unit_global in 'unit_global.pas',
  classes_graphics in 'classes_graphics.pas',
  classes_level in 'classes_level.pas',
  frm_OpenDialog in 'frm_OpenDialog.pas' {frmOpenDialog},
  frm_EnemyProp in 'frm_EnemyProp.pas' {frmEnemyProperties},
  frm_ROMProp in 'frm_ROMProp.pas' {frmROMProperties},
  frm_Prop in 'frm_Prop.pas' {frmProperties},
  frm_JumpTo in 'frm_JumpTo.pas' {frmJumpTo},
  unit_lunarcompress in 'unit_lunarcompress.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Trip''n Slip v1.0';
  Application.CreateForm(TfrmRushNAttackEditor, frmRushNAttackEditor);
  Application.Run;
end.
