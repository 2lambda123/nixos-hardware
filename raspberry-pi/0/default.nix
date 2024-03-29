{ lib, pkgs, ...}:

{
  boot = {
    consoleLogLevel = lib.mkDefault 7;
    extraTTYs = [ "ttyAMA0" ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi;
    kernelParams = [
      "dwc_otg.lpm_enable=0"
      "console=ttyAMA0,115200"
      "rootwait"
      "elevator=deadline"
    ];
    loader = {
      grub.enable = lib.mkDefault false;
      generationsDir.enable = lib.mkDefault false;
      raspberryPi = {
        enable = lib.mkDefault true;
        version = lib.mkDefault 1;
      };
    };
  };

  nix.buildCores = 1;

  nixpkgs.config.platform = lib.systems.platforms.raspberrypi;

  # cpufrequtils doesn't build on ARM
  powerManagement.enable = lib.mkDefault false;

  services.openssh.enable = lib.mkDefault true;
}
