{
  config,
  pkgs,
  ...
}: {
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
}
