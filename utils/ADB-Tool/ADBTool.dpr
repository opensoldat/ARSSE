program ADBTool;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  crc32 in 'crc32.pas',
  countryflags in 'countryflags.pas';

{$E .exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ARSSE DB Tool';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
