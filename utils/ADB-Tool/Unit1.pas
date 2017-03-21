unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, crc32, StrUtils, countryflags, IdGlobal;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    OpenAdbButton: TButton;
    CsvFilenameEdit: TEdit;
    CheckButton: TButton;
    ConvertButton: TButton;
    MakeChecksumButton: TButton;
    AdbFilenameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenCsvButton: TButton;
    LoadTestButton: TButton;
    CrcFilenameEdit: TEdit;
    Label3: TLabel;
    OpenCrcFile: TButton;
    Label4: TLabel;
    Button1: TButton;
    IpEdit: TEdit;
    Edit1: TEdit;
    Button2: TButton;
    procedure OpenAdbButtonClick(Sender: TObject);
    procedure CheckButtonClick(Sender: TObject);
    procedure ConvertButtonClick(Sender: TObject);
    procedure OpenCsvButtonClick(Sender: TObject);
    procedure LoadTestButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MakeChecksumButtonClick(Sender: TObject);
    procedure OpenCrcFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// countries will be saved as byte numbers this table is for convertion
const
  CountryCodes: array[0..252] of string = ('--', 'AP', 'EU', 'AD', 'AE', 'AF',
    'AG', 'AI', 'AL', 'AM', 'AN', 'AO', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AW',
    'AZ', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI', 'BJ', 'BM', 'BN',
    'BO',
    'BR',
    'BS', 'BT', 'BV', 'BW', 'BY', 'BZ', 'CA', 'CC', 'CD', 'CF', 'CG', 'CH',
    'CI',
    'CK', 'CL', 'CM', 'CN', 'CO', 'CR', 'CU', 'CV', 'CX', 'CY', 'CZ', 'DE',
    'DJ',
    'DK', 'DM', 'DO', 'DZ', 'EC', 'EE', 'EG', 'EH', 'ER', 'ES', 'ET', 'FI',
    'FJ',
    'FK', 'FM', 'FO', 'FR', 'FX', 'GA', 'GB', 'GD', 'GE', 'GF', 'GH', 'GI',
    'GL',
    'GM', 'GN', 'GP', 'GQ', 'GR', 'GS', 'GT', 'GU', 'GW',
    'GY', 'HK', 'HM', 'HN', 'HR', 'HT', 'HU', 'ID', 'IE', 'IL', 'IN', 'IO',
    'IQ',
    'IR', 'IS', 'IT', 'JM', 'JO', 'JP', 'KE', 'KG', 'KH', 'KI', 'KM', 'KN',
    'KP',
    'KR', 'KW', 'KY', 'KZ', 'LA', 'LB', 'LC', 'LI', 'LK', 'LR', 'LS', 'LT',
    'LU',
    'LV', 'LY', 'MA', 'MC', 'MD', 'MG', 'MH', 'MK', 'ML', 'MM', 'MN', 'MO',
    'MP',
    'MQ', 'MR', 'MS', 'MT', 'MU', 'MV', 'MW', 'MX', 'MY', 'MZ', 'NA', 'NC',
    'NE',
    'NF', 'NG', 'NI', 'NL', 'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'PA', 'PE',
    'PF',
    'PG', 'PH', 'PK', 'PL', 'PM', 'PN', 'PR', 'PS', 'PT', 'PW', 'PY', 'QA',
    'RE',
    'RO', 'RU',
    'RW', 'SA', 'SB', 'SC', 'SD', 'SE', 'SG', 'SH', 'SI', 'SJ', 'SK', 'SL',
    'SM',
    'SN', 'SO', 'SR', 'ST', 'SV', 'SY', 'SZ', 'TC', 'TD', 'TF', 'TG', 'TH',
    'TJ',
    'TK', 'TM', 'TN', 'TO', 'TL', 'TR', 'TT', 'TV', 'TW', 'TZ', 'UA', 'UG',
    'UM',
    'US', 'UY', 'UZ', 'VA', 'VC', 'VE', 'VG', 'VI', 'VN', 'VU', 'WF', 'WS',
    'YE',
    'YT', 'RS', 'ZA', 'ZM', 'ME', 'ZW', 'A1', 'A2', 'O1', 'AX', 'GG', 'IM',
    'JE',
    'BL', 'MF');
var
  Form1: TForm1;

implementation

{$R *.dfm}

// this holds one line of the adb file
type
  abd_line = packed record
    endip: DWord;           // startip is the endip +1  of the previous adb line
    countryId: byte;        // country of the ip range
  end;

procedure TForm1.OpenAdbButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'ARSSE DB|*.ADB';
  if OpenDialog1.Execute then
    AdbFilenameEdit.Text := OpenDialog1.FileName;
end;

// check if adb's crc is valid
procedure TForm1.CheckButtonClick(Sender: TObject);
var
  crcfile: TextFile;
  crcvar: Cardinal;
  filesize: int64;
  fail: word;
  text: string;
begin
  // make sure files exist
  if (AdbFilenameEdit.Text <> '') and (FileExists(AdbFilenameEdit.Text)) and
    (CrcFilenameEdit.Text <> '') and (FileExists(CrcFilenameEdit.Text)) then
  begin
    // calculate crc for adb file
    CalcFileCRC32(AdbFilenameEdit.Text, crcvar, filesize, fail);

    // open crc file and check it is equal to the adb's crc
    AssignFile(crcfile, CrcFilenameEdit.Text);
    Reset(crcfile);
    Read(crcfile, text);
    if StrToCard(text) = crcvar then
      ShowMessage('crc valid')
    else
      ShowMessage('crc failed');
    CloseFile(crcfile);
  end
  else
    ShowMessage('Adb/Crc-File not found!');
end;

procedure TForm1.ConvertButtonClick(Sender: TObject);
var
  dbFile: file of abd_line;
  line: abd_line;
  csvfile: TextFile;
  text: string;
  startip, endip, lastendip, laststartip: dword;
  i: integer;
  p: array[1..6] of integer;
  countryname: string;
begin
  if (AdbFilenameEdit.Text <> '') and (CsvFilenameEdit.Text <> '')
    and (FileExists(CsvFilenameEdit.Text)) then
  begin
    // open adb file for writing
    AssignFile(dbfile, AdbFilenameEdit.Text);
    ReWrite(dbfile);

    // open csv file for reading
    AssignFile(csvfile, CsvFilenameEdit.Text);
    Reset(csvfile);

    lastendip := 0;       // last end ip from the csv file
    laststartip := 0;     // last start ip from the csv file

    // go through the whole csv file
    while not Eof(csvfile) do
    begin

      ReadLn(csvfile, text);    // read one line in the csv file

      //phrase lines
      //getpositions
      for i := 1 to 6 do
      begin
        if i = 1 then
        begin
          // filter out other entries
          p[i] := PosEx('"', text);  // leave only this one when using short format
          p[i] := PosEx('"', text, p[i] + 1);
          p[i] := PosEx('"', text, p[i] + 1);
          p[i] := PosEx('"', text, p[i] + 1);
          p[i] := PosEx('"', text, p[i] + 1);
        end
        else
          p[i] := PosEx('"', text, p[i - 1] + 1);
      end;

      //cut out the needed parts
      startip := StrToInt64(copy(text, p[1] + 1, p[2] - p[1] - 1));
      endip := StrToInt64(copy(text, p[3] + 1, p[4] - p[3] - 1));
      countryname := copy(text, p[5] + 1, p[6] - p[5] - 1);

      //convert countryid
      for i := 0 to 253 do
      begin
        if countryname = CountryCodes[i] then
          break;
      end;
      if (i = 252) and (countryname <> CountryCodes[i]) then
        ShowMessage('coutryid error');

      //check for forgotten entries
      if startip - 1 <> lastendip then
      begin
        line.endip := startip - 1;
        line.countryId := 0;

        Write(dbfile, line);
      end;

      // check if the ip's are in a sorted order
      if (lastendip > endip) then
      begin
        ShowMessage('unsorted! ' + IntToStr(laststartip) + '>' +
          IntToStr(startip));
      end;
      lastendip := endip;
      laststartip := startip;

      //fill our line
      line.endip := endip;
      line.countryId := i;

      Write(dbfile, line);
    end;

    CloseFile(csvfile);
    // Close the writer
    CloseFile(dbfile);
    ShowMessage('Adb created');
  end
  else
    ShowMessage('Csv/Adb filename incorrect!');
end;

// open CSV file
procedure TForm1.OpenCsvButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'IP DB CSV|*.CSV';      // only allow .csv files
  if OpenDialog1.Execute then                   // if file has been choosen
    CsvFilenameEdit.Text := OpenDialog1.FileName;      // get the name
end;

// test procedure for outputting endip's
// currently only outputting the first two lines of the adb file
procedure TForm1.LoadTestButtonClick(Sender: TObject);
var
  dbFile: file of abd_line;
  line: abd_line;
begin
  if (AdbFilenameEdit.Text <> '') and (FileExists(AdbFilenameEdit.Text)) then
  begin
    AssignFile(dbfile, AdbFilenameEdit.Text);
    Reset(dbfile);

    //    while not Eof(dbfile) do      // we don't want a messagebox flood
    begin
      Read(dbfile, line);
      showmessage('line.endip=' + IntToStr(line.endip) + ' line.country=' +
        IntToStr(line.countryId));

      Read(dbfile, line);
      showmessage('line.endip=' + IntToStr(line.endip) + ' line.country=' +
        IntToStr(line.countryId));
    end;

    CloseFile(dbfile);
  end
  else
    ShowMessage('Adb-File not found!');
end;

// closes the program when esc has been pressed
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then
    Form1.Close;
end;

// writes the crc file with the checksum
procedure TForm1.MakeChecksumButtonClick(Sender: TObject);
var
  crcvar: Cardinal;
  filesize: int64;
  fail: word;
  crcfile: TextFile;
  //  text: string;
begin
  // check if adb file exists
  if (AdbFilenameEdit.Text <> '') and (FileExists(AdbFilenameEdit.Text)) and
    (CrcFilenameEdit.Text <> '') then
  begin
    // generate checksum
    CalcFileCRC32(AdbFilenameEdit.Text, crcvar, filesize, fail);
    if fail <> 0 then
      showmessage('crc failed')
    else
    begin
      // write crc file
      AssignFile(crcfile, CrcFilenameEdit.Text);
      ReWrite(crcfile);
      Write(crcfile, inttostr(crcvar));
      CloseFile(crcfile);

      ShowMessage(inttostr(crcvar) + ' written');
    end;
  end
  else
    ShowMessage('Adb-File not found!');
end;

// open crc file
procedure TForm1.OpenCrcFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'CRC File|*.crc';         // only allow .crc files
  if OpenDialog1.Execute then                     // if file has been choosen
    CrcFilenameEdit.Text := OpenDialog1.FileName;       // get the name
end;

// on create form
procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.Title := Form1.Text;      // add version number to taskbar title
end;

// this function was used for speedtesting the search implementation
procedure TForm1.Button1Click(Sender: TObject);
var
  dbfile: TFlagDB;
  {
   s: string;
   pos1, pos2, pos3: integer;
   numb1, numb2, numb3, numb4: integer;
   ipnumb1, ipnumb2: dword;
   fail: boolean;
   dbFile: file of abd_line;
   line: abd_line;
   size: dword;
   cluster: byte;
   StartTime: TDateTime;}
  startt{, endt}: cardinal;
  cc: byte;
begin
  if (AdbFilenameEdit.Text <> '') and (FileExists(AdbFilenameEdit.Text)) then
  begin
    startt := GetTickCount;
    dbfile := TFlagDB.Create(AdbFilenameEdit.Text);
    cc := dbfile.GetFlagId(IpEdit.Text);
    dbfile.Destroy;
    startt := GetTickCount - startt;
    ShowMessage(' countrycode=' + inttostr(cc) + ' country=' + CountryCodes[cc]);
    ShowMessage('s=' + IntToStr(startt));
    {s := IpEdit.Text;
    if s <> '' then
    begin
      pos1 := posEx('.', s);
      pos2 := posEx('.', s, pos1 + 1);
      pos3 := posEx('.', s, pos2 + 1);
      if (pos1 <> 0) and (pos2 <> 0) and (pos3 <> 0) and
        (pos1 + 1 <> pos2) and (pos2 + 1 <> pos3) and (pos3 <> Length(s)) then
      begin
        numb1 := StrToIntDef(copy(s, 0, pos1 - 1), -42);
        if (numb1 > 255) or (numb1 < 0) then
        begin
          Showmessage('out of ip range #1');
          fail := true;
        end;
        numb2 := StrToIntDef(copy(s, pos1 + 1, pos2 - pos1 - 1), -42);
        if (numb2 > 255) or (numb2 < 0) then
        begin
          Showmessage('out of ip range #2');
          fail := true;
        end;
        numb3 := StrToIntDef(copy(s, pos2 + 1, pos3 - pos2 - 1), -42);
        if (numb3 > 255) or (numb3 < 0) then
        begin
          Showmessage('out of ip range #3');
          fail := true;
        end;
        numb4 := StrToIntDef(copy(s, pos3 + 1, Length(s) - pos3), -42);
        if (numb4 > 255) or (numb4 < 0) then
        begin
          Showmessage('out of ip range #4');
          fail := true;
        end;
        //Showmessage('A=' + inttostr(numb1) + ' B=' + inttostr(numb2) + ' C=' +
        //  inttostr(numb3) + ' D=' + inttostr(numb4));
      end
      else
      begin
        ShowMessage('bad ip');
        fail := true;
      end;
      //      StartTime := now;
      startt := GetTickCount;

      if not fail then
      begin
        ipnumb1 := numb1 shl 24 + numb2 shl 16 + numb3 shl 8 + numb4;
        //ipnumb2 := numb1 * 16777216 + numb2 * 65536 + numb3 * 256 + numb4;
        // if (ipnumb1 = ipnumb2) then
         //  ShowMessage('ip ok')
         //else
          // ShowMessage('ip diff');

        AssignFile(dbfile, AdbFilenameEdit.Text);
        Reset(dbfile);
        size := (FileSize(dbfile) div 256);
        cluster := (numb1 + 2); //div 4;
        //cluster := cluster + 1;

        repeat
          if (cluster = 0) then
          begin
            //showmessage('cluster =0 so we breake');
            break;
          end;
          cluster := cluster - 1;
          seek(dbfile, cluster * size);
          Read(dbfile, line);
          //ShowMessage('cluster:=' + IntToStr(cluster) + ' ip=' +
          //inttostr(ipnumb1) + ' cur=' + inttostr(line.endip) + ' fl=' +
            //CountryCodes[line.countryId]);
        until line.endip < ipnumb1;
        seek(dbfile, cluster * size);

        while not Eof(dbfile) do
        begin
          Read(dbfile, line);
          if line.endip > ipnumb1 then
          begin
            //ShowMessage(' cur=' + inttostr(line.endip) + 'countrycode=' +
            //  inttostr(line.countryId) + ' country='
            //  + CountryCodes[line.countryId]);
            break;
          end;
        end;

        CloseFile(dbfile);
        //ShowMessage(formatdatetime('hh:nn:ss:zzz', Now - StartTime));
        endt := GetTickCount;
        ShowMessage(inttostr(endt - startt));
        ShowMessage(' cur=' + inttostr(line.endip) + 'countrycode=' +
          inttostr(line.countryId) + ' country='
          + CountryCodes[line.countryId]);

      end;
    end;       }

  end
  else
    ShowMessage('Adb-File not found!');
end;

// convert text to ip representation
procedure TForm1.Button2Click(Sender: TObject);
var
  numb, a, b, c, d: integer;
begin
  // example text: 1493172223
  numb := StrToIntDef(Edit1.Text,-1);
  if numb = -1 then
    ShowMessage('Cannot convert "'+ Edit1.Text +'" to ip. Not valid format.')
  else
  begin
    // numb := StrToInt(Edit1.Text);
    a := numb shr 24;
    numb := numb - (a shl 24);
    b := numb shr 16;
    numb := numb - (b shl 16);
    c := numb shr 8;
    numb := numb - (c shl 8);
    d := numb;
    Edit1.Text:= inttostr(a)+'.'+inttostr(b)+'.'+inttostr(c)+'.'+inttostr(d);
  end;
end;

end.

