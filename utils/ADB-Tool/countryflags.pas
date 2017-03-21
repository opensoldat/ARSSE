unit countryflags;

interface
uses windows, StrUtils, SysUtils,dialogs;
type
  TFlagDBLine = packed record
    endip: DWord;
    countryId: byte;
  end;

  TFlagDB = class
  private
    FDBFile: file of TFlagDBLine;
    size: dword;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function GetFlagId(const IpAdress: string): byte;
  end;

  { TFlagDB }

const
  CountryCodes: array[0..252] of string = ('--', 'AP', 'EU', 'AD', 'AE', 'AF',
    'AG', 'AI', 'AL', 'AM', 'AN', 'AO', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AW',
    'AZ', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI', 'BJ', 'BM', 'BN',
    'BO', 'BR', 'BS', 'BT', 'BV', 'BW', 'BY', 'BZ', 'CA', 'CC', 'CD', 'CF',
    'CG', 'CH', 'CI', 'CK', 'CL', 'CM', 'CN', 'CO', 'CR', 'CU', 'CV', 'CX',
    'CY', 'CZ', 'DE', 'DJ', 'DK', 'DM', 'DO', 'DZ', 'EC', 'EE', 'EG', 'EH',
    'ER', 'ES', 'ET', 'FI', 'FJ', 'FK', 'FM', 'FO', 'FR', 'FX', 'GA', 'GB',
    'GD', 'GE', 'GF', 'GH', 'GI', 'GL', 'GM', 'GN', 'GP', 'GQ', 'GR', 'GS',
    'GT', 'GU', 'GW', 'GY', 'HK', 'HM', 'HN', 'HR', 'HT', 'HU', 'ID', 'IE',
    'IL', 'IN', 'IO', 'IQ', 'IR', 'IS', 'IT', 'JM', 'JO', 'JP', 'KE', 'KG',
    'KH', 'KI', 'KM', 'KN', 'KP', 'KR', 'KW', 'KY', 'KZ', 'LA', 'LB', 'LC',
    'LI', 'LK', 'LR', 'LS', 'LT', 'LU', 'LV', 'LY', 'MA', 'MC', 'MD', 'MG',
    'MH', 'MK', 'ML', 'MM', 'MN', 'MO', 'MP', 'MQ', 'MR', 'MS', 'MT', 'MU',
    'MV', 'MW', 'MX', 'MY', 'MZ', 'NA', 'NC', 'NE', 'NF', 'NG', 'NI', 'NL',
    'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'PA', 'PE', 'PF', 'PG', 'PH', 'PK',
    'PL', 'PM', 'PN', 'PR', 'PS', 'PT', 'PW', 'PY', 'QA', 'RE', 'RO', 'RU',
    'RW', 'SA', 'SB', 'SC', 'SD', 'SE', 'SG', 'SH', 'SI', 'SJ', 'SK', 'SL',
    'SM', 'SN', 'SO', 'SR', 'ST', 'SV', 'SY', 'SZ', 'TC', 'TD', 'TF', 'TG',
    'TH', 'TJ', 'TK', 'TM', 'TN', 'TO', 'TL', 'TR', 'TT', 'TV', 'TW', 'TZ',
    'UA', 'UG', 'UM', 'US', 'UY', 'UZ', 'VA', 'VC', 'VE', 'VG', 'VI', 'VN',
    'VU', 'WF', 'WS', 'YE', 'YT', 'RS', 'ZA', 'ZM', 'ME', 'ZW', 'A1', 'A2',
    'O1', 'AX', 'GG', 'IM', 'JE', 'BL', 'MF');

implementation

constructor TFlagDB.Create(const FileName: string);
begin
  inherited Create;
  AssignFile(FDBFile, FileName);
  Reset(FDBFile);
  size := (FileSize(FDBFile) div 256);
end;

function TFlagDB.GetFlagId(const IpAdress: string): byte;
var
  line: TFlagDBLine;
  cluster: byte;
  pos1, pos2, pos3: integer;
  numb1, numb2, numb3, numb4: integer;
  ipnumb1: dword;
  fail: boolean;
begin
  // to get rid of the warnings...
  numb1 := 0;
  numb2 := 0;
  numb3 := 0;
  numb4 := 0;
  fail:=false;

  pos1 := posEx('.', IpAdress);
  pos2 := posEx('.', IpAdress, pos1 + 1);
  pos3 := posEx('.', IpAdress, pos2 + 1);
  if (pos1 <> 0) and (pos2 <> 0) and (pos3 <> 0) and
    (pos1 + 1 <> pos2) and (pos2 + 1 <> pos3) and (pos3 <> Length(IpAdress))
      then
  begin
    numb1 := StrToIntDef(copy(IpAdress, 0, pos1 - 1), -42);
    if (numb1 > 255) or (numb1 < 0) then
    begin
      // Showmessage('out of ip range #1');
      fail := true;
    end;
    numb2 := StrToIntDef(copy(IpAdress, pos1 + 1, pos2 - pos1 - 1), -42);
    if (numb2 > 255) or (numb2 < 0) then
    begin
      // Showmessage('out of ip range #2');
      fail := true;
    end;
    numb3 := StrToIntDef(copy(IpAdress, pos2 + 1, pos3 - pos2 - 1), -42);
    if (numb3 > 255) or (numb3 < 0) then
    begin
      // Showmessage('out of ip range #3');
      fail := true;
    end;
    numb4 := StrToIntDef(copy(IpAdress, pos3 + 1, Length(IpAdress) - pos3),
      -42);
    if (numb4 > 255) or (numb4 < 0) then
    begin
      //Showmessage('out of ip range #4');
      fail := true;
    end;
  end
  else
  begin
    //    ShowMessage('bad ip');
    fail := true;
  end;
  if not fail then
  begin
    ipnumb1 := numb1 shl 24 + numb2 shl 16 + numb3 shl 8 + numb4;
    ShowMessage(inttostr(ipnumb1));
    cluster := (numb1 + 2);

    repeat
      if (cluster = 0) then
        break;

      cluster := cluster - 1;
      seek(FDBFile, cluster * size);
      Read(FDBFile, line);
    until line.endip < ipnumb1;
    seek(FDBFile, cluster * size);

    while not Eof(FDBFile) do
    begin
      Read(FDBFile, line);
      if line.endip > ipnumb1 then
        break;
    end;
    Result := line.countryId;
    ShowMessage(inttostr(line.endip));
  end
  else
    Result := 0;
end;

destructor TFlagDB.Destroy;
begin
  try
    CloseFile(FDBFile);
  except
  end;
  inherited Destroy;
end;

end.

