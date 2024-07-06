{ config, pkgs, ... } :
{
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.wireguard.interfaces = {
    home = {
      ips = [ "10.14.47.2/24" ];
      listenPort = 51820;
      privateKeyFile = "/etc/wireguard/home-private.key";
      peers = [
        {
	  presharedKeyFile = "/etc/wireguard/home-preshared.key";
	  publicKey = "xecStJ04Clg2icSEt1idIlprnsqMAz9QCNbP5QjMLD0=";
	  allowedIPs = [ "192.168.123.0/24" ];
	  endpoint = "128.0.135.132:51820";
	  persistentKeepalive = 30;
	}
      ];
    };
  };
}
