{**********************************************************************}
{                                                                      }
{       Update Popup                                                   }
{         for ARSSE                                                    }
{                                                                      }
{       Copyright (c) 2009-2010 Gregor A. Cieslak (a.k.a. Shoozza)     }
{       All rights reserved                                            }
{                                                                      }
{       NOT free to distribute or modify                               }
{                                                                      }
{**********************************************************************}

unit UpdatePopup;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,commctrl;

type
  TUpdatePopup1 = class(TForm)
    Memo1: TMemo;
    Ok: TButton;
    procedure OkClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  UpdatePopup1: TUpdatePopup1;

implementation

{$R *.lfm}

procedure TUpdatePopup1.OkClick(Sender: TObject);
begin
 Close;
end;

procedure TUpdatePopup1.FormResize(Sender: TObject);
begin
 UpdatePopup1.Ok.Left:=UpdatePopup1.Width div 2 - Ok.Width div 2;
end;

procedure TUpdatePopup1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 UpdatePopup1.Free;
end;

end.
