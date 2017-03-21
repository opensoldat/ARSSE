object Form1: TForm1
  Left = 221
  Top = 125
  BorderStyle = bsToolWindow
  Caption = 'ARSSE DB Tool v1.0.0.2'
  ClientHeight = 118
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 44
    Width = 33
    Height = 13
    Caption = 'csv-file'
  end
  object Label2: TLabel
    Left = 8
    Top = 68
    Width = 34
    Height = 13
    Caption = 'adb-file'
  end
  object Label3: TLabel
    Left = 8
    Top = 92
    Width = 31
    Height = 13
    Caption = 'crc-file'
  end
  object Label4: TLabel
    Left = 432
    Top = 14
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object OpenAdbButton: TButton
    Left = 648
    Top = 64
    Width = 33
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = OpenAdbButtonClick
  end
  object CsvFilenameEdit: TEdit
    Left = 48
    Top = 40
    Width = 601
    Height = 21
    TabOrder = 1
    Text = 'C:\ip.csv'
  end
  object CheckButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 2
    OnClick = CheckButtonClick
  end
  object ConvertButton: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 3
    OnClick = ConvertButtonClick
  end
  object MakeChecksumButton: TButton
    Left = 248
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Make Checksum'
    TabOrder = 4
    OnClick = MakeChecksumButtonClick
  end
  object AdbFilenameEdit: TEdit
    Left = 48
    Top = 64
    Width = 601
    Height = 21
    TabOrder = 5
    Text = 'C:\ip.adb'
  end
  object OpenCsvButton: TButton
    Left = 648
    Top = 40
    Width = 33
    Height = 21
    Caption = '...'
    TabOrder = 6
    OnClick = OpenCsvButtonClick
  end
  object LoadTestButton: TButton
    Left = 168
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load Test'
    TabOrder = 7
    OnClick = LoadTestButtonClick
  end
  object CrcFilenameEdit: TEdit
    Left = 48
    Top = 88
    Width = 601
    Height = 21
    TabOrder = 8
    Text = 'C:\ip.crc'
  end
  object OpenCrcFile: TButton
    Left = 648
    Top = 88
    Width = 33
    Height = 21
    Caption = '...'
    TabOrder = 9
    OnClick = OpenCrcFileClick
  end
  object Button1: TButton
    Left = 352
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Search IP'
    TabOrder = 10
    OnClick = Button1Click
  end
  object IpEdit: TEdit
    Left = 448
    Top = 10
    Width = 89
    Height = 21
    MaxLength = 15
    TabOrder = 11
    Text = '248.157.165.233'
  end
  object Edit1: TEdit
    Left = 544
    Top = 9
    Width = 97
    Height = 21
    TabOrder = 12
    Text = '1493172223'
  end
  object Button2: TButton
    Left = 648
    Top = 8
    Width = 33
    Height = 25
    Caption = 'nr2ip'
    TabOrder = 13
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Top = 88
  end
end
