{*****************************************************************}
{                                                                 }
{       Mutex                                                     }
{         for ARSSE                                               }
{                                                                 }
{       Copyright (c) 2010 Gregor A. Cieslak (a.k.a. Shoozza)     }
{       All rights reserved                                       }
{                                                                 }
{       NOT free to distribute or modify                          }
{                                                                 }
{*****************************************************************}

unit Mutex;

{$MODE Delphi}

interface

implementation

uses
  // system libs
  Windows,
  
  // arsse units
  VersionInfo;

var
  mHandle: THandle;

initialization
  mHandle := CreateMutex(Nil, True, PChar('ARSSEv' + VERSION + '.' +
    VERSIONBUILD));

  if GetLastError = ERROR_ALREADY_EXISTS then
    Halt;

finalization
  if mHandle <> 0 then
    CloseHandle(mHandle);
end.