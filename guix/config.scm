(use-modules
  ((gnu packages linux) #:prefix gnu:)
  (gnu system)
  (gnu)
  (guix gexp)
  (guix scripts gc)
  (guix scripts gc)
  (guix utils)
  (guix packages)
  (guix inferior)
  (guix channels)
  (levy packages firmware)
  (levy packages smalltalk)
  (levy packages fonts)
  (levy packages linux)
  (levy packages neovim)
  (levy packages emacs)
  (levy packages mercury)
  (levy packages ats)
  (srfi srfi-1)
  (srfi srfi-11))

(use-package-modules
  admin
  assembly
  aspell
  man
  gprolog
  gdb
  sml
  gtk
  gnunet
  chez
  rust
  emacs-xyz
  audio
  bittorrent
  speech
  gnome
  bootloaders
  certs
  erlang
  commencement
  compression
  compton
  smalltalk
  connman
  forth
  curl
  geo
  databases
  dictionaries
  emulators
  fonts
  elixir
  game-development
  agda
  games
  gimp
  gl
  scheme
  gnunet
  gnupg
  gnuzilla
  graphics
  graphviz
  base
  telephony
  irc
  guile-xyz
  guile
  guile-wm
  linux
  haskell
  idris
  image-viewers
  imagemagick
  inkscape
  java
  kde
  libreoffice
  mail
  maths
  mpd
  networking
  node
  package-management
  pdf
  pkg-config
  pv
  readline
  rsync
  screen
  ssh
  suckless
  terminals
  tex
  texinfo
  tor
  version-control
  video
  emacs
  vim
  virtualization
  web
  web-browsers
  text-editors
  wm
  xdisorg
  xorg)

(use-service-modules
  audio
  desktop
  mcron
  networking
  shepherd
  dns
  sound
  pm
  ssh
  xorg)

; TBD: refactor
(define garbage-collector-job
  #~(job '(next-hour '(1))
         (lambda () (guix-gc))))

(define (time-travel commit package)
  (let* ((chan
          (list (channel
                 (name 'guix)
                 (url "https://git.savannah.gnu.org/git/guix.git")
                 (commit commit))))
         (inferior (inferior-for-channels chan)))
   (first (lookup-inferior-packages inferior package))))

(define-public laptop
  (operating-system
    (host-name "levy")
    (hosts-file
      (local-file "/home/levy/.config/guixsd/etc/hosts"))

    (timezone "Europe/Stockholm")
    (locale "en_US.utf8")
    (kernel linux-nonfree)
    (kernel-arguments
      (list "modprobe.blacklist=pcspkr,snd_pcsp"
            "modprobe.iwlwifi.11n_disable=1"
            "acpi_osi=\"!Windows 2012\""))

    (firmware
      (cons* iwlwifi-firmware-nonfree
             %base-firmware))

    (bootloader
      (bootloader-configuration
        (bootloader grub-bootloader)
        (target "/dev/sda")))

    (file-systems
      (cons* (file-system
               (device (file-system-label "root"))
               (mount-point "/")
               (type "ext4"))
             %base-file-systems))

    (users
      (cons (user-account
              (name "levy")
              (comment "A new journey begins")
              (group "users")
              (supplementary-groups
                (list "wheel"
                      "audio"
                      "video"
                      "kvm"
                      "lp"
                      "netdev"
                      "disk"))
              (home-directory "/home/levy"))
            %base-user-accounts))

    (packages
      (cons* ;; VIM
        neovim
        neovim-asyncrun
        neovim-gitgutter
        neovim-goyo
        neovim-idris
        neovim-lastplace
        neovim-limelight
        neovim-rainbow
        neovim-supertab
        neovim-tabular
        neovim-syntastic
        neovim-paredit
        ; neovim-mercury
        vis
        ghostwriter
        ;; EMACS
        emacs-xwidgets
        emacs-rainbow-delimiters
        emacs-monotropic-theme
        emacs-evil
        emacs-evil-mu4e
        emacs-mu4e-alert
        emacs-mu4e-conversation
        emacs-mbsync
        emacs-evil-magit
        emacs-evil-surround
        emacs-evil-commentary
        emacs-evil-anzu
        emacs-evil-collection
        emacs-evil-quickscope
        emacs-evil-smartparens
        emacs-guix
        emacs-geiser
        emacs-flycheck
        emacs-graphviz-dot-mode
        emacs-alchemist
        emacs-doom-themes
        emacs-company
        emacs-ats2
        emacs-idris-mode
        ;; DEVELOPMENT
        inotify-tools
        gnu-make
        darkhttpd
        git
        gdb
        man-pages
        ;pkg-config
        ;; COMPILERS & INTERPRETERS
        fasm
        ; mercury-rotd
        smalltalk-custom
        gprolog
        squeak-vm
        ;erlang
        gcc-toolchain
        ghc ghc-parallel ghc-profunctors ghc-alex ghc-happy
        ;icedtea
        polyml
        idris
        ;agda
        node
        guile-readline
        chibi-scheme
        gforth
        ats2
        ;guile-xcb
        ;guile-minikanren
        ;guile-8sync
        ;guile-git
        racket
        ;chez-sockets
        ;chez-srfi
        chez-scheme
        elixir
        ;chez-web
        ;chez-matchable
        ;chez-irregex
        ;; UTILS
        weechat
        asciinema
        ;dtach
        espeak
        gnu:acpi
        gnupg
        htop
        kitty
        mcron
        mosh
        pinentry
        pv
        recutils
        rlwrap
        tree
        unzip
        zip
        ;; DESKTOP
        ;0ad
        pioneer
        xprop
        ;bspwm
        compton
        rofi
        scrot
        sxhkd
        xclip
        xdotool
        xdpyinfo
        xev
        xkill
        xmodmap
        xrandr
        ;; GNOME
        evolution-data-server
        evolution
        gnome-tweak-tool
        gnome-shell-extensions
        gnome-maps
        gnome-calendar
        gnome-dictionary
        jami-client-gnome
        ;glade3
        claws-mail
        ;; MAIL
        fetchmail
        ;procmail
        isync
        ;sendmail
        ;mbsync
        ;; DOCUMENT PROCESSING
        aspell
        diction
        dot2tex
        ;ghc-pandoc
        gnuplot
        graphviz
        ;libreoffice
        haunt
        ; texinfo
        texlive
        zathura
        zathura-cb
        zathura-djvu
        zathura-pdf-poppler
        zathura-ps
        ;; FONTS
        font-comic-neue
        font-dejavu
        font-dotsies
        font-fira-code
        font-google-noto
        font-hack
        font-ibm-plex
        font-inconsolata
        font-iosevka
        font-lato
        font-liberation
        font-linuxlibertine
        font-ubuntu
        ;; NETWORKING
        aria2
        gnunet
        curl
        gnunet
        icecat
        links
        openssh
        rsync
        surf
        torsocks
        ;; GRAPHICS
        feh
        gimp
        krita
        imagemagick
        inkscape
        ;; MEDIA
        ffmpeg
        gnu:alsa-utils
        mpd
        mpd-mpc
        mpv
        sox
        ;; CERTS
        nss-certs
        ;; BASE
        %base-packages))

    (setuid-programs %setuid-programs)

    (name-service-switch %mdns-host-lookup-nss)

    (services
     (cons* (service gnome-desktop-service-type)

            (service mpd-service-type
                     (mpd-configuration
                      (user "levy")
                      (music-dir "~/media/music")
                      (playlist-dir "~/.config/mpd/playlists")))

            (service tor-service-type)

            (service openssh-service-type
                     (openssh-configuration
                      (password-authentication? #f)))

             (service mcron-service-type
                      (mcron-configuration
                       (jobs (list garbage-collector-job))))

             (service gdm-service-type)

             (service tlp-service-type
                      (tlp-configuration
                       (cpu-boost-on-ac? #t)))

             (service thermald-service-type)

             (modify-services (remove (lambda (s)
                                        (eq? (service-kind s) slim-service-type))
                                      %desktop-services)
                              (network-manager-service-type
                               config => (network-manager-configuration
                                          (inherit config)
                                          (dns "none")))
                              (guix-service-type
                               config => (guix-configuration
                                          (inherit config)
                                          (substitute-urls
                                           (list "https://berlin.guixsd.org"
                                                 "https://mirror.hydra.gnu.org"
                                                 "https://hydra.gnu.org")))))))))

laptop
