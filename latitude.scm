(use-modules (gnu))
(use-package-modules
  vim tmux terminals llvm xorg certs suckless libevent tor
  man pdf curl gcc web-browsers version-control pkg-config
  chromium xdisorg linux mpd video gimp inkscape gnuzilla
  admin pv bittorrent image-viewers mail python valgrind nim
  node aspell dictionaries speech graphviz wine gdb irc elm
  forth compression networking haskell-xyz tex rsync fonts
  shellutils web commencement base golang haskell-xyz file
  wm haskell textutils text-editors javascript python-check
  check monitoring python-xyz lisp-xyz crypto mono debian
  wget gnupg java games gnome sdl gl graphics game-development
  lean agda audio dico compton virtualization distributed julia
  messaging glib python-web ocaml assembly prolog haskell-apps
  sml idris gnunet vpn firmware vulkan)

(use-service-modules
  desktop networking ssh xorg pm sound cuirass audio
  getmail mcron virtualization sddm dns admin messaging)

(use-modules (tau packages fonts)
             (tau packages zig)
             (tau packages firmware)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (tau packages agda)
             (tau packages vim)
             (tau packages ats)
             (tau packages haskell)
             (tau packages xorg)
             (tau packages drawpile)
             (guix packages)
             (guix download)
             (guix gexp)
             (guix build-system python)
             (tau packages python))

(define garbage-collector-job
  #~(job '(next-hour '(10)) "guix gc -F 10G"))


(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/Stockholm")
  (keyboard-layout (keyboard-layout "se"))
  (host-name "guixpii")
  (hosts-file
    (plain-file "hosts"
                (string-append (local-host-aliases host-name)
                               %facebook-host-aliases)))

  (kernel linux)
  (kernel-arguments (list "intel_iommu=on"))
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))
  (mapped-devices
    (list (mapped-device
            (source
              (uuid "a6086a35-ee99-4da7-93f8-b2b9c2d016bf"))
            (target "cryptroot")
            (type luks-device-mapping))))
  (file-systems
    (cons* (file-system
             (mount-point "/boot/efi")
             (device (uuid "D232-1C9B" 'fat32))
             (type "vfat"))
           (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4")
             (dependencies mapped-devices))
           %base-file-systems))
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
      (list nss-certs neovim kitty tmux man-pages dmenu zathura sshfs zip fzy
            wireshark tree xrandr sassc clang texlive boinc-client
            espeak-ng slock graphviz unzip gforth gnu-make libevent wine64
            mpv gimp inkscape nmap scrot pv aria2 feh diction rsync
            pkg-config torsocks valgrind gdb weechat mpd-mpc
            zathura-pdf-mupdf zathura-ps zathura-djvu xclip aspell-dict-sv
            elm-compiler nim go file htop sent dico aspell-dict-uk
            alsa-utils neomutt
            node aspell fswatch uglify-js thefuck redshift

            ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-types ghc ghc-entangled
            ghc-pandoc-crossref ghc-pandoc-filter-graphviz ghc-pandoc-sidenote
            ghc-pandoc-stylefrommeta ghc-pandoc-csv2table
            ghc-panpipe ghcid ghc-tldr

            gcc-toolchain

            julia

            xonotic

            vulkan-tools vulkan-headers mesa

            encfs acpi xsetroot spoon qemu ovmf

            ocaml ocaml4.07-core ocaml4.07-dune ocaml4.07-earley
            ocaml4.07-merlin ocaml4.07-ppx-jane ocaml4.07-ppx-let
            ocaml4.07-ppx-pipebang ocaml4.07-ppx-hash ocaml4.07-ppx-optional
            ocaml4.07-uri ocaml4.07-spawn ocaml4.07-utop ocaml4.07-ezjsonm
            ocaml4.07-findlib

            tcpdump net-tools zpaq

            ;python-problog python-telethon python-entangled-filters python-pytest
            ;python-pandocfilters python-panflute python-pygraphviz python-graphviz
            ;python-2 python python-pmbootstrap python-requests
            python

            sshoot sshuttle

            youtube-dl

            idris

            font-jetbrains-mono font-scientifica
            font-google-noto font-victor-mono font-mononoki font-awesome
            font-comic-neue font-dejavu font-hack font-liberation
            font-linuxlibertine font-lato font-mathjax font-ubuntu font-hermit
            font-wqy-microhei font-cns11643 font-wqy-zenhei

            xf86-input-wacom xhost xf86-video-intel xinput xmodmap setxkbmap

            zig-0.6.0

            icecat
            gnunet

            tidy-html

            neovim-zig neovim-gitgutter neovim-tabular neovim-limelight
            neovim-lastplace

            carpalx

            ats2

            ffmpeg

            dwm curl gnu-c-manual links git ungoogled-chromium
            glibc-utf8-locales colobot minetest adanaxisgpl no-more-secrets
            mono debootstrap wget gnupg (list icedtea-8 "jdk") sdl2 mojoshader
            mojoshader-cs blender godot lean agda agda-stdlib mesa-utils ardour
            qemu drawpile wabt llvm clang-toolchain surf fortune-mod sky ri-li
            stockfish chessx telegram-purple pidgin glib strace fasm swi-prolog
            ghostwriter xprop xwininfo neomutt compton)
      %base-packages))
  (services
    (append
      (list (service openssh-service-type
              (openssh-configuration
                (x11-forwarding? #t)))
            (service tor-service-type)
            (service thermald-service-type)
            (service tlp-service-type
                     (tlp-configuration
                       (sched-powersave-on-ac? #t)
                       (energy-perf-policy-on-ac "powersave")))
            (service qemu-binfmt-service-type
              (qemu-binfmt-configuration
                (platforms (lookup-qemu-platforms "aarch64"))
                (guix-support? #t)))
            (service mcron-service-type
              (mcron-configuration
                (jobs (list garbage-collector-job))))
            (service slim-service-type)
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
            (service wpa-supplicant-service-type)
            (service network-manager-service-type
              (network-manager-configuration
                (dns "none")))

            (extra-special-file
              "/etc/resolv.conf"
              (plain-file "resolv.conf" "nameserver 127.0.0.1"))

            (extra-special-file
              "/usr/bin/env"
              (file-append coreutils "/bin/env")))

      %base-services)))
