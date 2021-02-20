;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (nongnu packages mozilla)
             (tau packages vim)
             (tau packages solvespace)
             (tau packages fonts)
             (tau packages zig)
             (guix packages)
             (guix utils)
             (nongnu packages linux))

(use-service-modules
  desktop networking ssh xorg virtualization dns audio sound
  dbus pm mcron vpn)

(use-package-modules
  vim tmux suckless version-control terminals figlet web linux
  admin chromium web-browsers bittorrent haskell python gimp
  inkscape kde graphics xdisorg image-viewers compton file
  compression pv shellutils mpd video audio speech rsync wine
  networking curl gdb valgrind diffoscope spice xorg mail
  virtualization python-xyz package-management pdf tor w3m
  ocr haskell-xyz libreoffice man gcc tex fonts fontutils
  graphviz javascript games wm engineering elm text-editors
  telegram pkg-config sdl)

(define garbage-collector-job #~(job "5 8 * * *" "guix gc -F 10G"))

(define shell-packages
  (list tmux
        asciinema
        zpaq
        htop
        pkg-config
        figlet
        perf
        jq
        xxd
        acpi lm-sensors
        tree file
        unzip zip
        pv
        picocom
        git
        fzy))

(define media-packages
  (list mpv ffmpeg
        cava
        sdl2 sdl-image
        alsa-utils
        flite
        sox))

(define net-packages
  (list stunnel
        net-tools
        tcpdump
        torsocks
        sshfs
        rsync
        iftop
        neomutt
        wireshark
        nmap
        socat netcat-openbsd))

(define font-packages
  (list fontconfig font-jetbrains-mono font-scientifica
        font-google-noto font-victor-mono font-mononoki font-awesome
        font-comic-neue font-hack font-liberation font-ibm-plex
        font-linuxlibertine font-lato font-mathjax font-ubuntu font-hermit
        font-wqy-microhei font-cns11643 font-wqy-zenhei))

(define editor-packages
  (list neovim neovim-gitgutter neovim-tabular neovim-limelight
        neovim-lastplace neovim-ale neovim-rainbow neovim-elm
        neovim-deoplete neovim-pandoc-syntax neovim-clang-format
        neovim-zig))

(define game-packages
  (list bsd-games
        chess gnugo))

(define web-packages
  (list ungoogled-chromium
        ;firefox
        qutebrowser
        aria2 curl
        w3m
        youtube-dl
        links))

(define debugging-packages
  (list gdb
        valgrind
        diffoscope
        strace))

(define language-packages
  (list zig-0.8-dev
        elm-compiler
        wabt))

(define desktop-packages
  (list kitty
        telegram-cli
        telegram-desktop
        (package
          (inherit sent)
          (arguments
            (substitute-keyword-arguments (package-arguments sent)
              ((#:phases phases)
               `(modify-phases ,phases
                  (add-before 'build 'theme
                    (lambda _
                      (substitute* "config.def.h"
                        (("000000") "ffffff")
                        (("FFFFFF") "1d2021"))
                      #t)))))))
        (package
          (inherit dwm)
          (arguments
            (substitute-keyword-arguments (package-arguments dwm)
              ((#:phases phases)
               `(modify-phases ,phases
                  (add-before 'build 'theme
                    (lambda _
                      (substitute* "config.def.h"
                        (("MODKEY Mod1Mask") "MODKEY Mod4Mask")
                        (("const int showbar.*") "const int showbar = 0;")
                        (("st\", NULL") "kitty\", NULL")
                        (("005577") "000000"))
                      #t)))))))
        dmenu
        redshift
        i3lock-color
        scrot
        wine64
        feh
        spice-gtk
        ntfs-3g
        solvespace
        openscad
        qemu
        compton
        jupyter guix-jupyter gwl
        xinput xprop xkill xdotool xrandr
        xclip))

(define document-packages
  (list zathura zathura-pdf-poppler zathura-ps zathura-djvu
        poppler
        tesseract-ocr
        ghc-pandoc ghc-pandoc-citeproc ; ghc-pandoc-crossref
        libreoffice
        man-pages gnu-c-manual
        texlive
        graphviz))

(define graphics-packages
  (list gimp
        inkscape
        ;krita
        blender))

(define special-packages
  (list (specification->package "nss-certs")))

(operating-system
  (kernel (@@ (nongnu packages linux) linux))
  (firmware (list amdgpu-firmware iwlwifi-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/Stockholm")
  (keyboard-layout
    (keyboard-layout "us" "altgr-intl"))
  (host-name "tuxedo")
  (users (cons* (user-account
                  (name "tau")
                  (comment "Tau")
                  (group "users")
                  (home-directory "/home/tau")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video" "kvm" "dialout" "disk")))
                %base-user-accounts))

  (packages
    (append
      debugging-packages
      desktop-packages
      document-packages
      editor-packages
      game-packages
      graphics-packages
      language-packages
      font-packages
      media-packages
      net-packages
      shell-packages
      special-packages
      web-packages
      %base-packages))

  (services
    (cons*
      (service openssh-service-type)
      (service tor-service-type)
      (service slim-service-type
               (slim-configuration
                 ;(theme-name "theme")
                 ;(theme (local-file "artwork/slim" "themes" #:recursive? #t))
                 (default-user "tau")))

      (service network-manager-service-type
               (network-manager-configuration
                 (dns "none")))

      (service wpa-supplicant-service-type)

      (service qemu-binfmt-service-type
               (qemu-binfmt-configuration
                 (platforms (lookup-qemu-platforms "aarch64" "arm"))
                 (guix-support? #t)))

      (service dnsmasq-service-type
               (dnsmasq-configuration
                 (no-resolv? #t)
                 (servers
                   (list "217.27.188.3"
                         "9.9.9.9"
                         "149.112.112.112"
                         "208.67.222.222"
                         "208.67.220.220"
                         "198.101.242.72"
                         "23.253.163.53"))))

      (screen-locker-service slock)
      (service upower-service-type)
      (service ntp-service-type)
      (service thermald-service-type)
      (service pulseaudio-service-type)
      (service bluetooth-service-type
               (bluetooth-configuration
                 (auto-enable? #t)))
      (service alsa-service-type)
      (dbus-service)

      (simple-service 'crontab
                      mcron-service-type
                      (list garbage-collector-job))

      (service special-files-service-type
               `(("/etc/resolv.conf" ,(plain-file "resolv.conf" "nameserver 127.0.0.1"))
                 ("/usr/bin/env" ,(file-append coreutils "/bin/env"))
                 ("/usr/bin/file" ,(file-append file "/bin/file"))))

      %base-services))

  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (theme
        (grub-theme
          (inherit (grub-theme))
          (image (local-file "artwork/gnu-gold.png"))))
      (keyboard-layout keyboard-layout)))

  (mapped-devices
    (list (mapped-device
            (source
              (uuid "2170b4c7-62b9-416f-8789-6c108f6b5ea0"))
            (target "cryptroot")
            (type luks-device-mapping))))

  (file-systems
    (cons* (file-system
             (mount-point "/boot/efi")
             (device (uuid "FAC0-D620" 'fat32))
             (type "vfat"))
           (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4")
             (dependencies mapped-devices))
           %base-file-systems)))
