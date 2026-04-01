{...}: {
  # for keychron launcher access to keyboard
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="1260", MODE="0660", GROUP="users" TAG+="uaccess", TAG+="udev-acl"
  '';
}
