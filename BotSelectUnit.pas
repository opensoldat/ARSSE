{**********************************************************************}
{                                                                      }
{       Choose bot window unit                                         }
{         for ARSSE                                                    }
{                                                                      }
{       Copyright (c) 2005-2008 Harsányi László (a.k.a. KeFear)        }
{       Copyright (c) 2010 Gregor A. Cieslak (a.k.a. Shoozza)          }
{       All rights reserved                                            }
{                                                                      }
{       NOT free to distribute or modify                               }
{                                                                      }
{**********************************************************************}

unit BotSelectUnit;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TBotHelp = class(TForm)
    BotList: TListBox;
    Label1: TLabel;
    Timer1: TTimer;
    procedure BotListDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotListKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BotHelp: TBotHelp;

implementation

uses ParameterInputUnit;

{$R *.lfm}

procedure TBotHelp.BotListDblClick(Sender: TObject);
begin
 MyDialogBox.ParamValue.Text:=BotList.Items[BotList.ItemIndex];
end;

procedure TBotHelp.Timer1Timer(Sender: TObject);
begin
  BotHelp.Left:=MyDialogBox.Left+MyDialogBox.Width;
  BotHelp.Top:=MyDialogBox.Top;
end;

procedure TBotHelp.FormShow(Sender: TObject);
begin
 Timer1.Enabled:=true;
 BotList.Height:= BotList.Items.Count * canvas.TextHeight('a') + 5; //14;
 Label1.Top:= BotList.Top + BotList.Height + 15;
 BotHelp.Height:= Label1.Top + 49;
end;

procedure TBotHelp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Timer1.Enabled:=false;
end;

procedure TBotHelp.BotListKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then MyDialogBox.ParamValue.Text:=BotList.Items[BotList.ItemIndex];
 if Key=#27 then MyDialogBox.CharlieButtonClick(nil);
end;

end.
