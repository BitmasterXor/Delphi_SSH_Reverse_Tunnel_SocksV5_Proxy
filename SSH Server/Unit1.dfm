object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SSH Server Control Panel'
  ClientHeight = 400
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Icon.Data = {
    000001000200101000000100200068040000260000002020000001002000A810
    00008E0400002800000010000000200000000100200000000000300400000000
    0000000000000000000000000000000000000000000000000000AB96868BB4A3
    94A4B4A394A4B4A394A4B4A394A4B4A394A4B4A394A4B4A394A4B4A394A4AB96
    868B000000000000000000000000000000000000000000000000BEAFA0C3F2EB
    E1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFBEAF
    A0C3000000000000000000000000000000000000000000000000BEAFA0C3F2EB
    E1FFF2EBE1FFF2EBE1FFEEE3D7FFEEE3D7FFF2EBE1FFF2EBE1FFF2EBE1FFBEAF
    A0C3000000000000000000000000000000000000000000000000BEAFA0C3F2EB
    E1FFF2EBE1FFEDE3D5FFD5A079FFD5A17AFFEDE2D6FFF2EBE1FFF2EBE1FFBEAF
    A0C3000000000000000000000000E0070000E0070000E0070000E0070000E007
    0000E0070000E0070000E0070000E0070000E0070000E0070000E0070000E007
    0000E0070000E0070000E0070000280000002000000040000000010020000000
    0000801000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000988472AAAB9988EFB1A191EBB1A191EBB1A1
    91EBB1A191EBB1A191EBB1A191EBB1A191EBB1A191EBB1A191EBB1A191EBB1A1
    91EBB1A191EBB1A191EBB1A191EBB1A191EBB1A191EBAB9988EF988472AA0000}
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  DesignSize = (
    500
    400)
  TextHeight = 15
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 484
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 361
    Width = 484
    Height = 31
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Connect SSH Client'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object ScSSHServer1: TScSSHServer
    Storage = ScMemoryStorage1
    AfterClientConnect = ScSSHServer1AfterClientConnect
    AfterShellDisconnect = ScSSHServer1AfterShellDisconnect
    OnRemotePortForwardingRequest = ScSSHServer1RemotePortForwardingRequest
    Left = 32
    Top = 24
  end
  object ScMemoryStorage1: TScMemoryStorage
    Left = 128
    Top = 24
  end
  object ScSSHClient1: TScSSHClient
    KeyStorage = ScMemoryStorage1
    OnServerKeyValidate = ScSSHClient1ServerKeyValidate
    Left = 232
    Top = 24
  end
  object ScSSHChannel1: TScSSHChannel
    Client = ScSSHClient1
    Left = 320
    Top = 24
  end
end
