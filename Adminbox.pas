{**********************************************************************}
{                                                                      }
{       Adminbox unit                                                  }
{         for ARSSE                                                    }
{                                                                      }
{       Copyright (c) 2005-2008 Harsányi László (a.k.a. KeFear)        }
{       Copyright (c) 2010 Gregor A. Cieslak (a.k.a. Shoozza)          }
{       All rights reserved                                            }
{                                                                      }
{       NOT free to distribute or modify                               }
{                                                                      }
{**********************************************************************}

unit Adminbox;

interface

uses
  // system libs 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TAdminReq = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdminReq: TAdminReq;

implementation

uses Unit1;

{$R *.dfm}

procedure TAdminReq.BitBtn1Click(Sender: TObject);
begin
 AdminReq.Close;
end;

procedure TAdminReq.FormShow(Sender: TObject);
begin
 AdminReq.ClientWidth:= Label1.Width + 100;
 Label1.Left:= 50;
 BitBtn1.Left:= AdminReq.ClientWidth div 2 - BitBtn1.Width div 2;
 Beep;
 Beep;
 Beep;
 Beep;
 Beep;
 Beep;
 Beep;
 Beep;
 
end;

end.
