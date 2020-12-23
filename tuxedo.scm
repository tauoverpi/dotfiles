;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (nongnu packages steam-client)
             (nongnu packages mozilla)
             (tau packages vim)
             (tau packages fonts)
             (tau packages zig)
             (guix packages)
             (guix utils)
             (nongnu packages linux))

(use-service-modules
  desktop networking ssh xorg virtualization dns audio)

(use-package-modules
  vim tmux suckless version-control terminals figlet web linux
  admin chromium web-browsers bittorrent haskell python gimp
  inkscape kde graphics xdisorg image-viewers compton file
  compression pv shellutils mpd video audio speech rsync
  networking curl gdb valgrind diffoscope spice xorg
  virtualization python-xyz package-management pdf
  ocr haskell-xyz libreoffice man gcc tex fonts
  graphviz javascript games)

(define shell-packages
  (list tmux
        asciinema
        figlet
        jq
        xxd
        acpi lm-sensors
        tree file
        unzip zip
        pv
        git
        fzy))

(define media-packages
  (list mpd-mpc mpd
        mpv ffmpeg
        cava
        alsa-utils
        flite
        sox))

(define net-packages
  (list stunnel
        net-tools
        tcpdump
        sshfs
        rsync
        wireshark
        nmap
        socat netcat-openbsd))

(define font-packages
  (list font-jetbrains-mono font-scientifica
        font-google-noto font-victor-mono font-mononoki font-awesome
        font-comic-neue font-dejavu font-hack font-liberation
        font-linuxlibertine font-lato font-mathjax font-ubuntu font-hermit
        font-wqy-microhei font-cns11643 font-wqy-zenhei))

(define editor-packages
  (list neovim neovim-gitgutter neovim-tabular neovim-limelight
        neovim-lastplace neovim-ale neovim-rainbow neovim-elm
        neovim-deoplete neovim-pandoc-syntax neovim-clang-format
        neovim-zig))

(define game-packages
  (list steam
        0ad
        xonotic
        minetest
        btanks
        supertuxkart
        bsd-games
        chess gnugo
        red-eclipse))

(define web-packages
  (list ungoogled-chromium
        firefox
        qutebrowser
        aria2 curl
        youtube-dl
        lynx))

(define debugging-packages
  (list gdb
        valgrind
        diffoscope
        strace))

(define language-packages
  (list zig-0.7.1-master
        wabt))

(define desktop-packages
  (list kitty
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
                        (("005577") "000000"))
                      #t)))))))
        dmenu
        redshift
        scrot
        feh
        spice-gtk
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
        krita
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
                    '("wheel" "netdev" "audio" "video" "kvm")))
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
      (service slim-service-type)

      (service network-manager-service-type
               (network-manager-configuration
                 (dns "none")))

      (service wpa-supplicant-service-type)

      (service mpd-service-type
               (mpd-configuration
                 (user "tau")
                 (port "6600")
                 (music-dir "~/music")
                 (outputs
                   (list (mpd-output
                           (name "pulse")
                           (type "pulse")
                           (mixer-type 'hardware))

                         (mpd-output
                           (name "stream")
                           (type "httpd")
                           (mixer-type 'null)
                           (extra-options
                             `((encoder . "vorbis")
                               (port . "8080"))))))))

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

      (extra-special-file "/etc/resolv.conf"
        (plain-file "resolv.conf" "nameserver 127.0.0.1"))

      (extra-special-file "/usr/bin/env"
        (file-append coreutils "/bin/env"))

      %base-services))

  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
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
