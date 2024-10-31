unit uRFileIO;
// This unit consists of Random Block File Input/Output functions.
//

{$mode ObjFPC}{$H+}
{$PACKRECORDS 1}

interface

uses
   Classes, SysUtils;

function RFileCreate( sPathFileName: string ): boolean;

function RFileAppend( sPathFileName: string; pRec: pointer;
                      iRecSize: integer ): integer;

function RFileRead( sPathFileName: string; iRecNo: integer;
                    pRec: pointer; iRecSize: integer ): integer;

function RFileWrite( sPathFileName: string; iRecNo: integer;
                    pRec: pointer; iRecSize: integer ): integer;
implementation

function RFileCreate( sPathFileName: string ): boolean;
var
   FHandle:    THandle;
begin
   RFileCreate := False;
   if ( not FileExists( sPathFileName ) ) then begin
      FHandle := FileCreate( sPathFileName );
      if ( FHandle = THandle( -1 ) ) then
         exit;
      FileClose( FHandle );
   end;
   RFileCreate := True;
end;

function RFileAppend( sPathFileName: string; pRec: pointer;
                      iRecSize: integer ): integer;
const
   iMode:      integer = fmOpenWrite + fmShareDenyWrite;
   iMaxTries:  integer = 10;
var
   FHandle:    THandle;
   iStat:      integer;
   iTries:     integer;
begin
   // Create the file if it doesn't exist.
   RFileAppend := -1;      // Assuming file creation failure
   if ( not RFileCreate( sPathFileName ) ) then
      exit;

   // Attempt to open the file for exclusive write.
   RFileAppend := -2;      // Assuming file open failure.
   iTries := 0;
   while(iTries < iMaxTries) do begin
      FHandle := FileOpen( sPathFileName, iMode );
      if FHandle = THandle( -1 ) then begin
         Sleep(500);  // Wait 500 milliseconds
         Inc( iTries );
      end
      else  // File open was successful
         break;
   end; // End of "while(iTries < iMaxTries)"
   if FHandle = THandle( -1 ) then
      exit;

   // Position to the end of the file
   RFileAppend := -3;      // Assuming insertion seek failure
   iStat := FileSeek( FHandle, 0, fsFromEnd );
   if iStat < 0 then begin
      FileClose( FHandle );
      exit;
   end;

   // Write the record at the current file position
   RFileAppend := -4;      // Assuming write failure
   iStat := FileWrite( FHandle, pRec^, LongInt(iRecSize));
   FileClose( FHandle );

   if iStat < iRecSize then
      exit;

   // Indicate that RFileAppend is successful
   RFileAppend := 0;

end; // End of RFileAppend

function RFileRead( sPathFileName: string; iRecNo: integer;
                    pRec: pointer; iRecSize: integer ): integer;
const
   iMode:   integer = fmOpenRead + fmShareDenyNone;
var
   FHandle:    THandle;
   iOffset:    Int64;
   iStat:      Int64;
begin
   RFileRead := -1;     // Assume file doesn't exist
   if not FileExists( sPathFileName ) then
      exit;

   RFileRead := -2;     // Assume file open failed
   FHandle := FileOpen( sPathFileName, iMode );
   if FHandle = THandle( -1 ) then
      exit;

   // Calculate the byte offset for the specified record number
   RFileRead := -3;     // Assume record seek failure
   iOffset := Int64(iRecNo) * Int64(iRecSize);
   iStat := FileSeek( FHandle, iOffset, fsFromBeginning);
   if iStat < 0 then
      exit;

   // Read the file at the current position
   iStat := FileRead( FHandle, pRec^, LongInt(iRecSize));
   FileClose( FHandle );
   if iStat < 0 then
      exit;

   // Successful file read
   RFileRead := 0;

end;

function RFileWrite( sPathFileName: string; iRecNo: integer;
                    pRec: pointer; iRecSize: integer ): integer;
const
   iMode:      integer = fmOpenWrite + fmShareDenyWrite;
   iMaxTries:  integer = 10;
var
   FHandle:    THandle;
   iOffset:    Int64;
   iStat:      Int64;
   iTries:     integer;

begin
   RFileWrite := -1; // Assume file doesn't exist
   if not FileExists( sPathFileName ) then
      exit;

   // Attempt to open the file
   RFileWrite := -2;
   while ( iTries < iMaxTries ) do begin
      FHandle := FileOpen( sPathFileName, iMode );
      if FHandle = THandle ( -1 ) then begin
         Sleep(500); // Wait 500 milliseconds
         Inc(iTries);
      end
      else
         break;
   end;
   if FHandle = THandle( -1 ) then
      exit;

   // Calculate the byte offset in the file for the record number
   RFileWrite := -3;
   iOffset := Int64(iRecNo) * Int64(iRecSize);
   iStat := FileSeek( FHandle, iOffset, fsFromBeginning );
   if iStat < 0 then
      exit;

   // Write the record
   RFileWrite := -4;
   iStat := FileWrite( FHandle, pRec^, LongInt(iRecSize) );
   FileClose( FHandle );
   if iStat < Int64( iRecSize ) then
      exit;

   // File write successful
   RFileWrite := 0;

end;

end.

