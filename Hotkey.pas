unit Hotkey;

interface

uses
  Classes;

type
  TARSSEHotkey = record
    Text: string;
    Shift: TShiftState;
    Key: Word;
  end;

function ShiftAndKeyToStr(var Key: Word; Shift: TShiftState): String;
function StrToARSSEHotkey(str: string): TARSSEHotkey;

implementation

uses
  SysUtils, Windows, Helpers;

function ShiftAndKeyToStr(var Key: Word; Shift: TShiftState): String;
var
  extrakeys: String;
  pressedkey: String;
  shiftNotNeeded: Boolean;
begin
  Result:='';

  shiftNotNeeded:=false;
  extrakeys:='';

  if ssShift in Shift then
    extrakeys := 'Shift+';
  if ssCtrl in Shift then
    extrakeys := extrakeys + 'Ctrl+';
  if ssAlt in Shift then
    extrakeys := extrakeys + 'Alt+';

  case Key of
    Word('A')..Word('Z'): pressedKey := LowerCase(char(Key));
    Word('0')..Word('9'): pressedKey := char(Key);
    VK_NUMPAD0..VK_NUMPAD9: pressedKey := 'Num' + char(Word('0') + Key - VK_NUMPAD0);
    VK_F1..VK_F12:
    begin
      pressedKey := 'F' + IntToStr(Key - VK_F1 + 1);
      shiftNotNeeded:= true;
    end;
    VK_BACK: pressedKey := 'BkSp';
    VK_CLEAR: pressedKey := 'Clear';
    VK_PAUSE:
    begin
      pressedKey := 'Pause';
      shiftNotNeeded:= true;
    end;
    VK_SPACE: pressedKey := 'Space';
    VK_PRIOR: pressedKey := 'PgUp';
    VK_NEXT: pressedKey := 'PgDn';
    VK_END: pressedKey := 'End';
    VK_HOME: pressedKey := 'Home';
    VK_LEFT: pressedKey := 'Left';
    VK_UP: pressedKey := 'Up';
    VK_RIGHT: pressedKey := 'Right';
    VK_DOWN: pressedKey := 'Down';
    VK_PRINT: pressedKey := 'Print1';
    VK_SNAPSHOT: pressedKey := 'Print2';
    VK_INSERT: pressedKey := 'Ins';
    VK_DELETE: pressedKey := 'Del';
    VK_MULTIPLY: pressedKey := 'Multi';
    VK_ADD: pressedKey := 'Add';
    VK_SEPARATOR: pressedKey := 'Seperator';
    VK_SUBTRACT: pressedKey := 'Sub';
    VK_DECIMAL: pressedKey := 'Decimal';
    VK_DIVIDE: pressedKey := 'Div';
  end;

  // assign keys
  if ((Length(extrakeys) > 0) or shiftNotNeeded) and (Length(pressedkey) > 0) then
    Result := extrakeys + pressedkey
  else
    if ((Key = VK_DELETE) or (Key = VK_BACK)) and (Length(extrakeys) = 0) then
    begin
      Result := ' ';
    end;
end;

function StrToARSSEHotkey(str: string): TARSSEHotkey;
var
  strlist: TStringList;
  i, j: integer;
const
  checkKeyStr: array[0..43] of string =
    (
    'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12',
    'Num0', 'Num1', 'Num2', 'Num3', 'Num4', 'Num5', 'Num6', 'Num7', 'Num8',
    'Num9',
    'BkSp', 'Clear', 'Pause', 'Space', 'PgUp', 'PgDn', 'End', 'Home', 'Left',
    'Up', 'Right', 'Down', 'Print1', 'Print2', 'Ins', 'Del', 'Multi', 'Add',
    'Seperator', 'Sub', 'Decimal', 'Div'
    );
  checkKey: array[0..43] of Word =
    (
    VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9, VK_F10,
    VK_F11, VK_F12,
    VK_NUMPAD0, VK_NUMPAD1, VK_NUMPAD2, VK_NUMPAD3, VK_NUMPAD4, VK_NUMPAD5,
    VK_NUMPAD6, VK_NUMPAD7, VK_NUMPAD8, VK_NUMPAD9,
    VK_BACK, VK_CLEAR, VK_PAUSE, VK_SPACE, VK_PRIOR, VK_NEXT, VK_END, VK_HOME,
    VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_PRINT, VK_SNAPSHOT, VK_INSERT,
    VK_DELETE, VK_MULTIPLY, VK_ADD, VK_SEPARATOR, VK_SUBTRACT, VK_DECIMAL,
    VK_DIVIDE
    );
begin
  Result.Text := '';
  Result.Shift := [];
  Result.Key := 0;

  strlist := TStringList.Create;

  try
    Split('+', str, strlist);
    for i := 0 to strlist.Count-1 do
    begin
      strlist[i] := LowerCase(Trim(strlist[i]));
      if (strlist[i] = 'shift') then
        Result.Shift := Result.Shift + [ssShift]
      else if (strlist[i] = 'ctrl') then
        Result.Shift := Result.Shift + [ssCtrl]
      else if (strlist[i] = 'alt') then
        Result.Shift := Result.Shift + [ssAlt]
      else if (Length(strlist[i]) = 1) and
        (((strlist[i][1] >= 'a') and (strlist[i][1] <= 'z')) or
        ((strlist[i][1] >= '0') and (strlist[i][1] <= '9'))) then
        Result.Key := Word(UpperCase(strlist[i][1])[1])
      else
        for j := 0 to 43 do
          if strlist[i] = LowerCase(checkKeyStr[j]) then
          begin
            Result.Key := checkKey[j];
            break;
          end;
    end;
    Result.Text := ShiftAndKeyToStr(Result.Key, Result.Shift);
    if Length(Result.Text) = 0 then
    begin
      if strlist[0] = ' ' then
        Result.Text := ' ';
      Result.Key := 0;
      Result.Shift := [];
    end;
  finally
    strlist.Free;
  end;
end;


end.
