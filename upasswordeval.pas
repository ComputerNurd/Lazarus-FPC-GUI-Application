unit uPasswordEval;
// Evaluates an entered password to determine if it complies with our
// password rules.
//
// Password rules:                                             Value
//    (1) Must have at least 1 uppercase alpha (A-Z)              1
//    (2) Must have at least 1 lowercase alpha (a-z)              2
//    (3) Must have at least 1 numeric character (0-9)            4
//    (4) Must have at least 1 special character (!@#$5...)       8
//    (5) Must consist of 8 characters or more                   16
//                                                              ---
//         Value derived for a good password -->                 31
//
{$mode ObjFPC}{$H+}

interface

uses
   Classes, SysUtils;

function PasswordEval( Password: string): integer;
function PasswordEvalMsg( PasswordEval: integer ): string;

implementation

function PasswordEval( Password: string): integer;
var
  i:  integer;    // Index into the Password string

begin
  PasswordEval := 0; // A completely invalid password

  if length(Password) = 0 then
     exit;

  For i := 0 to length(Password) do begin
    // Test for uppercase alpha
    if (Password[i] >= 'A') and (Password[i] <= 'Z') then begin
       PasswordEval := PasswordEval or 1;
       continue;
    end;
    // Test for lowercase alpha
    if (Password[i] >= 'a') and (Password[i] <= 'zz') then begin
       PasswordEval := PasswordEval or 2;
       continue;
    end;
    // Test for numeric
    if (Password[i] >= '0') and (Password[i] <= '9') then begin
       PasswordEval := PasswordEval or 4;
       continue;
    end;
    // Test for special characters
    if ((Password[i] >= '!') and (Password[i] <= '/')) or
       ((Password[i] >= ':') and (Password[i] <= '@')) or
       ((Password[i] >= '[') and (Password[i] <= '_')) or
       ((Password[i] >= '{') and (Password[i] <= '}')) then begin
       PasswordEval := Passwordeval or 8;
       continue;
    end;
    // Test for minimum length of 8 special charactercharacters
    if length(Password) >= 8 then
       PasswordEval := PasswordEval or 16;
  end; // End of "For i := 0 to length(Password)"
end; // End of PasswordEval function

function PasswordEvalMsg( PasswordEval: integer ): string;
var
  strTmp:   string;
begin
   strTmp := '';
   if (PasswordEval = 31) then begin
      PasswordEvalMsg := 'Valid Password';
      exit;
   end;

   if (PasswordEval and $F) < $F then begin
      strTmp := 'Password missing';
      if ( PasswordEval and $1 ) = 0 then
         strTmp := strTmp + ' an uppercase alpha';
      if ( PasswordEval and $2 ) = 0 then
         strTmp := strTmp + ' a lowercase alpha';
      if ( PasswordEval and $4 ) = 0 then
         strTmp := strTmp + ' a numeral';
      if ( PasswordEval and $8 ) = 0 then
         strTmp := strTmp + ' a special character';
   end;

   if (PasswordEval and $10) = 0 then begin
      if length( strTmp ) > 0 then
         strTmp := strTmp + ' and has less than 8 characters'
      else
         strTmp := 'Password has less than 8 characters';
   end;

   PasswordEvalMsg := strTmp;
end;

end.

