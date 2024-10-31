unit UnitLogOn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Types, IniFiles;

type

  { TfrmLogOn }

  TfrmLogOn = class(TForm)
    btnLogOn: TButton;
    edtUserID: TEdit;
    edtPassword: TEdit;
    lblUserID: TLabel;
    lblPassword: TLabel;
    pnlStatus: TPanel;
    procedure btnLogOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
     var AppFilePath:   string;
         UserID:        string;
         UserName:      string;
  end;

var
  frmLogOn: TfrmLogOn;
  Share:    string;         // Publically shared App. Directory Path

implementation

uses unitMyApplication;

{$R *.lfm}

procedure TfrmLogOn.btnLogOnClick(Sender: TObject);
begin
   // If there is no established file path to the data files
   If (AppFilePath = '') or
      (not FileExists(AppFilePath+DirectorySeparator+'Users.dat')) then begin
      // Test for the backdoor User ID and Password
      if (edtUserID.Text = 'Back') and
         (edtPassword.Text = 'Door') then begin
         UserID := 'BAdmin';
         UserName := 'BAdminstrator';
         pnlStatus.Caption := '';
         edtUserID.Text := '';
         edtPassword.Text := '';
         Visible := False;
         frmMyApplication.ShowModal;
         Visible:= True;
         edtUserID.SetFocus;
      end
      else begin
          pnlStatus.Caption:=edtUserID.Text + ' Log On Failed';
          edtUserID.Text := '';
          edtPassword.Text := '';
          edtUserID.SetFocus;
          edtUserID.Refresh;
      end;
  end; // If there is no established file path
end;

procedure TfrmLogOn.FormCreate(Sender: TObject);
//const
//  FileName:         string = '';
var
//  MyAppFilePath:     TextFile;
  INI:               TIniFile;

begin
  INI := TIniFile.Create('Shares.ini');
  AppFilePath := INI.ReadString('MyApplication','Shares','');
  INI.Free;

{  FileName := GetCurrentDir+DirectorySeparator+'MyApplicationFilePath.dat';
  if FileExists(FileName) then begin
     AssignFile(MyAppFilePath, FileName);
     Reset(MyAppFilePath);
     if ( not EOF(MyAppFilePath)) then
        ReadLn(MyAppFilePath, AppFilePath);
     AppFilePath := Trim(AppFilePath);
     CloseFile(MyAppFilePath);
  end; }
end;

end.

