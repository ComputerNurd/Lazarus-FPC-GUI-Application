// UsrRec.inc
// --------------------------------------------------------------------
// This included code defines the User Record type
//
// The user record consists of the following fields:
//                          Field       Data  # of
// Field Description        Name        Type  Bytes
// ------------------------ ----------- ----- -----
// User record status       UsrStat     char     1
// User's full name         UsrName     char    25
// User's Identification    UsrID       char    25
// MD5 hash UsrID+password  UsrMD5      char    17
// User's access code       UsrAccess   char     1
//
type
   TUsrRec = packed record
      UsrStat:    char;
      UsrName:    array[0..24] of char;
      UsrID:      array[0..24] of char;
      UsrMD5:     array[0..16] of char;
      UsrAccess:  char;
   end;
