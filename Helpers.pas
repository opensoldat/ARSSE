{*****************************************************************}
{                                                                 }
{       Helper functions                                          }
{         for ARSSE                                               }
{                                                                 }
{       Copyright (c) 2011 Gregor A. Cieslak (a.k.a. Shoozza)     }
{       All rights reserved                                       }
{                                                                 }
{       NOT free to distribute or modify                          }
{                                                                 }
{*****************************************************************}

unit Helpers;

{$MODE Delphi}

interface

uses
  Classes;

function Ctrl: Boolean;
function Shift: Boolean;
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);

implementation

uses
  Windows;

function Ctrl: Boolean;
var
  allapot: TKeyboardState;
begin
  GetKeyboardState(allapot);
  Result := ((allapot[vk_Control] and 128) <> 0);
end;

function Shift: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

end.