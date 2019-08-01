(use-modules (gnu)
             (gnu system nss)
             (levy packages neovim)
             (levy packages fonts)
             (levy packages nheko)
             (levy packages emacs)
             (levy packages haskell)
             (levy packages solvespace)
             (levy packages xorg)
             (levy packages mercury)
             (levy packages ats)
             (levy packages gimp)
             (bavier packages openspades)
             (gnu packages avr)
             (guix)
             (guix packages)
             (guix git-download)
             (guix gexp))

(use-service-modules networking ssh xorg desktop sddm xorg mcron
                     cups pm dns cuirass cgit dict)

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
                     inkscape android)

(define garbage-collector-job
  #~(job '(next-hour '(1))
         (lambda ()
           (guix-gc))))

(define godot-3.1
  (package
    (inherit godot)
    (name "godot-3.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://github.com/godotengine/godot")
                     (commit "320f49f204cfbf9b480fe62aaa7718afb74920a5")))
              (sha256
                (base32
                  "1z37znqzbn0x8s04pb9dxzni9jzl8m59nfrr14vypww42f9l5i7i"))))))

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

                     ;; EMACS
                     emacs-xwidgets emacs-slack emacs-guix emacs-geiser
                     emacs-neotree emacs-multiple-cursors
                     emacs-matrix-client emacs-irony-mode emacs-haskell-mode
                     emacs-google-maps emacs-google-translate emacs-arduino-mode
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
                     font-comic-neue font-inconsolata

                     ;; UTIL
                     acpi pv recutils rlwrap tree unzip zip alsa-utils htop fdupes
                     scrot xclip graphviz sxiv bspwm sxhkd dmenu adb xmodmap setxkbmap
                     bgs asciinema

                     ;; GRAPHICS
                     inkscape solvespace blender-2.79
                     gimp gimp-normalmap

                     ;; NET
                     curl links git tcpdump rsync aria2 icecat qutebrowser
                     darkhttpd
                     iproute

                     ;; GAME
                     gnugo thefuck ; openspades
                     wesnoth

                     claws-mail ; nheko-reborn

                     ;; DEV
                     godot-3.1

                     ;; VIDEO
                     mpv ffmpeg youtube-viewer xrandr

                     ;; TEXT
                     aspell aspell-dict-en aspell-dict-sv diction
                     fbida zathura zathura-ps zathura-djvu zathura-pdf-mupdf
                     ; libreoffice

                     ;; LANG
                     ats2
                     clang gforth fasm node avr-toolchain-5 gcc-toolchain coq ; idris
                     ghc ghc-opengl ghc-sdl2 ghc-pandoc ; ghc-godot
                     gprolog ; mercury-rotd

                     ;; MISC
                     nss-certs le-certs
                     gnu-make gdb man-pages
                     kitty sicp wine wine64 qemu

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
                                (servers '("9.9.9.9"
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
                      (udev-service-type config =>
                        (udev-configuration (inherit config)
                        (rules (append (udev-configuration-rules config)
                                       (list %atmel-udev-rule))))))))

    (name-service-switch %mdns-host-lookup-nss)))

laptop

; vim: et
