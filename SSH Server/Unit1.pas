{*******************************************************************************
* Unit: Unit1
* Purpose: Implements an SSH server and client with port forwarding capabilities
* Author: BitmasterXor
* Date: December 21, 2024
*******************************************************************************}
unit Unit1;

interface

{* Standard Delphi and Windows API units *}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, ScSSHClient, ScSSHChannel, ScBridge, ScSSHServer,
  Vcl.Samples.Spin, Vcl.ExtCtrls, ScUtils, ScSSHUtils;

type
  {* Main form class definition *}
  TForm1 = class(TForm)
    Memo1: TMemo;                   // Log display component
    ScSSHServer1: TScSSHServer;     // SSH Server component
    ScMemoryStorage1: TScMemoryStorage; // Storage for keys and users
    ScSSHClient1: TScSSHClient;     // SSH Client component
    ScSSHChannel1: TScSSHChannel;   // SSH Channel for port forwarding
    Button1: TButton;               // Connection trigger button

    {* Event handlers *}
    procedure FormCreate(Sender: TObject);
    procedure ScSSHServer1AfterClientConnect(Sender: TObject;
      ClientInfo: TScSSHClientInfo);
    procedure ScSSHServer1AfterShellDisconnect(Sender: TObject;
      ClientInfo: TScSSHClientInfo);
    procedure ScSSHServer1RemotePortForwardingRequest(Sender: TObject;
      ClientInfo: TScSSHClientInfo; const Host: string; const Port: Integer;
      var Allow: Boolean);
    procedure ScSSHClient1ServerKeyValidate(Sender: TObject;
      NewServerKey: TScKey; var Accept: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{* Handles the connection button click event *}
procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    {* Configure SSH client connection *}
    ScSSHClient1.HostName := '127.0.0.1';
    ScSSHClient1.Port := 3434;
    ScSSHClient1.User := 'user';
    ScSSHClient1.Password := 'pass';

    {* Configure port forwarding settings *}
    ScSSHChannel1.GatewayPorts := true;
    ScSSHChannel1.Remote := False; //Used to reverse the connection from server to our CLIENT... (Asks for port forwarding...)
    ScSSHChannel1.Dynamic := False; //Used for Socks Connections its a port that listens dynamically on your system to forward data to and from the server...
    ScSSHChannel1.Direct := true;// Direct tunnel takes from one port 5933 >>> ?????
    ScSSHChannel1.SourcePort := 5933;
    ScSSHChannel1.DestHost := '127.0.0.1';
    ScSSHChannel1.DestPort := 5933;
    ScSSHChannel1.Connect;
  except
    on E: Exception do
    begin
      {* Errors are suppressed in this implementation *}
    end;
  end;
end;

{* Form creation initialization *}
procedure TForm1.FormCreate(Sender: TObject);
var
  Key: TScKey;
  NewKeyname: string;
  User: TScUser;
begin
  {* Generate SSH server key *}
  NewKeyname := 'key1';
  Key := TScKey.Create(ScMemoryStorage1.Keys);
  Key.KeyName := NewKeyname;
  Key.Generate(aaRSA, 2048);

  {* Create default user credentials *}
  User := TScUser.Create(ScMemoryStorage1.Users);
  User.UserName := 'user';
  User.Password := 'pass';
  User.Authentications := [uaPassword];

  {* Configure and activate SSH server *}
  with ScSSHServer1 do
  begin
    Port := 3434;
    KeyNameRSA := NewKeyname;
    Active := true;
  end;

  {* Log server activation *}
  self.Memo1.Lines.Add('SSH Server Active On port: ' +
    inttostr(self.ScSSHServer1.Port));
end;

{* Auto-accepts any server key for client connections *}
procedure TForm1.ScSSHClient1ServerKeyValidate(Sender: TObject;
  NewServerKey: TScKey; var Accept: Boolean);
begin
  Accept := true;
end;

{* Logs client connection events *}
procedure TForm1.ScSSHServer1AfterClientConnect(Sender: TObject;
  ClientInfo: TScSSHClientInfo);
begin
  self.Memo1.Lines.Add('Client Connected From IP: ' +
    ClientInfo.TCPConnection.GetRemoteIP);
end;

{* Logs client disconnection events *}
procedure TForm1.ScSSHServer1AfterShellDisconnect(Sender: TObject;
  ClientInfo: TScSSHClientInfo);
begin
  self.Memo1.Lines.Add('Client Disconnected From IP: ' +
    ClientInfo.TCPConnection.GetRemoteIP);
end;

{* Handles port forwarding requests *}
procedure TForm1.ScSSHServer1RemotePortForwardingRequest(Sender: TObject;
  ClientInfo: TScSSHClientInfo; const Host: string; const Port: Integer;
  var Allow: Boolean);
begin
  Allow := true;
  self.Memo1.Lines.Add('Client: ' + ClientInfo.TCPConnection.GetRemoteIP +
    ' Requesting Port Forward on port: ' + inttostr(Port));
    self.Button1.Enabled:=true;
end;

end.
