{**********************************************************************}
{                                                                      }
{       Edit command window unit                                       }
{         for ARSSE                                                    }
{                                                                      }
{       Copyright (c) 2005-2008 Harsányi László (a.k.a. KeFear)        }
{       Copyright (c) 2010 Gregor A. Cieslak (a.k.a. Shoozza)          }
{       All rights reserved                                            }
{                                                                      }
{       NOT free to distribute or modify                               }
{                                                                      }
{**********************************************************************}

unit CMDedit;

{$MODE Delphi}

interface

uses
  // system libs
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TEditCmd = class(TForm)
    CmdEditor: TMemo;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CmdName: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    item: integer;
  end;

var
  EditCmd: TEditCmd;

implementation

uses MainProgramUnit;

{$R *.lfm}

procedure TEditCmd.BitBtn1Click(Sender: TObject);
var i: integer;
begin
 if item = -1 then
 begin
  item:= Form1.ActionList.Items.Add(CmdName.Text);
  Config.CommandBox[item].Name:= CmdName.Text;
  Config.CommandBox[item].Commands:= TStringList.Create;
  for i:= 0 to CmdEditor.Lines.Count-1 do
    Config.CommandBox[item].Commands.Add(CmdEditor.Lines[i]);
  Form1.ActionList.Selected[item]:= true;
 end
 else
 begin
  Form1.ActionList.Items[item]:= CmdName.Text;
  Config.CommandBox[item].Name:= CmdName.Text;
  Config.CommandBox[item].Commands:= TStringList.Create;
  for i:= 0 to CmdEditor.Lines.Count-1 do
    Config.CommandBox[item].Commands.Add(CmdEditor.Lines[i]);
 end;
end;

procedure TEditCmd.FormShow(Sender: TObject);
begin
 CmdEditor.SetFocus;
end;

end.
