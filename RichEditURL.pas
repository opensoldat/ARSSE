
unit RichEditURL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls,
  ComCtrls, ExtCtrls, RichEdit;
  
type
  TURLClickEvent = procedure(Sender :TObject; const URL: string) of object;

  TRichEditURL = class(TRichEdit)
  private
    FOnURLClick: TURLClickEvent;
    procedure CNNotify(var Msg: TWMNotify); message CN_NOTIFY;
  protected
    procedure DoURLClick (const URL : string);
    procedure CreateWnd; override;
  published
    property OnURLClick : TURLClickEvent read FOnURLClick write FOnURLClick;
  end;

procedure Register;
  
  
implementation

procedure Register;
begin
  RegisterComponents('delphi.about.com', [TRichEditURL]);
end;


{ TRichEditURL }
procedure TRichEditURL.DoURLClick(const URL : string);
begin
  if Assigned(FOnURLClick) then OnURLClick(Self, URL);
end; (*DoURLClick*)

procedure TRichEditURL.CNNotify(var Msg: TWMNotify);
var
  p: TENLink;
  sURL: string;
begin
  if (Msg.NMHdr^.code = EN_LINK) then
  begin
   p := TENLink(Pointer(Msg.NMHdr)^);
   if (p.Msg = WM_LBUTTONDOWN) then
   begin
    try
     SendMessage(Handle, EM_EXSETSEL, 0, Longint(@(p.chrg)));
     sURL := SelText;
     DoURLClick(sURL);
    except
    end;
   end;
  end;

 inherited;
end; (*CNNotify*)

procedure TRichEditURL.CreateWnd;
var
  mask: Word;
begin
  inherited CreateWnd;

  SendMessage(Handle, EM_AUTOURLDETECT,1, 0);
  mask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0);
  SendMessage(Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
end; (*CreateWnd*)

end. (* RichEditURL.pas *)
