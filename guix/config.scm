(use-modules (gnu)
             (gnu system nss)
             (levy packages neovim)
             (levy packages fonts)
             (levy packages nheko)
             (levy packages purple)
             (levy packages emacs)
             (levy packages haskell)
             (levy packages purescript)
             (levy packages solvespace)
             (levy packages xorg)
             (levy packages mercury)
             (levy packages firmware)
             (levy packages linux)
             (levy packages mono)
             (levy packages ats)
             (levy packages python)
             (levy packages gimp)
             (levy packages godot)
             (levy packages olive)
             (bavier packages openspades)
             (gnu packages avr)
             (guix)
             (guix packages)
             (guix git-download)
             (guix gexp))

(use-service-modules networking ssh xorg desktop sddm xorg mcron
                     cups pm dns cuirass cgit dict audio)

(use-package-modules pdf vim linux certs curl llvm forth guile-xyz
                     assembly web-browsers version-control admin
                     idris haskell node gnome terminals xdisorg
                     fonts games rsync web libreoffice gdb man pv
                     databases readline compression mail aspell
                     dictionaries video gimp bittorrent gnuzilla
                     dico scheme graphviz commencement image-viewers
                     wine virtualization tor emacs emacs-xyz ocaml
                     erlang tex coq wm suckless gprolog pkg-config
                     gl haskell-apps game-development graphics xorg
                     inkscape android java audio disk kde text-editors
                     mpd chez python-xyz cmake compton chromium file
                     messaging perl irc kodi elixir gperf)

(define garbage-collector-job
  #~(job '(next-hour '(1)) (lambda () (guix-gc))))

(define %cuirass-specs
  #~(list
      ; TBD add build jobs for projects
      '()))

(define %atmel-udev-rule
  (udev-rule
    "99-avr.rules"
    (string-append
      ; Atmel Corp. AVRISP mkII
      "ATTRS{idVendor}==\"03eb\", ATTRS{idProduct}==\"2104\", MODE=\"660\", GROUP=\"dialout\""
      ; Atmel Corp.JTAG ICE mkII
      "ATTRS{idVendor}==\"03eb\", ATTRS{idProduct}==\"2103\", MODE=\"660\", GROUP=\"dialout\""
      ; Atmel Corp. Dragon
      "ATTRS{idVendor}==\"03eb\", ATTRS{idProduct}==\"2107\", MODE=\"660\", GROUP=\"dialout\"")))

(define-public laptop
  (operating-system
    (host-name "lucy")
    (timezone "Europe/Stockholm")
    (locale "en_US.utf8")

    (kernel linux-nonfree)
    (firmware (list iwlwifi-firmware-nonfree))
    (kernel-arguments
      (list "modprobe.blacklist=pcspkr,snd_pcsp"
            "modprobe.iwlwifi.11n_disable=1"
            "acpi_osi=\"!Windows 2012\""))

    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    (bootloader (bootloader-configuration
                  (bootloader grub-efi-bootloader)
                  (target "/boot/efi")
                  (keyboard-layout keyboard-layout)))

    (mapped-devices
     (list (mapped-device
             (source (uuid "0a398ecd-57a5-413e-bcd0-97af35c0c17e"))
             (target "root")
             (type luks-device-mapping))))

    (file-systems (append
                    (list (file-system
                            (device (file-system-label "root"))
                            (mount-point "/")
                            (type "ext4")
                            (dependencies mapped-devices))
                          (file-system
                            (device (uuid "3190-F7EA" 'fat))
                            (mount-point "/boot/efi")
                            (type "vfat")))
                    %base-file-systems))

    (users (cons (user-account
                   (name "lucy")
                   (comment "levy")
                   (group "users")
                   (supplementary-groups '("wheel" "netdev"
                                           "audio" "video"
                                           "dialout")))
                 %base-user-accounts))

    (sudoers-file
      (plain-file "sudoers" "\
root ALL=(ALL) ALL
%wheel ALL=(ALL) ALL
Defaults 	insults\n"))

    (packages (cons* ;; NEOVIM
                     neovim neovim-limelight neovim-idris neovim-tabular
                     neovim-asyncrun neovim-lastplace neovim-supertab
                     neovim-nerdtree neovim-syntastic neovim-rainbow
                     neovim-gdscript3 neovim-purescript neovim-psc-ide

                     ;; EMACS
                     emacs-xwidgets emacs-slack emacs-guix emacs-geiser
                     emacs-neotree emacs-multiple-cursors
                     emacs-matrix-client emacs-irony-mode emacs-haskell-mode
                     emacs-which-key emacs-tuareg emacs-flycheck emacs-erlang
                     emacs-doom-themes emacs-ats2 emacs-pdf-tools
                     emacs-paredit emacs-hackernews emacs-ws-butler emacs-undo-tree
                     emacs-typo emacs-rainbow-blocks emacs-org emacs-org-bullets
                     emacs-idle-highlight emacs-graphviz-dot-mode
                     emacs-god-mode emacs-git-gutter emacs-darkroom proof-general
                     emacs-racket-mode emacs-all-the-icons emacs-exwm
                     emacs-solaire-mode emacs-org-contrib

                     ;; FONT
                     font-fira-code font-dotsies font-hack font-ibm-plex
                     font-lato font-liberation font-google-noto font-google-roboto
                     font-linuxlibertine font-mononoki font-ubuntu font-dejavu
                     font-comic-neue font-inconsolata font-euclid-initials font-dotsies

                     ;; COMMS
                     claws-mail ; nheko-reborn
                     matrix-purple
                     slack-purple
                     telegram-purple
                     weechat

                     ;; UTIL
                     acpi pv recutils rlwrap tree unzip zip alsa-utils fdupes
                     scrot xclip graphviz sxiv bspwm sxhkd dmenu adb xmodmap setxkbmap
                     bgs asciinema dosfstools compton feh file ghc-tldr

                     ;; GRAPHICS
                     inkscape ; solvespace blender-2.79
                     gimp gimp-normalmap krita

                     ;; AUDIO
                     ardour mpd-mpc mpd supercollider

                     ;; NET
                     curl links git rsync aria2
                     ungoogled-chromium surf
                     darkhttpd elixir
                     iproute tcpdump

                     ;; GAME
                     gnugo thefuck minetest 0ad ; openspades
                     ; wesnoth

                     ;; DEV
                     ; godot-3.1.1 (list icedtea "jdk")

                     ;; VIDEO
                     mpv ffmpeg youtube-viewer xrandr olive kodi

                     ;; TEXT
                     aspell aspell-dict-en aspell-dict-sv diction
                     fbida zathura zathura-ps zathura-djvu zathura-pdf-mupdf
                     libreoffice texmacs

                     ;; LANG
                     ats2 racket ocaml ocaml-earley ocaml-parsexp
                     clang gforth fasm node avr-toolchain-5 gcc-toolchain coq chez-scheme
                     gprolog ; mercury-rotd
                     texlive erlang idris
                     ; purescript
                     ; purescript-native
                     ; mono-6.0.0.319
                     perl

                     ;; MISC
                     nss-certs le-certs
                     gnu-make gdb man-pages
                     kitty sicp wine wine64 qemu
                     dune python-glad
                     scons
                     linux-libre-headers
                     cmake
                     ; psc-package
                     ocaml-merlin glfw gperf pkg-config glu

                     %base-packages))

    (services (cons* (service wpa-supplicant-service-type)
                     (service network-manager-service-type
                              (network-manager-configuration
                                (dns "none")))
                     (service slim-service-type)
                     (service cups-service-type)
                     (service tor-service-type)
                     (service dnsmasq-service-type
                              (dnsmasq-configuration
                                (no-resolv? #t)
                                (servers '("217.27.188.3"
                                           "9.9.9.9"
                                           "149.112.112.112"
                                           "208.67.222.222"
                                           "208.67.220.220"
                                           "198.101.242.72"
                                           "23.253.163.53"))))
                     (service tlp-service-type
                              (tlp-configuration
                                (tlp-default-mode "BAT")))

                     (service mcron-service-type
                              (mcron-configuration
                                (jobs (list garbage-collector-job))))

                     (service cuirass-service-type
                              (cuirass-configuration
                                (specifications %cuirass-specs)
                                (use-substitutes? #t)))

                     (service mpd-service-type
                              (mpd-configuration
                                (user "lucy")
                                (music-dir "~/media/music")
                                (address "/home/lucy/.mpd/socket")))

                     (service cgit-service-type
                              (cgit-configuration
                                (enable-commit-graph? #t)
                                (enable-html-serving? #t)
                                (repository-directory "/home/lucy/projects/")
                                (nocache? #t)
                                (readme "nothing to see here")))

                     (service openssh-service-type
                              (openssh-configuration
                                (port-number 2222)))

                     (extra-special-file
                      "/usr/bin/env"
                      (file-append coreutils "/bin/env"))

                     (extra-special-file
                      "/etc/resolv.conf"
                      (plain-file "" "nameserver 127.0.0.1"))

                     (modify-services %base-services
                      (guix-service-type config =>
                        (guix-configuration (inherit config)
                          (substitute-urls '("http://ci.guix.gnu.org"
                                             "https://bayfront.guixsd.org"
                                             "https://berlin.guixsd.org"))))
                      (udev-service-type config =>
                        (udev-configuration (inherit config)
                          (rules (append (udev-configuration-rules config)
                                         (list %atmel-udev-rule))))))))

    (name-service-switch %mdns-host-lookup-nss)))

laptop

; vim: et
