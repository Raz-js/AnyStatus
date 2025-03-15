program AnyStatus;

uses
  Vcl.Forms,
  source in 'source.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
