I'll update the README with specific information about SecureBridge dependencies. Here's the revised version:

# 🔒 Delphi SSH Reverse Tunnel with SOCKS5 Proxy

This Delphi VCL application implements a complete SSH tunneling solution with integrated SOCKS5 proxy capabilities. The project includes both server and client components, enabling secure remote access through NAT using SSH reverse tunneling technology. The implementation features automatic connection handling, real-time monitoring, and built-in SOCKS5 proxy functionality.

<p align="center">
  <img src="preview.png" alt="Screenshot of SSH Tunnel Manager" style="max-width:100%; height:auto;">
</p>

## 🛠️ Features
- 🔐 **Complete SSH Implementation:**
  - Server component with RSA 2048-bit encryption
  - Client with automatic connection handling
  - Integrated SOCKS5 proxy server
- 🌐 **Advanced Tunneling:**
  - Reverse SSH tunnel support
  - Local and remote port forwarding
  - Dynamic SOCKS proxy routing
- 📊 **Monitoring & Control:**
  - Real-time connection logging
  - IP tracking and port monitoring
  - Automatic server key validation

## 📦 Dependencies
- **SecureBridge Components** (Required)
  - Professional SSH/SFTP/SSL components for Delphi
  - Available from: [DevArt SecureBridge](https://www.devart.com/sbridge/)
  - Components needed:
    - `TScSSHClient`
    - `TScSSHServer`
    - `TScSSHChannel`
    - `TScMemoryStorage`
- **Indy Components** (Required)
  - Used for SOCKS5 server implementation
  - Component needed:
    - `TIdSocksServer`

## 🔧 Installation
1. 📥 **Install Dependencies:**
   - Purchase and install SecureBridge from DevArt
   - Install Indy Components (included with Delphi)
2. 🖥️ **Project Setup:**
   - Clone the repository
   - Open both client and server `.dpr` files in Delphi
   - Ensure SecureBridge and Indy components are in your library path
   - Compile both projects

## ⚙️ Usage
1. 🚀 **Server Setup:**
   - Launch the server component
   - Default port: 3434
   - Default credentials: user/pass
2. 🔄 **Client Connection:**
   - Configure target server IP
   - Set local SOCKS port (default: 8888)
   - Click connect to establish tunnel
3. 🌐 **SOCKS Proxy:**
   - Configure applications to use localhost:8888 as SOCKS5 proxy
   - Traffic will be routed through the SSH tunnel

**Note:** This tool is intended for educational purposes and legitimate network administration. Use responsibly and in accordance with applicable laws and regulations.

## 🔒 Technical Implementation
- 💻 SecureBridge SSH components for secure communication
- 🔑 RSA 2048-bit key generation
- 📝 Indy SOCKS5 server integration
- 🛡️ Automatic connection recovery
- 🧹 Clean resource management

## 🤝 Contributing
Feel free to fork, improve, and submit pull requests. All contributions are welcome!

## 📜 License
This project is provided "as is" without warranty. Use at your own risk.

## 📧 Contact
Discord: bitmasterxor

<p align="center">Made with ❤️ by: BitmasterXor, using Delphi RAD Studio</p>
