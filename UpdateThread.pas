{**********************************************************************}
{                                                                      }
{       UpdateThread                                                   }
{         for ARSSE                                                    }
{                                                                      }
{       Copyright (c) 2008-2009 Harsányi László (a.k.a. KeFear         }
{       Copyright (c) 2008-2011 Gregor A. Cieslak (a.k.a. Shoozza)     }
{       All rights reserved                                            }
{                                                                      }
{       NOT free to distribute or modify                               }
{                                                                      }
{**********************************************************************}

unit UpdateThread;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, IdHTTP, ShellApi,
  VersionInfo;

const
  // update files
  CHANGESFILE = 'changes' + CHANGESPERFIX + VERSIONSTATUS + '.txt';
  UPDATEFILE = 'update' + CHANGESPERFIX + VERSIONSTATUS + '.dat';
  UPDATEWEBFILE = 'update.dat.php?v=' +  VERSIONSTATUS;

type
  TUpdateThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure DoUpdate;
    procedure ShowRestartQuestion;
    procedure ShowUptoDate;
    procedure Execute; override;
  public
    UpdateTime: TDateTime;
    IsAuto: boolean;
  end;

  function VersionCheck(CurrentVersion: string; UpdateVersion: string): Boolean;
  function IsFileInUse(const fName: TFileName): Boolean;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure UpdateThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ UpdateThread }

uses Unit1, StrUtils;

var
  IdHttp1: TIdHTTP;
  FileS: TFileStream;
  F: TextFile;
  FARSSE: file;

  text, filename: string;
  temppath: array[0..MAX_PATH] of char;
  needrestart: boolean;

procedure TUpdateThread.ShowUptoDate;
begin
  ShowMessage('Your version is up-to-date.')
end;

function IsFileInUse(const fName: TFileName): Boolean;
var
  HFileRes: HFILE;
begin
  HFileRes := CreateFile(PChar(fName),
                         GENERIC_READ or GENERIC_WRITE,
                         0,
                         nil,
                         OPEN_EXISTING,
                         FILE_ATTRIBUTE_NORMAL,
                         0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

procedure TUpdateThread.ShowRestartQuestion;
var
    delay : byte;
begin
  if needrestart and (IDYes = MessageBoxA(Application.Handle,
      'Update finished, and ARSSE needs a restart. Do you wish to restart ARSSE now?',
      'Restart', MB_YesNo + MB_IconQuestion + MB_DefButton2)) then
  begin
    Form1.SaveConfig(ExtractFilePath(Application.ExeName) + 'arsse.ini');
    ShellExecute(0, nil, PChar(Application.ExeName), Pchar(''), Pchar(''),
        SW_NORMAL);
    delay:=0;
    
    while not IsFileInUse(Application.ExeName) and (delay<37) do
    begin
        sleep(100);
        delay := delay+1;
    end;
    if delay >= 37 then
    begin
      ShowMessage('Restarting failed. Closing in 2 seconds');
      Sleep(2000);
    end;
    Application.Terminate;
  end;

end;

function HTTPFileExists(aURL: string): Boolean;
begin
  with TIdHTTP.Create(nil) do
    try
      try
        Head(aURL);
        Result := ResponseCode = 200;
      except
        Result := False;
      end;
    finally
      Free;
    end;
end;

function VersionCheck(CurrentVersion: string; UpdateVersion: string): Boolean;
var
  DotPos: array[1..3] of integer;
  VersionNum, UpdateNum: array[1..4] of integer;
begin
  // example: 'v22.33.44.111'

  DotPos[1] := PosEx('.', CurrentVersion);
  DotPos[2] := PosEx('.', CurrentVersion, DotPos[1] + 1);
  DotPos[3] := PosEx('.', CurrentVersion, DotPos[2] + 1);

  // check if version number is correnct
  if (CurrentVersion[1] <> 'v') or (DotPos[1] = 0) or (DotPos[2] = 0) or
    (DotPos[3] = 0) then
  begin
    Result := False;
    exit;
  end;

  VersionNum[1] := StrToIntDef(Copy(CurrentVersion, 2, DotPos[1] - 2), -1);
  VersionNum[2] := StrToIntDef(Copy(CurrentVersion, DotPos[1] + 1, DotPos[2] -
    DotPos[1] - 1), -1);
  VersionNum[3] := StrToIntDef(Copy(CurrentVersion, DotPos[2] + 1, DotPos[3] -
    DotPos[2] - 1), -1);
  VersionNum[4] := StrToIntDef(Copy(CurrentVersion, DotPos[3] + 1,
    Length(CurrentVersion) - DotPos[3]), -1);

  // check if version number was really a number
  if (VersionNum[1] = -1) or (VersionNum[2] = -1) or (VersionNum[3] = -1) or
    (VersionNum[4] = -1) then
  begin
    Result := False;
    exit;
  end;

  // same for UpdateVersion
  DotPos[1] := PosEx('.', UpdateVersion);
  DotPos[2] := PosEx('.', UpdateVersion, DotPos[1] + 1);
  DotPos[3] := PosEx('.', UpdateVersion, DotPos[2] + 1);

  // check if version number is correnct
  if (UpdateVersion[1] <> 'v') or (DotPos[1] = 0) or (DotPos[2] = 0) or
    (DotPos[3] = 0) then
  begin
    Result := False;
    exit;
  end;

  UpdateNum[1] := StrToIntDef(Copy(UpdateVersion, 2, DotPos[1] - 2), -1);
  UpdateNum[2] := StrToIntDef(Copy(UpdateVersion, DotPos[1] + 1, DotPos[2] -
    DotPos[1] - 1), -1);
  UpdateNum[3] := StrToIntDef(Copy(UpdateVersion, DotPos[2] + 1, DotPos[3] -
    DotPos[2] - 1), -1);
  UpdateNum[4] := StrToIntDef(Copy(UpdateVersion, DotPos[3] + 1,
    Length(UpdateVersion) - DotPos[3]), -1);

  // check if version number was really a number
  if (UpdateNum[1] = -1) or (UpdateNum[2] = -1) or (UpdateNum[3] = -1) or
    (UpdateNum[4] = -1) then
  begin
    Result := False;
    exit;
  end;

  // check if UpdateVersion is newer then CurrentVersion
  if (UpdateNum[1] > VersionNum[1]) or
    (UpdateNum[1] = VersionNum[1]) and (UpdateNum[2] > VersionNum[2]) or
    (UpdateNum[1] = VersionNum[1]) and (UpdateNum[2] = VersionNum[2]) and
      (UpdateNum[3] > VersionNum[3]) or
    (UpdateNum[1] = VersionNum[1]) and (UpdateNum[2] = VersionNum[2]) and
      (UpdateNum[3] = VersionNum[3]) and (UpdateNum[4] > VersionNum[4]) then
  begin
    Result := True;
  end
  else
    Result := False;
end;

procedure TUpdateThread.DoUpdate;
const
  HOST = 'http://arsse.u13.net/';
var
  filelist, filenamelist: TStrings;
  i: integer;
var
  extension: string;
begin
  // TODO:
  // Make sure we can write to the ARSSE folder (request admin rights)
  // Rename the files we are coping to
  // Delete renamed files after successful copying
  // Rename files back when copying fails
  // Check downloaded files with CRC or MD5

  GetTempPath(SizeOf(temppath) - 1, temppath);

  needrestart := false;

  // delete temporary files from last update
  if (fileexists(StrPas(temppath) + UPDATEFILE)) then
  begin
    if not DeleteFile(StrPas(temppath) + UPDATEFILE) then
    begin
      if not IsAuto then
        ShowMessage('Cannot delete temporary file.' + #13#10 +
            'Update Canceled.');
      exit;
    end;
  end;

  IdHttp1 := TIdHttp.Create(nil);  // does this need special checking?

  // check if serverfile is reachable
  if (not HTTPFileExists(HOST + UPDATEWEBFILE)) then
  begin
    if not IsAuto then
      ShowMessage('Cannot find file on the server.' + #13#10 +
          'Are you connected to the internet?');
    // clean up
    IdHttp1.Free;
    exit;
  end;

  // download update file
  try
    FileS := TFileStream.Create(StrPas(temppath) + UPDATEFILE, fmcreate);
    IdHttp1.Get(HOST + UPDATEWEBFILE, FileS);
  except
    if not IsAuto then
      ShowMessage('Cannot download update information file.' + #13#10 +
          'Are you connected to the internet?');

    // clean up
    IdHttp1.Free;
    FileS.Free;

    exit;
  end;

  // clean up
  IdHttp1.Free;
  FileS.Free;

  // check if information file was downloaded
  if not fileexists(StrPas(temppath) + UPDATEFILE) then
  begin
    if not IsAuto then
      ShowMessage('Cannot find downloaded update information file.' + #13#10 +
          'Update canceled.');
    exit;
  end;

  // check if update file can be opened
  try
    AssignFile(F, StrPas(temppath) + UPDATEFILE);
    FileMode := fmOpenRead;
    Reset(F);
  except
    if not IsAuto then
      ShowMessage('Cannot open update information file.' + #13#10 +
          'Update canceled.');

    // just to be sure...
    try
      CloseFile(F);
    finally;
    end;

    exit;
  end;

  try
    filelist := TStringlist.Create();
  except
    if not IsAuto then
      ShowMessage('Cannot allocate list of files.' + #13#10 +
          'Update canceled.');

      CloseFile(F);
      exit;
  end;

  // loop through the update information file and download updates
  while (not Eof(F)) and (not terminated) do
  begin
    ReadLn(F, text);

    // only handle correct lines
    if not Form1.Matches('v*.*.*.*|http://*/*.*^', text) then
    begin
      continue;
    end;

    // skip old version files
    if (not VersionCheck('v' + VERSION + '.' + VERSIONBUILD, Copy(text, 1,
        Pos('|', text) - 1))) then
    begin
      continue;
    end;

    // cut out the http://... link
    filename := Copy(text, Pos('|', text) + 1, Pos('^', text) -
        Pos('|', text) - 1);

    // add to our download list
    filelist.Add(filename);
  end;

  CloseFile(F);

  // check if there are any updates available
  if filelist.Count=0 then
  begin
    filelist.Free;

    if not IsAuto then
      ShowMessage('Your version is up-to-date.');
    exit;
  end;

  // ask if we want to update
  if IDno = MessageBoxA(Application.Handle,
      'New Version of ARSSE available! Do you wish to download updates?',
      'New version of ARSSE', MB_YesNo + MB_IconQuestion + MB_DefButton2)
      then
  begin
    filelist.Free;

    exit;
  end;

  i := 0;

  // check if server has the file we want to download
  try
    while  i<filelist.Count do
    begin
      if not HTTPFileExists(filelist[i]) then
      begin
        showMessage('File not found on the server:' + #13#10 +
            filelist[i]+ #13#10 + 'Update Canceled.');

        filelist.Free;

        exit;
      end;
      i := i + 1;
    end;
  except
    try
      showMessage('Error while checking for webserver files:' +
          #13#10 + 'Update Canceled.');
      filelist.Free;
    finally;
    end;
    exit;
  end;

  i := 0;
  filenamelist := nil;

  // download all files into the temp folder
  try
    filenamelist := TStringlist.Create();

    while i<filelist.Count do
    begin
      filename := filelist[i];

      // extract filename
      while Pos('/', filename) > 0 do
      begin
        filename := Copy(filename, Pos('/', filename) + 1, Length(filename));
      end;

      // remove additional html link stuff
      if Pos('?', filename)>0  then
      begin
        filename:=Copy(filename,1,Pos('?', filename) - 1);
      end;

      extension := filename;

      // get real extension
      while Pos('.', extension) > 0 do
      begin
        extension := Copy(extension, Pos('.', extension) + 1,
            Length(extension));
      end;

      // assume that if the extension is exe it must be the application exe
      if(extension = 'exe') then
      begin
        filename := ExtractFileName(Application.ExeName);
      end
      else if(extension = 'php') then  // remove .php
      begin
        filename := Copy(filename, 1, Pos('.php', filename) - 1);
      end;

      // cleanup tempfile
      if fileexists(StrPas(temppath) + filename) then
      begin
        if not DeleteFile(StrPas(temppath) + filename) then
        begin
          ShowMessage('Cannot prepare temporary files.' + #13#10 +
              'Update Canceled.');

          filelist.Free;
          filenamelist.Free;

          exit;
        end;
      end;

      // creating tempfile for downloading
      try
        FileS := TFileStream.Create(StrPas(temppath) + filename, fmcreate)
      except
        ShowMessage('Could not create tempfile.' + #13#10 + filename +
            'Update Canceled.');

        filelist.Free;
        filenamelist.Free;

        exit;
      end;

      filenamelist.Add(filename);  // we need to move them to arsse folder later

      // Downloading updates
      try
        IdHttp1 := TIdHttp.Create(nil);
        IdHttp1.Get(filelist[i], FileS);
      except
        ShowMessage('File download error:' + #13#10 + filelist[i] + #13#10 +
            'Update Canceled.');
        try
          filelist.Free;
          filenamelist.Free;
          FileS.Free;
          IdHttp1.Free;
        finally;
        end;

        exit;
      end;

      //clean up
      IdHttp1.Free;
      FileS.Free;

      i := i + 1;
    end;
  except
    ShowMessage('Error while downloading files:' + #13#10 +
        'Update Canceled.');

    // clean up
    try
      filelist.Free;
      filenamelist.Free;
      FileS.Free;
      IdHttp1.Free;
    finally
    end;

    exit;
  end;

  // clean up
  filelist.Free;

  i := 0;
  
  // copy temporary files into arsse folder
  while i < filenamelist.Count do
  begin

    extension := filenamelist[i];

    // get extension
    while Pos('.', extension) > 0 do
    begin
      extension := Copy(extension, Pos('.', extension) + 1, Length(extension));
    end;

    try
      AssignFile(FARSSE, ExtractFilePath(Application.ExeName) + filenamelist[i]);
      if extension = 'exe' then
      begin
        Rename(FARSSE, ExtractFilePath(Application.ExeName) + filenamelist[i] +
            '_old');
        CloseFile(FARSSE);
      end
      else if not (extension = 'adb') then
      begin
        if (FileExists(ExtractFilePath(Application.ExeName) + filenamelist[i]))
            and (not DeleteFile(ExtractFilePath(Application.ExeName) +
            filenamelist[i])) then
        begin
          ShowMessage('Could not delete file:' + #13#10 +
              ExtractFilePath(Application.ExeName) + filenamelist[i] + #13#10 +
              'Update Canceled.');
          try
            filenamelist.Free;
            CloseFile(FARSSE);
          finally
          end;
          
          exit;
        end;
        CloseFile(FARSSE);
      end;
    except
      ShowMessage('Copying temporary files into arsse folder failed.' + #13#10 +
            'Update Canceled.');
      try
        filenamelist.Free;
        CloseFile(FARSSE);
      finally
      end;
      
      exit;
    end;

    if  extension = 'adb' then
    begin
      if not movefile(PAnsiChar(StrPas(temppath) + filenamelist[i]),
          PAnsiChar(ExtractFilePath(Application.ExeName)+ '\\data\\' +
          filenamelist[i] + '_new')) then
      begin
        ShowMessage('Error copying temporary file into arsse folder.' + #13#10 +
            'Update Canceled.');

        filenamelist.Free;

        exit;
      end;
    end
    else
    begin
      if not movefile(PAnsiChar(StrPas(temppath) + filenamelist[i]),
          PAnsiChar(ExtractFilePath(Application.ExeName) + filenamelist[i]))
          then
      begin
        ShowMessage('Error copying temporary file into arsse folder.' + #13#10 +
            'Update Canceled.');

        filenamelist.Free;

        exit;
      end;
    end;

    Inc(i);
  end;

  filenamelist.Free;
  
  needrestart := true;
  UpdateTime := Date;
  Synchronize(ShowRestartQuestion);
end;

procedure TUpdateThread.Execute;
begin
  // Synchronize(DoUpdate);
  if not Terminated then
  begin
    Synchronize(DoUpdate);

    // we want to use visual compoments thats why Synchronize
    PostMessage(Form1.Handle, WM_UPDATE_COMPLETE, 0, 0);
  end;
end;

end.

