unit unitMyApplication;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TfrmMyApplication }

  TfrmMyApplication = class(TForm)
     MenuUsersDelte: TMenuItem;
     MenuUsersChange: TMenuItem;
     MenuUsers: TMenuItem;
     MenuUsersAdd: TMenuItem;
     MenuSetPath: TMenuItem;
    MyMainMenu: TMainMenu;
    FilesManu: TMenuItem;
    ReportsMenu: TMenuItem;
    MenuExit: TMenuItem;
    procedure MenuExitClick(Sender: TObject);
    procedure MenuSetPathClick(Sender: TObject);
    procedure MenuUsersAddClick(Sender: TObject);
  private

  public

  end;

var
  frmMyApplication: TfrmMyApplication;

implementation

uses uSetPath, uUsersAdd;
{$R *.lfm}

{ TfrmMyApplication }

procedure TfrmMyApplication.MenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMyApplication.MenuSetPathClick(Sender: TObject);
begin
   fSetPath.ShowModal;
end;

procedure TfrmMyApplication.MenuUsersAddClick(Sender: TObject);
begin
   fUsersAdd.ShowModal;
end;

end.

