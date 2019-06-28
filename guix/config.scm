(use-modules (gnu)
             (gnu system nss)
             (levy packages neovim)
             (levy packages fonts)
             (levy packages nheko)
             (guix)
             (guix gexp))
(use-service-modules networking ssh xorg desktop sddm xorg mcron
                     cups pm dns cuirass cgit dict)
(use-package-modules pdf vim linux certs curl llvm forth guile-xyz
                     assembly web-browsers version-control admin
                     idris haskell node gnome terminals xdisorg
                     fonts games rsync web libreoffice gdb man pv
                     databases readline compression mail aspell
                     dictionaries video gimp bittorrent gnuzilla
                     dico)

(define garbage-collector-job
  #~(job '(next-hour '(1))
         (lambda ()
           (guix-gc))))

(define %cuirass-specs
  #~(list
      ; TBD add build jobs for projects
      '()))

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
                                           "audio" "video")))
                 %base-user-accounts))

    (packages (cons* neovim neovim-limelight neovim-idris neovim-tabular
                     neovim-asyncrun neovim-lastplace neovim-supertab
                     neovim-nerdtree neovim-syntastic
                     nss-certs
                     iproute
                     curl links git tcpdump rsync aria2 icecat
                     darkhttpd
                     fbida zathura zathura-ps zathura-djvu zathura-pdf-mupdf
                     libreoffice ghc-pandoc
                     clang gforth fasm idris ghc node
                     gnu-make gdb man-pages
                     font-fira-code font-dotsies font-hack font-ibm-plex
                     font-lato font-liberation font-google-noto font-google-roboto
                     font-linuxlibertine font-mononoki font-ubuntu font-dejavu
                     font-comic-neue font-inconsolata
                     kitty
                     acpi pv recutils rlwrap tree unzip zip alsa-utils htop
                     manaplus gnugo thefuck minetest
                     claws-mail nheko-reborn
                     mpv ffmpeg youtube-viewer
                     aspell aspell-dict-en aspell-dict-sv diction
                     scrot xclip gimp
                     guile-minikanren
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
                     (service xfce-desktop-service-type)
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
                     %base-services))

    (name-service-switch %mdns-host-lookup-nss)))

laptop

; vim: et
