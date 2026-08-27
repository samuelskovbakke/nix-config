{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Mail
      "x-scheme-handler/mailto" = ["thunderbird.desktop"];

      # Images
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];

      # Video / audio
      "video/mp4" = ["vlc.desktop"];
      "video/x-matroska" = ["vlc.desktop"];
      "audio/mpeg" = ["vlc.desktop"];
      "audio/flac" = ["vlc.desktop"];

      # Archives
      "application/zip" = ["xarchiver.desktop"];
      "application/x-7z-compressed" = ["xarchiver.desktop"];
      "application/x-tar" = ["xarchiver.desktop"];

      # PDFs: no dedicated reader in your packages, defaulting to Zen.
      "application/pdf" = ["zen-beta.desktop"];
      "text/html" = ["zen-beta.desktop"];
      "x-scheme-handler/http" = ["zen-beta.desktop"];
      "x-scheme-handler/https" = ["zen-beta.desktop"];

      # Directories
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
    };
  };
}
