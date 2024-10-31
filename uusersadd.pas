unit uUsersAdd;

{$mode ObjFPC}{$H+}

interface

uses
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
   ExtCtrls;

type

   { TfUsersAdd }

   TfUsersAdd = class(TForm)
      btnUserAdd: TButton;
      edtUserPassword: TEdit;
      edtUserName: TEdit;
      edtUserID: TEdit;
      edtConfirmPassword: TEdit;
      lblUserPassword: TLabel;
      lblUserName: TLabel;
      lblUserID: TLabel;
      lblConfirmPassword: TLabel;
      pnlStatus: TPanel;
      procedure btnUserAddClick(Sender: TObject);
   private

   public

   end;

var
   fUsersAdd: TfUsersAdd;

const
  VALID_PASSWORD:    integer = 31;

implementation

uses uPasswordEval;

{$R *.lfm}

{ TfUsersAdd }

procedure TfUsersAdd.btnUserAddClick(Sender: TObject);
var
   iStatus:    integer;
begin
   if not(edtUserPassword.Text = edtConfirmPassword.Text) then begin
     pnlStatus.Caption:='Password and confirming password do not match';
     edtConfirmPassword.SetFocus;
     exit;
   end;
   iStatus := PasswordEval(edtUserPassword.Text);
   if (iStatus = VALID_PASSWORD) then begin
      pnlStatus.Caption:='';
      // Store the new user ID and passowrd.

   end
   else begin
     pnlStatus.Caption := PasswordEvalMsg(iStatus);
   end;
end;

end.

