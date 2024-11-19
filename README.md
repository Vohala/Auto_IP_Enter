# Auto_IP_Enter

This repository contains two Windows batch scripts designed to automate network configuration tasks:

    set_static_network.bat: Configures your network adapter with static IP addresses, gateways, and DNS servers.
    set_dhcp_network.bat: Sets your network adapter to obtain IP addresses and DNS servers automatically via DHCP.

Things You Need to Edit

Before running these scripts, you need to customize certain settings to match your network environment.
1. Interface Name

Both scripts use the variable interfaceName to specify which network adapter to configure. By default, it's set to "Wi-Fi".

Action Required:

    Find Your Adapter's Name:
        Open Command Prompt and run:

    netsh interface ipv4 show interfaces

    Note the exact name of your network adapter (e.g., "Ethernet", "Wi-Fi", "Wireless Network Connection").

Edit the Scripts:

    Open each .bat file in a text editor.
    Locate the following line:

        set interfaceName="Wi-Fi"

        Replace "Wi-Fi" with your adapter's name, keeping the quotation marks.

Example:

set interfaceName="Ethernet"

2. Network Settings (Only in set_static_network.bat)

In set_static_network.bat, predefined network settings are applied. You need to adjust these to fit your specific network configuration.

Parameters to Edit:

    Primary IP Address, Subnet Mask, and Default Gateway:

netsh interface ipv4 set address name=%interfaceName% static <IP_Address> <Subnet_Mask> <Default_Gateway> 1

    Replace <IP_Address>, <Subnet_Mask>, and <Default_Gateway> with your desired values.

DNS Servers:

netsh interface ipv4 set dns name=%interfaceName% static <Primary_DNS> primary
netsh interface ipv4 add dns name=%interfaceName% addr=<Secondary_DNS> index=2

    Replace <Primary_DNS> and <Secondary_DNS> with your DNS server addresses.

Additional IP Address and Subnet Mask:

netsh interface ipv4 add address name=%interfaceName% addr=<Additional_IP> mask=<Subnet_Mask>

    Replace <Additional_IP> and <Subnet_Mask> as needed.

Additional Gateway:

    route -p add 0.0.0.0 mask 0.0.0.0 <Additional_Gateway> metric 2 if %interfaceIndex%

        Replace <Additional_Gateway> with the gateway for the additional IP.

Example:

netsh interface ipv4 set address name=%interfaceName% static 192.168.1.100 255.255.255.0 192.168.1.1 1
netsh interface ipv4 set dns name=%interfaceName% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%interfaceName% addr=8.8.4.4 index=2
netsh interface ipv4 add address name=%interfaceName% addr=10.0.0.5 mask=255.255.255.0
route -p add 0.0.0.0 mask 0.0.0.0 10.0.0.1 metric 2 if %interfaceIndex%

Steps to Use the Scripts

    Edit the Scripts:
        Open each .bat file with a text editor like Notepad.
        Modify the interfaceName and network settings as described above.
        Save your changes.

    Run the Scripts:
        Double-click the script you wish to execute.
        The script will automatically request administrative privileges. When prompted by the User Account Control (UAC), click "Yes".

    Confirm Changes:
        Follow any on-screen messages.
        The script will display a confirmation message upon successful completion.

Important Notes

    Backup Current Settings:
        Before making changes, it's advisable to note down your current network settings in case you need to revert.

    Administrative Rights:
        These scripts require administrative privileges to run successfully.

    Test the Scripts:
        If possible, test the scripts in a safe environment to ensure they work as expected with your settings.

Summary

    Edit the interfaceName in both scripts to match your network adapter's name.
    In set_static_network.bat, update the IP addresses, subnet masks, gateways, and DNS servers to match your network configuration.
    Run the scripts, granting administrative privileges when prompted.
