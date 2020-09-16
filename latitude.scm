(use-modules (gnu))
(use-package-modules
  vim tmux terminals llvm xorg certs suckless libevent tor android
  man pdf curl gcc web-browsers version-control pkg-config maths
  chromium xdisorg linux mpd video gimp inkscape gnuzilla php dns
  admin pv bittorrent image-viewers mail python valgrind nim
  node aspell dictionaries speech graphviz wine gdb irc elm
  forth compression networking haskell-xyz tex rsync fonts ocr
  shellutils web commencement base golang haskell-xyz file
  wm haskell textutils text-editors javascript python-check
  check monitoring python-xyz lisp-xyz crypto mono debian
  wget gnupg java games gnome sdl gl graphics game-development
  lean agda audio dico compton virtualization distributed julia
  messaging glib python-web ocaml assembly prolog haskell-apps
  sml idris gnunet vpn firmware vulkan spice kde libreoffice
  machine-learning)


(use-service-modules
  desktop networking ssh xorg pm sound cuirass audio web
  mcron virtualization sddm dns admin messaging)

(use-modules (tau packages fonts)
             (tau packages zig)
             (tau packages firmware)
             (nongnu packages linux)
             (nongnu packages mozilla)
             (nongnu packages steam-client)
             (nongnu system linux-initrd)
             (tau packages vim)
             (tau packages haskell)
             (tau packages xorg)
             (tau packages telegram)
             (tau packages drawpile)
             (guix packages)
             (guix download)
             (guix gexp)
             (tau packages python))

;(define channels
;  (list (channel
;          (name 'guix)
;          (url "https://git.savannah.gnu.org/git/guix.git")
;          (commit "96a655a77bb087397a9436391e472c36ff0a2ec2"))))

;(define (inferior name)
;  (first (lookup-inferior-packages (inferior-for-channels channels) name)))

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
      (list nss-certs kitty tmux man-pages dmenu zathura sshfs zip fzy
            tree xrandr clang texlive poppler
            espeak-ng slock graphviz unzip gforth gnu-make libevent wine64
            mpv gimp inkscape nmap scrot pv feh diction rsync
            torsocks valgrind gdb weechat mpd-mpc
            zathura-pdf-mupdf zathura-ps zathura-djvu xclip aspell-dict-sv
            elm-compiler nim go file sent dico aspell-dict-uk
            neomutt telegram-cli isc-bind flite tesseract-ocr
            aspell thefuck redshift ;firefox

            ghc-pandoc ghc-pandoc-citeproc ghc-pandoc-types ghc ghc-entangled
            ghc-pandoc-crossref ghc-pandoc-filter-graphviz ghc-pandoc-sidenote
            ghc-pandoc-stylefrommeta ghc-pandoc-csv2table
            ghc-panpipe ghcid ghc-tldr

            alsa-utils cava steam

            gcc-toolchain

            mailutils fetchmail libreoffice
            dico xdotool fastboot


            encfs acpi xsetroot spoon qemu ovmf ;dosfstools

            stunnel tcpdump net-tools zpaq

            python python-pynvim

            sshoot sshuttle

            youtube-dl

            sassc node tidy-html wget aria2 jq

            icecat ;(inferior "ungoogled-chromium")

            font-jetbrains-mono font-scientifica
            font-google-noto font-victor-mono font-mononoki font-awesome
            font-comic-neue font-dejavu font-hack font-liberation
            font-linuxlibertine font-lato font-mathjax font-ubuntu font-hermit
            font-wqy-microhei font-cns11643 font-wqy-zenhei

            xf86-input-wacom xhost xf86-video-intel xinput xmodmap xprop
            krita drawpile

            zig-0.6.0-master

            supertuxkart btanks 0ad minetest php

            asciinema python-pmbootstrap

            neovim neovim-zig neovim-gitgutter neovim-tabular neovim-limelight
            neovim-lastplace neovim-gruvbox neovim-vebugger neovim-rainbow
            neovim-ale neovim-deoplete neovim-pandoc-syntax

            ffmpeg fakechroot fakeroot ;kaldi

            qemu spice-gtk

            vulkan-loader vulkan-tools spirv-tools vulkan-headers spirv-headers
            glfw pkg-config

            dwm bspwm sxhkd octave wxmaxima

            curl gnu-c-manual links lynx git ;netcat-openbsd
            glibc-utf8-locales no-more-secrets
            debootstrap wget gnupg (list icedtea-8 "jdk") sdl2
            mesa-utils
            wabt llvm clang-toolchain fortune-mod
            strace prout
            xprop xwininfo neomutt compton)
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
                (platforms (lookup-qemu-platforms "aarch64" "arm"))
                (guix-support? #t)))

            (udev-rules-service 'usb-android android-udev-rules)
            (service mcron-service-type
              (mcron-configuration
                (jobs (list garbage-collector-job))))

            (service slim-service-type)

            (service httpd-service-type
              (httpd-configuration
                (config
                  (httpd-config-file
                  (server-name "server")
                  (document-root "/home/tau/web")))))

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
              "/lib64/ld-linux-x86-64.so.2"
              (file-append clang-toolchain "/lib/ld-linux-x86-64.so.2"))

            (extra-special-file
              "/usr/bin/env"
              (file-append coreutils "/bin/env")))

      %base-services)))
