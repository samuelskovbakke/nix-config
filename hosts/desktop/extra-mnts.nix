{
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/b591ca6c-8b4a-4fa1-bee9-319723601a68";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
      "nofail"
    ];
  };
}
