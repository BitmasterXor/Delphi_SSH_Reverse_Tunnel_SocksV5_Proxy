{*******************************************************************************
* Unit: Unit1
* Purpose: SSH Client implementation with SOCKS proxy capabilities
* Author: BitmasterXor
* Date: December 21, 2024
*******************************************************************************}
unit Unit1;

interface

{* Standard and component units *}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, ScSSHClient, ScSSHChannel, ScBridge, ScSSHServer,
  Vcl.Samples.Spin, Vcl.ExtCtrls, ScUtils, ScSSHUtils,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdSocksServer;

type
  {* Main form class definition *}
  TForm1 = class(TForm)
    Memo1: TMemo;
    sshclient: TScSSHClient;
    SSHCHANNEL: TScSSHChannel;     // SSH Channel for tunneling
    ScMemoryStorage1: TScMemoryStorage;   // Key storage component
    Button1: TButton;                     // Connection trigger
    IdSocksServer1: TIdSocksServer;      // SOCKS proxy server

    {* Event handlers *}
    procedure Button1Click(Sender: TObject);
    procedure sshclientServerKeyValidate(Sender: TObject;
      NewServerKey: TScKey; var Accept: Boolean);
    procedure SSHCHANNELConnect(Sender: TObject);
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
    {* Configure SSH client connection settings *}
    sshclient.HostName := 'PUBLIC IP ADDRESS OF YOUR SSH SERVER GOES HERE!!!!!!!!!!';
    sshclient.Port := 3434;
    sshclient.User := 'user';
    sshclient.Password := 'pass';
    sshclient.Connect;

    {* Configure SSH tunnel parameters *}
    SSHCHANNEL.GatewayPorts := True;
    SSHCHANNEL.Remote := True;     // Enable remote forwarding
    SSHCHANNEL.Dynamic := False;
    SSHCHANNEL.SourcePort := 5933;
    SSHCHANNEL.DestHost := '127.0.0.1';
    SSHCHANNEL.DestPort := 8888;   // Local proxy port
    SSHCHANNEL.Connect;
  except
    on E: Exception do
      Memo1.Lines.Add('Error: ' + E.Message);
  end;
end;

{* Event handler for SSH channel connection *}
procedure TForm1.SSHCHANNELConnect(Sender: TObject);
begin
  {* Initialize and activate SOCKS proxy server *}
  self.IdSocksServer1.DefaultPort := 8888;
  self.IdSocksServer1.Active := true;
  self.Memo1.Lines.Add('Connected to SSH Server!');
  self.Memo1.Lines.Add('Socks Server Started on SSH forwarded Port: ' + inttostr(self.IdSocksServer1.DefaultPort));
end;

{* Handles SSH server key validation *}
procedure TForm1.sshclientServerKeyValidate(Sender: TObject;
  NewServerKey: TScKey; var Accept: Boolean);
begin
  {* Auto-accept server certificate *}
  Accept := True;
end;

end.
