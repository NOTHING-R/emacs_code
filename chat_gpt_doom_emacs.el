(setq inhibit-startup-message t)

(croll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)
(load-theme 'doom-dracula t)

;; Ensure package management is enabled
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")
	("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

;; Refresh packages if necessary
(unless package-archive-contents
  (package-refresh-contents))

;; Install `use-package` if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))


;; Install General.el for leader key support
(use-package general
  :config
  (general-create-definer my-leader-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"   ;; Space as Leader key
    :global-prefix "M-SPC") ;; Optional, for non-evil modes

  ;; Define Leader Keybindings
  (my-leader-def
    ;; File-related commands
    "f"  '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find file")
    "fs" '(save-buffer :which-key "Save file")
    "fr" '(recentf-open-files :which-key "Recent files")

    ;; Buffer-related commands
    "b"  '(:ignore t :which-key "Buffers")
    "bb" '(switch-to-buffer :which-key "Switch buffer")
    "bd" '(kill-buffer :which-key "Kill buffer")

    ;; Project-related commands (assuming projectile is installed)
    "p"  '(:ignore t :which-key "Projects")
    "pp" '(projectile-switch-project :which-key "Switch project")
    "pf" '(projectile-find-file :which-key "Find file in project")

    ;; Git-related commands (assuming magit is installed)
    "g"  '(:ignore t :which-key "Git")
    "gs" '(magit-status :which-key "Git status")
    "gc" '(magit-commit :which-key "Git commit")

    ;; Quit-related commands
    "q"  '(:ignore t :which-key "Quit")
    "qq" '(kill-emacs :which-key "Quit Emacs")
    
    ;; Evaluate buffer instead of last expression
    "x"  '(:ignore t :which-key "Evaluate")
    "xe" '(eval-buffer :which-key "Evaluate entire buffer")

    ;; You can add more sections here based on your preferences
    ))



;; Doom Themes (Dark themes)
(use-package doom-themes
  :config
  (load-theme 'doom-dracula t))

;; Doom Modeline (Better status bar)
(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

(use-package company
  :hook (after-init . global-company-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

(use-package swiper
  :after ivy
  :bind (("SPC s" . swiper)))

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

