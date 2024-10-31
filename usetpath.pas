unit uSetPath;

{$mode ObjFPC}{$H+}

interface

uses
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
   IniFiles;

type

   { TfSetPath }

   TfSetPath = class(TForm)
      btnChoose: TButton;
      btnSave: TButton;
      dlgSelDir: TSelectDirectoryDialog;
      edtPath: TEdit;
      Label1: TLabel;
      procedure btnChooseClick(Sender: TObject);
      procedure btnSaveClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
   private

   public

   end;

var
   fSetPath: TfSetPath;

implementation

uses UnitLogOn;

{$R *.lfm}

{ TfSetPath }

procedure TfSetPath.FormShow(Sender: TObject);
var
   INI:  TIniFile;
begin
   INI := TIniFile.Create('Shares.ini');
   Share := INI.ReadString('MyApplication', 'Shares', '');
   INI.Free;

   if (length(Share) > 0) then
      edtPath.Text := Share;
end;

procedure TfSetPath.btnChooseClick(Sender: TObject);
begin
   if (dlgSelDir.Execute ) then begin
     if ( dlgSelDir.FileName > '' ) then
        edtPath.Text:=dlgSelDir.FileName;
   end;
end;

procedure TfSetPath.btnSaveClick(Sender: TObject);
var
   INI:  TIniFile;
  sTmp:  string;
begin
   sTmp := edtPath.Text;
   Share := Trim(sTmp);

   INI := TINIFile.Create('Shares.ini');
   INI.WriteString('MyApplication','Shares',sTmp);
   INI.Free;
   Close;
end;

end.

