unit source;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.JSON, System.IOUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, ShellApi, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    rbWatch: TRadioButton;
    rbStream: TRadioButton;
    rbListen: TRadioButton;
    rbStop: TRadioButton;
    rbPlay: TRadioButton;
    GroupBox1: TGroupBox;
    edtToken: TEdit;
    lblToken: TLabel;
    imgLogo: TImage;
    GroupBox2: TGroupBox;
    lblVersion: TLabel;
    lblTitle: TLabel;
    lblAddressing: TLabel;
    lblBy: TLabel;
    lblCredit: TLabel;
    ghRaz: TLabel;
    ghTheo: TLabel;
    imgGH: TImage;
    memOutput: TMemo;
    lblStatus: TLabel;
    lblTopic: TLabel;
    edtTopic: TEdit;
    btnPwd: TButton;
    btnReset: TButton;
    Image2: TImage;
    memPython: TMemo;
    procedure ghRazClick(Sender: TObject);
    procedure ghTheoClick(Sender: TObject);
    procedure imgGHClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTokenChange(Sender: TObject);
    procedure rbStopClick(Sender: TObject);
    procedure rbListenClick(Sender: TObject);
    procedure rbStreamClick(Sender: TObject);
    procedure rbWatchClick(Sender: TObject);
    procedure rbPlayClick(Sender: TObject);
    procedure btnPwdClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTopicChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CloseProcessByTitle(const WindowTitle: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sTopic, sToken, sStatus, sJSON: string;
  slJSON: TStringList;
  jVal: TJSONObject;

implementation

{$R *.dfm}

procedure TForm1.CloseProcessByTitle(const WindowTitle: string);
var
  Command: string;
begin
  // Build the taskkill command
  Command := Format('taskkill /FI "WINDOWTITLE eq %s" /F', [WindowTitle]);

  // Execute the command using ShellExecute
  if ShellExecute(0, 'open', 'cmd.exe', PChar('/c ' + Command), nil, SW_HIDE) <= 32 then

  else

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CloseProcessByTitle('AnyStatus | By github.com/raz-js');
DeleteFile(ExtractFilePath(Application.ExeName) + 'res.py')
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('cmd.exe'), PChar('/c ' + 'python.exe -m pip install -r requirements.txt'), PChar(ExtractFilePath(ParamStr(0))), SW_HIDE);
  memOutput.Text := 'AnyStatus has been loaded.';
  memOutput.Lines.Add('Remember to make sure your token is valid!')
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
CloseProcessByTitle('AnyStatus | By github.com/raz-js');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not TFile.Exists(ExtractFilePath(ParamStr(0)) + 'cfg.json') then
  begin
    sJSON :=
    '{'#13#10 +
    '  "status": "stop",'#13#10 +
    '  "topic": " ",'#13#10 +
    '  "token": " "'#13#10 +
    '}';

    TFile.WriteAllText(ExtractFilePath(ParamStr(0)) + 'cfg.json', sJSON);
    memOutput.Lines.Add('Created cfg.json file.')
  end;

  if TFile.Exists(ExtractFilePath(ParamStr(0)) + 'cfg.json') then
  begin
    try
      jVal := TJSONObject(TJSONObject.ParseJSONValue(
          TFile.ReadAllText(ExtractFilePath(ParamStr(0)) + 'cfg.json')));
      memOutput.Lines.Add('Loaded configuration from cfg.json file.');
      try
        if jVal.GetValue<string>('token')=' ' then
        begin
        memOutput.Lines.Add('No token detected.');
        edtToken.Text:='';
          slJSON := TStringList.Create;
           try
              slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

              slJSON[3] := '  "token": " "';

              slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
          finally
              slJSON.Free;
           end;
        end
        else
        begin
          edtToken.Text := jVal.GetValue<string>('token');
        end;
        if jVal.GetValue<string>('topic')=' ' then
        begin
        memOutput.Lines.Add('No topic detected.');
        edtTopic.Text:='';
          slJSON := TStringList.Create;
           try
              slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

              slJSON[2] := '  "topic": " ",';

              slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
          finally
              slJSON.Free;
           end;
        end
        else
        begin
          edtTopic.Text := jVal.GetValue<string>('topic');
        end;
        sStatus := jVal.GetValue<string>('status');
      finally
        jVal.Free;
      end;
    except
      on E: Exception do
        ShowMessage('Error reading JSON: ' + E.Message);
    end;

    if sStatus = 'Stop' then
    begin
      rbStop.Checked := True;
    end;

    if sStatus = 'Playing' then
    begin
      rbPlay.Checked := True;
    end;

    if sStatus = 'Watching' then
    begin
      rbWatch.Checked := True;
    end;

    if sStatus = 'Listening' then
    begin
      rbListen.Checked := True;
    end;

    if sStatus = 'Streaming' then
      begin
      rbStream.Checked := True;
      end;
  end;

end;

procedure TForm1.btnPwdClick(Sender: TObject);
begin
  if btnPwd.Caption = 'Hide Token' then
  begin
    btnPwd.Caption := 'Show Token';
    edtToken.PasswordChar := '*';
    edtToken.SetFocus;
  end
  else
  begin
    btnPwd.Caption := 'Hide Token';
    edtToken.PasswordChar := #0;
    edtToken.SetFocus;
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  sJSON :=
  '{'#13#10 +
  '  "status": "",'#13#10 +
  '  "topic": " ",'#13#10 +
  '  "token": " "'#13#10 +
  '}';

  // Write the JSON string to the file
  TFile.WriteAllText(ExtractFilePath(ParamStr(0)) + 'cfg.json', sJSON);
  memOutput.Lines.Add('Reset cfg.json file.')
end;

procedure TForm1.edtTokenChange(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[3] := '  "token": "' + edtToken.Text + '"';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;
end;

procedure TForm1.edtTopicChange(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[2] := '  "topic": "' + edtTopic.Text + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;
end;

procedure TForm1.ghRazClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://github.com/raz-js'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.ghTheoClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://github.com/its-theo'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.imgGHClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://github.com/Raz-js/AnyStatus'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.rbListenClick(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[1] := '  "status": "' + rbListen.Caption + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;


  if (sToken='') or (sTopic='') then
  begin
    memOutput.Lines.Add('No token or topic detected.');
    rbStop.Checked := True;
  end
  else
  begin
  memPython.Clear;
  memPython.Lines.Add('import requests');
  memPython.Lines.Add('import sys, os');
  memPython.Lines.Add('from time import sleep');
  memPython.Lines.Add('import webbrowser');
  memPython.Lines.Add('import discord');
  memPython.Lines.Add('import json');
  memPython.Lines.Add('from discord.ext import commands');
  memPython.Lines.Add('from console.utils import set_title');
  memPython.Lines.Add('set_title("AnyStatus | By github.com/raz-js")');
  memPython.Lines.Add('client = commands.Bot(');
  memPython.Lines.Add('    command_prefix='':'',');
  memPython.Lines.Add('    self_bot=True,');
  memPython.Lines.Add('    activity=discord.Activity(type=discord.ActivityType.listening, name=''' + edtTopic.Text + '''),');
  memPython.Lines.Add('    intents=discord.Intents.all()');
  memPython.Lines.Add(')');
  memPython.Lines.Add('client.remove_command(''help'')');
  memPython.Lines.Add('');
  memPython.Lines.Add('with open("cfg.json") as file:');
  memPython.Lines.Add('    info = json.load(file)');
  memPython.Lines.Add('    TOKEN = info["token"]');
  memPython.Lines.Add('    ');
  memPython.Lines.Add('client.run(TOKEN, bot=False)');
  memPython.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'res.py');
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'python.exe'), PChar(ExtractFilePath(Application.ExeName) + 'res.py'), nil, SW_HIDE);
  memOutput.Lines.Add('Rich Presence Started --- Listening!');
  end;
end;

procedure TForm1.rbPlayClick(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[1] := '  "status": "' + rbPlay.Caption + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;

  if (sToken='') or (sTopic='') then
  begin
    memOutput.Lines.Add('No token or topic detected.');
    rbStop.Checked := True;
  end
  else
  begin
  CloseProcessByTitle('AnyStatus | By github.com/raz-js');
  memPython.Clear;
  memPython.Lines.Add('import requests');
  memPython.Lines.Add('import sys, os');
  memPython.Lines.Add('from time import sleep');
  memPython.Lines.Add('import webbrowser');
  memPython.Lines.Add('import discord');
  memPython.Lines.Add('import json');
  memPython.Lines.Add('from discord.ext import commands');
  memPython.Lines.Add('from console.utils import set_title');
  memPython.Lines.Add('set_title("AnyStatus | By github.com/raz-js")');
  memPython.Lines.Add('client = commands.Bot(');
  memPython.Lines.Add('    command_prefix='':'',');
  memPython.Lines.Add('    self_bot=True,');
  memPython.Lines.Add('    activity=discord.Activity(type=discord.ActivityType.playing, name=''' + edtTopic.Text + '''),');
  memPython.Lines.Add('    intents=discord.Intents.all()');
  memPython.Lines.Add(')');
  memPython.Lines.Add('client.remove_command(''help'')');
  memPython.Lines.Add('');
  memPython.Lines.Add('with open("cfg.json") as file:');
  memPython.Lines.Add('    info = json.load(file)');
  memPython.Lines.Add('    TOKEN = info["token"]');
  memPython.Lines.Add('    ');
  memPython.Lines.Add('client.run(TOKEN, bot=False)');
  memPython.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'res.py');
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'python.exe'), PChar(ExtractFilePath(Application.ExeName) + 'res.py'), nil, SW_HIDE);
  memOutput.Lines.Add('Rich Presence Started --- Playing!');
  end;
end;

procedure TForm1.rbStopClick(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[1] := '  "status": "' + rbStop.Caption + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;

  CloseProcessByTitle('AnyStatus | By github.com/raz-js');
  memOutput.Lines.Add('Activity Offline.');
end;

procedure TForm1.rbStreamClick(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[1] := '  "status": "' + rbStream.Caption + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;

  if (sToken='') or (sTopic='') then
  begin
    memOutput.Lines.Add('No token or topic detected.');
    rbStop.Checked := True;
  end
  else
  begin
  CloseProcessByTitle('AnyStatus | By github.com/raz-js');
  memPython.Clear;
  memPython.Lines.Add('import requests');
  memPython.Lines.Add('import sys, os');
  memPython.Lines.Add('from time import sleep');
  memPython.Lines.Add('import webbrowser');
  memPython.Lines.Add('import discord');
  memPython.Lines.Add('import json');
  memPython.Lines.Add('from discord.ext import commands');
  memPython.Lines.Add('from console.utils import set_title');
  memPython.Lines.Add('set_title("AnyStatus | By github.com/raz-js")');
  memPython.Lines.Add('client = commands.Bot(');
  memPython.Lines.Add('    command_prefix='':'',');
  memPython.Lines.Add('    self_bot=True,');
  memPython.Lines.Add('    activity=discord.Activity(type=discord.ActivityType.streaming, name=''' + edtTopic.Text + '''),');
  memPython.Lines.Add('    intents=discord.Intents.all()');
  memPython.Lines.Add(')');
  memPython.Lines.Add('client.remove_command(''help'')');
  memPython.Lines.Add('');
  memPython.Lines.Add('with open("cfg.json") as file:');
  memPython.Lines.Add('    info = json.load(file)');
  memPython.Lines.Add('    TOKEN = info["token"]');
  memPython.Lines.Add('    ');
  memPython.Lines.Add('client.run(TOKEN, bot=False)');
  memPython.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'res.py');
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'python.exe'), PChar(ExtractFilePath(Application.ExeName) + 'res.py'), nil, SW_HIDE);
  memOutput.Lines.Add('Rich Presence Started --- Streaming!');
  end;
end;

procedure TForm1.rbWatchClick(Sender: TObject);
begin
  slJSON := TStringList.Create;
  try
    slJSON.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');

    // Replace line 4 with the new token value
    slJSON[1] := '  "status": "' + rbWatch.Caption + '",';

    // Write the modified lines back to the file
    slJSON.SaveToFile(ExtractFilePath(ParamStr(0)) + 'cfg.json');
  finally
    slJSON.Free;
  end;

  if (sToken='') or (sTopic='') then
  begin
    memOutput.Lines.Add('No token or topic detected.');
    rbStop.Checked := True;
  end
  else
  begin
  CloseProcessByTitle('AnyStatus | By github.com/raz-js');
  memPython.Clear;
  memPython.Lines.Add('import requests');
  memPython.Lines.Add('import sys, os');
  memPython.Lines.Add('from time import sleep');
  memPython.Lines.Add('import webbrowser');
  memPython.Lines.Add('import discord');
  memPython.Lines.Add('import json');
  memPython.Lines.Add('from discord.ext import commands');
  memPython.Lines.Add('from console.utils import set_title');
  memPython.Lines.Add('set_title("AnyStatus | By github.com/raz-js")');
  memPython.Lines.Add('client = commands.Bot(');
  memPython.Lines.Add('    command_prefix='':'',');
  memPython.Lines.Add('    self_bot=True,');
  memPython.Lines.Add('    activity=discord.Activity(type=discord.ActivityType.watching, name=''' + edtTopic.Text + '''),');
  memPython.Lines.Add('    intents=discord.Intents.all()');
  memPython.Lines.Add(')');
  memPython.Lines.Add('client.remove_command(''help'')');
  memPython.Lines.Add('');
  memPython.Lines.Add('with open("cfg.json") as file:');
  memPython.Lines.Add('    info = json.load(file)');
  memPython.Lines.Add('    TOKEN = info["token"]');
  memPython.Lines.Add('    ');
  memPython.Lines.Add('client.run(TOKEN, bot=False)');
  memPython.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'res.py');
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'python.exe'), PChar(ExtractFilePath(Application.ExeName) + 'res.py'), nil, SW_HIDE);
  memOutput.Lines.Add('Rich Presence Started --- Watching!');
  end;
end;

end.
