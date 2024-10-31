program myapplication;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UnitLogOn, unitMyApplication, uSetPath, uUsersAdd,
  uPasswordEval, uRFileIO;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
   Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmLogOn, frmLogOn);
  Application.CreateForm(TfrmMyApplication, frmMyApplication);
   Application.CreateForm(TfSetPath, fSetPath);
   Application.CreateForm(TfUsersAdd, fUsersAdd);
  Application.Run;
end.

