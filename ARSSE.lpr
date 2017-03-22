program ARSSE;

{$MODE Delphi}

uses
  Forms, Interfaces,
  MainProgramUnit {Form1},
  ParameterInputUnit {MyDialogBox},
  BotSelectUnit {BotHelp},
  SettingsForm in 'SettingsForm.pas' {Settings1},
  Adminbox in 'Adminbox.pas' {AdminReq},
  CmdEdig in 'CmdEdig.pas' {EditCmd},
  Mutex in 'Mutex.pas',
  UpdateThread in 'UpdateThread.pas',
  UpdatePopup in 'UpdatePopup.pas' {UpdatePopup1},
  FlagDB in 'FlagDB.pas',
  SearchForm in 'SearchForm.pas' {SearchForm1},
  Refreshx in 'Refreshx.pas',
  VersionInfo in 'VersionInfo.pas',
  Helpers in 'Helpers.pas',
  Hotkey in 'Hotkey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Advanced Remote Soldat Server Enchanter';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMyDialogBox, MyDialogBox);
  Application.CreateForm(TBotHelp, BotHelp);
  Application.CreateForm(TSettings1, Settings1);
  Application.CreateForm(TAdminReq, AdminReq);
  Application.CreateForm(TEditCmd, EditCmd);
  Application.CreateForm(TUpdatePopup1, UpdatePopup1);
  Application.CreateForm(TSearchForm1, SearchForm1);
  Application.Run;
end.
