; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Exult
AppVerName=Exult 1.7.0git Snapshot
AppPublisher=The Exult Team
AppPublisherURL=http://exult.info/
AppSupportURL=http://exult.info/
AppUpdatesURL=http://exult.info/
; Setup exe version number:
VersionInfoVersion=1.7.0
DisableDirPage=no
DefaultDirName={code:GetExultInstDir|{autopf}\Exult}
DisableProgramGroupPage=no
DefaultGroupName={code:GetExultGroupDir|Exult}
OutputBaseFilename=Exultwin32
Compression=lzma
SolidCompression=yes
InternalCompressLevel=max
OutputDir=.
DisableWelcomePage=no
WizardStyle=modern

[Tasks]

[Types]
Name: full; Description: Full installation
Name: compact; Description: Compact installation
Name: pathsonly; Description: Setup Paths Only
Name: custom; Description: Custom installation; Flags: iscustom

[Components]
Name: Exult; Description: Install Exult; Types: full compact
Name: Docs; Description: Install Exult Documentation; Types: full
Name: GPL; Description: Install GPL License; Types: full compact custom; Flags: fixed
Name: Paths; Description: Setup Game Paths; Types: full compact custom pathsonly
Name: Icons; Description: Create Start Menu Icons; Types: full compact

[Files]
Source: Exult\Exult.exe; DestDir: {app}; Flags: ignoreversion; Components: Exult

Source: Exult\COPYING.txt; DestDir: {app}; Flags: ignoreversion; Components: GPL

Source: Exult\*.dll; DestDir: {app};  Flags: ignoreversion; Components: Exult
Source: Exult\README-SDL.txt; DestDir: {app}; Flags: ignoreversion; Components: Exult

Source: Exult\AUTHORS.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\bgdefaultkeys.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\ChangeLog.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\faq.html; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\FAQ.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\NEWS.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\ReadMe.html; DestDir: {app}; Flags: ignoreversion isreadme; Components: Docs
Source: Exult\README.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\README.win32.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\sidefaultkeys.txt; DestDir: {app}; Flags: ignoreversion; Components: Docs
Source: Exult\images\back.gif; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs01.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs02.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs03.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs04.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs05.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\docs06.png; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs
Source: Exult\images\exult_logo.gif; DestDir: {app}\images; Flags: ignoreversion nocompression; Components: Docs

Source: Exult\Data\exult.flx; DestDir: {app}\data; Flags: ignoreversion; Components: Exult
Source: Exult\Data\exult_bg.flx; DestDir: {app}\data; Flags: ignoreversion; Components: Exult
Source: Exult\Data\exult_si.flx; DestDir: {app}\data; Flags: ignoreversion; Components: Exult

Source: exconfig.dll; Flags: dontcopy
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: {group}\Exult; Filename: {app}\Exult.exe; WorkingDir: {app}; Flags: createonlyiffileexists; Components: Icons
Name: {group}\reset video settings; Filename: {app}\Exult.exe; Parameters: --reset-video; WorkingDir: {app}; Flags: createonlyiffileexists; Components: Icons
Name: {group}\Uninstall Exult; Filename: {uninstallexe}; Components: Icons
Name: {group}\FAQ; Filename: {app}\FAQ.html; Flags: createonlyiffileexists; Components: Icons
Name: {group}\Readme; Filename: {app}\ReadMe.html; Flags: createonlyiffileexists; Components: Icons
; Name: {group}\COPYING; Filename: {app}\COPYING.txt; Flags: createonlyiffileexists; Components: Icons
; Name: {group}\ChangeLog; Filename: {app}\ChangeLog.txt; Flags: createonlyiffileexists; Components: Icons
; Name: {group}\Readme Win32; Filename: {app}\README.win32.txt; Flags: createonlyiffileexists; Components: Icons
; Name: {group}\NEWS; Filename: {app}\NEWS.txt; Flags: createonlyiffileexists; Components: Icons

[Run]
Filename: {app}\Exult.exe; Description: {cm:LaunchProgram,Exult}; WorkingDir: {app}; Flags: nowait postinstall skipifsilent skipifdoesntexist

[Code]
var
  DataDirPage: TWizardPage;
  bSetPaths: Boolean;
  BGBrowseButton: TButton;
  SIBrowseButton: TButton;
  BGText: TNewStaticText;
  SIText: TNewStaticText;
  BGEdit: TEdit;
  SIEdit: TEdit;

// Get Paths from Exult.cfg
procedure GetExultGamePaths(sExultDir, sBGPath, sSIPath: AnsiString; iMaxPath: Integer);
external 'GetExultGamePaths@files:exconfig.dll stdcall';

// Write Paths into Exult.cfg
procedure SetExultGamePaths(sExultDir, sBGPath, sSIPath: AnsiString);
external 'SetExultGamePaths@files:exconfig.dll stdcall';

// Verify BG Dir
function VerifyBGDirectory(sPath: AnsiString) : Integer;
external 'VerifyBGDirectory@files:exconfig.dll stdcall';

// Verify SI Dir
function VerifySIDirectory(sPath: AnsiString) : Integer;
external 'VerifySIDirectory@files:exconfig.dll stdcall';


// Get the Previous Exult Installation Dir
// This is done in a manner that is compatible with the old InstallShield setup
function GetExultInstDir(sDefault: String): String;
var
  sPath: String;
begin

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Exult', 'Path', sPath) then begin
    result := sPath;
  end else
    result := sDefault;
end;

// Get the Previous Exult StartMenu Dir
// This is done in a manner that is compatible with the old InstallShield setup
function GetExultGroupDir(sDefault: String): String;
var
  sPath: String;
begin

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Exult', 'ShellObjectFolder', sPath) then begin
    result := sPath;
  end else
    result := sDefault;
end;

procedure OnBGBrowseButton(Sender: TObject);
var
  sDir : string;
begin
    sDir := BGEdit.Text;
    if BrowseForFolder('Select the folder where Ultima VII: The Black Gate is installed.', sDir, False ) then begin

      if VerifyBGDirectory ( sDir ) = 0 then begin
        if MsgBox ('Folder does not seem to contain a valid installation of Ultima VII: The Black Gate. Do you wish to continue?', mbConfirmation, MB_YESNO) = IDYES then begin
          BGEdit.Text := sDir;
        end
      end else
        BGEdit.Text := sDir;
    end;
end;

procedure OnSIBrowseButton(Sender: TObject);
var
  sDir : string;
begin
    sDir := SIEdit.Text;
    if BrowseForFolder('Select the folder where Ultima VII Part 2: Serpent Isle is installed.', sDir, False ) then begin

      if VerifySIDirectory ( sDir ) = 0 then begin
        if MsgBox ('Folder does not seem to contain a valid installation of Ultima VII Part 2: Serpent Isle. Do you wish to continue?', mbConfirmation, MB_YESNO) = IDYES then begin
          SIEdit.Text := sDir;
        end
      end else
        SIEdit.Text := sDir;
    end;
end;

//
// Create the Directory browsing page
//
procedure InitializeWizard;
begin

  DataDirPage := CreateCustomPage(wpSelectTasks,
    'Select Game Folders', 'Select the folders where Ultima VII and Ultima VII Part 2 are installed.');

  BGText := TNewStaticText.Create(DataDirPage);
  BGText.Caption := 'Please enter the path where Ultima VII: The Black Gate is installed.';
  BGText.AutoSize := True;
  BGText.Parent := DataDirPage.Surface;

  BGBrowseButton := TButton.Create(DataDirPage);
  BGBrowseButton.Top := BGText.Top + BGText.Height + ScaleY(8);
  BGBrowseButton.Left := DataDirPage.SurfaceWidth - ScaleX(75);
  BGBrowseButton.Width := ScaleX(75);
  BGBrowseButton.Height := ScaleY(23);
  BGBrowseButton.Caption := '&Browse';
  BGBrowseButton.OnClick := @OnBGBrowseButton;
  BGBrowseButton.Parent := DataDirPage.Surface;

  BGEdit := TEdit.Create(DataDirPage);
  BGEdit.Top := BGText.Top + BGText.Height + ScaleY(8);
  BGEdit.Width := DataDirPage.SurfaceWidth - (BGBrowseButton.Width + ScaleX(8));
  BGEdit.Text := '';
  BGEdit.Parent := DataDirPage.Surface;


  SIText := TNewStaticText.Create(DataDirPage);
  SIText.Caption := 'Please enter the path where Ultima VII Part 2: Serpent Isle is installed.';
  SIText.AutoSize := True;
  SIText.Top := BGEdit.Top + BGEdit.Height + ScaleY(23);
  SIText.Parent := DataDirPage.Surface;

  SIBrowseButton := TButton.Create(DataDirPage);
  SIBrowseButton.Top := SIText.Top + SIText.Height + ScaleY(8);
  SIBrowseButton.Left := DataDirPage.SurfaceWidth - ScaleX(75);
  SIBrowseButton.Width := ScaleX(75);
  SIBrowseButton.Height := ScaleY(23);
  SIBrowseButton.Caption := 'Brow&se';
  SIBrowseButton.OnClick := @OnSIBrowseButton;
  SIBrowseButton.Parent := DataDirPage.Surface;

  SIEdit := TEdit.Create(DataDirPage);
  SIEdit.Top := SIText.Top + SIText.Height + ScaleY(8);
  SIEdit.Width := DataDirPage.SurfaceWidth - (SIBrowseButton.Width + ScaleX(8));
  SIEdit.Text := '';
  SIEdit.Parent := DataDirPage.Surface;

  bSetPaths := False;
end;

//
// Read in the config file if needed
//
procedure CurPageChanged(CurPageID: Integer);
var
  sBGPath: AnsiString;
  sSIPath: AnsiString;
begin
  if CurPageID = DataDirPage.ID then begin
    if bSetPaths = False then begin
      setlength(sBGPath, 1024);
      setlength(sSIPath, 1024);
      GetExultGamePaths(ExpandConstant('{app}'), sBGPath, sSIPath, 1023 );

      BGEdit.Text := sBGPath;
      SIEdit.Text := sSIPath;
    end;
  end;

end;

//
// Make sure the SI and BG Paths are correct when we hit next button
//
function NextButtonClick(CurPageID: Integer): Boolean;
var
  iBGVerified: Integer;
  iSIVerified: Integer;
  sDir : string;
begin

  if CurPageID = DataDirPage.ID then begin

      sDir := BGEdit.Text;
      if Length(sDir) > 0 then begin iBGVerified := VerifyBGDirectory ( sDir );
      end else iBGVerified := 0;

      sDir := SIEdit.Text;
      if Length(sDir) > 0 then begin iSIVerified := VerifySIDirectory ( sDir );
      end else iSIVerified := 0;

      if (iBGVerified = 0) AND (iSIVerified = 0) then begin
        if MsgBox ('Warning: No valid game installations found. Do you wish to continue?', mbError, MB_YESNO or MB_DEFBUTTON2) = IDYES then begin
          Result := True;
        end else
          Result := False;
      end else if (iBGVerified = 0)  AND (iSIVerified = 1) then begin
        if MsgBox ('Warning: No valid installation of Ultima VII: The Black Gate. Do you wish to continue?', mbError, MB_YESNO or MB_DEFBUTTON2) = IDYES then begin
          Result := True;
        end else
          Result := False;
      end else if (iSIVerified = 0)  AND (iBGVerified = 1) then begin
        if MsgBox ('Warning: No valid installation of Ultima VII Part 2: Serpent Isle. Do you wish to continue?', mbError, MB_YESNO or MB_DEFBUTTON2) = IDYES then begin
          Result := True;
        end else
          Result := False;
      end else
        Result := True;
  end else
    Result := True;
end;

//
// Skip page because of components?
//
function ShouldSkipPage(PageID: Integer): Boolean;
var
  sBGPath: String;
  sSIPath: String;
begin
  if PageID = DataDirPage.ID then begin
    Result := (WizardIsComponentSelected('Paths') = False);

    if Result = True then begin
      if bSetPaths = False then begin
        setlength(sBGPath, 1024);
        setlength(sSIPath, 1024);
        GetExultGamePaths(ExpandConstant('{app}'), sBGPath, sSIPath, 1023 );

        BGEdit.Text := sBGPath;
        SIEdit.Text := sSIPath;
      end;

      if ( CompareStr(BGEdit.Text,'') = 0) and (CompareStr(SIEdit.Text,'') = 0) then
        Result := False;
    end

  end else if PageID = wpSelectProgramGroup then begin
    Result := (WizardIsComponentSelected('Icons') = False);
  end else
    Result := False;
end;

//
// Write out the Config file and Registry Entries
//
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    SetExultGamePaths(ExpandConstant('{app}'), BGEdit.Text, SIEdit.Text );
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'Software\Exult', 'Path', ExpandConstant('{app}'));
    if WizardIsComponentSelected('Icons') then
      RegWriteStringValue(HKEY_LOCAL_MACHINE, 'Software\Exult', 'ShellObjectFolder', ExpandConstant('{groupname}'));
  end
end;
