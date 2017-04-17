;;; init.el --- My emacs init.el file

;;; Commentary:
; It's my config file.  Go figure

;;; Code:

;; the package manager - set it up and bootstrap use-package if necessary
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant
;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil
 auto-save-default nil)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; base emacs modes
(electric-indent-mode 0)
(electric-pair-mode 0)
(show-paren-mode 1)

;; global keybindings
(global-unset-key (kbd "C-z"))

;; Themes & Aesthtics
(set-frame-font "SauceCodePro Nerd Font")
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

;;;
;;; General Emacs Use Packages
;;;

;; Sensible Defaults -- https://github.com/technomancy/better-defaults
(use-package better-defaults
  :ensure t)

;; https://github.com/editorconfig/editorconfig-emacs
;; needs to have the c-core installed as well:
;; https://github.com/editorconfig/editorconfig-core-c
(use-package editorconfig
  :ensure t
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package projectile
  :ensure t
  :init   (setq projectile-use-git-grep t)
  :config
  (projectile-mode t)
  (setq projectile-enable-caching t))

(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config (global-undo-tree-mode)
  :bind ("C-c /" . undo-tree-visualize))

;; ido literally everywhere!
(use-package smex
  :ensure t
  :config
  (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ;; This is your old M-x.
         ("C-c C-c M-x" . execute-extended-command)))

(use-package ido
  :ensure t
  :demand t
  :config
  (setq ido-enable-flex-matching t)
  (ido-everywhere t)
  (ido-mode 1))

(use-package ido-ubiquitous
  :ensure t
  :demand t
  :config
  (ido-ubiquitous-mode 1))

(use-package flx-ido
  :ensure t
  :demand t
  :init
  (setq
   ido-enable-flex-matching t
   ;; C-d to open directories
   ;; C-f to revert to find-file
   ido-show-dot-for-dired nil
   ido-enable-dot-prefix t
   ido-use-faces nil
   ;; Garbage Collection for a more modern machine
   gc-cons-threshold 20000000)
  :config
  (flx-ido-mode 1))

(use-package magit
  :ensure t
  :commands magit-status magit-blame
  :init
  (setq
   magit-completing-read-function 'magit-ido-completing-read
   magit-auto-revert-mode nil)
  :bind (("C-c g" . magit-status)
         ("C-c b" . magit-blame)))

(use-package git-gutter
  :ensure t
  :demand
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1))

(use-package yasnippet
  :ensure t
  :demand t
  :diminish yas-minor-mode
  :commands yas-minor-mode
  :config (yas-reload-all))

(use-package company
  :ensure t
  :demand t
  :diminish company-mode
  :init
  (setq
   company-tooltip-limit 20
   company-tooltip-align-annotations t
   company-idle-delay .3
   company-minimum-prefix-length 4)
  :config
  ;; disables TAB in company-mode, freeing it for yasnippet
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "TAB") nil)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
  :ensure t
  :defer 5
  :config
  (global-flycheck-mode 1))

(use-package smartparens
  :ensure t
  :demand t
  :diminish smartparens-mode
  :commands
  smartparens-strict-mode
  smartparens-mode
  sp-restrict-to-pairs-interactive
  sp-local-pair
  :init
  (setq sp-interactive-dwim t)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)

  (sp-pair "(" ")" :wrap "C-(") ;; how do people live without this?
  (sp-pair "[" "]" :wrap "s-[") ;; C-[ sends ESC
  (sp-pair "{" "}" :wrap "C-{")

  ;; WORKAROUND https://github.com/Fuco1/smartparens/issues/543
  (bind-key "C-<left>" nil smartparens-mode-map)
  (bind-key "C-<right>" nil smartparens-mode-map)

  (bind-key "s-<delete>" 'sp-kill-sexp smartparens-mode-map)
  (bind-key "s-<backspace>" 'sp-backward-kill-sexp smartparens-mode-map))

(use-package rainbow-delimiters
  :demand
  :diminish rainbow-delimiters-mode
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;;;
;;; Org-Mode
;;;

(use-package org
  :ensure t
  :pin org
  :demand t
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c b" . org-iswitchb))
  :config
  (setq
   org-completion-use-ido t
   org-default-notes-file "~/org/notes/notes.org"
   ;; http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner/
   org-log-done t     ; Add timestamp when marking done
   org-agenda-ndays 7 ; Show 7 days by default
   org-deadline-warning-days 14 ; Warn 14 days before a deadline is due
   org-agenda-show-all-dates t  ; Show dates that don't have something due
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-scheduled-if-done t
   org-agenda-start-on-weekday nil
   org-reverse-note-order t
   ))

;;;
;;; Programming Languages
;;;

;; C

;; C++

;; Clojure
(use-package clojure-mode
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'clojure-mode #'smartparens-strict-mode)
  (add-hook 'clojurescript-mode #'smartparens-strict-mode))

(use-package cider
  :ensure t
  :pin melpa
  :config
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'cider-mode-hook
            '(lambda () (local-set-key (kbd "RET") 'newline-and-indent))))

;; Coffee-Script
(use-package coffee-mode
  :ensure t
  :pin melpa-stable)

;; Erlang
(use-package erlang
  :ensure t
  :pin melpa-stable)

;; Go

;; Haskell
(use-package haskell-mode
  :ensure t
  :pin melpa-stable)

(use-package intero
  :ensure t
  :pin melpa-stable
  :diminish intero-mode
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

;; Java
(use-package eclim
  :ensure t
  :init (setq eclimd-autostart t)
  :config
  (global-eclim-mode)
  (add-hook 'java-mode-hook 'eclim-mode))

(use-package company-emacs-eclim
  :ensure t
  :config (company-emacs-eclim-setup))

;; Javascript

;; JSON
(use-package json-mode
  :ensure t
  :pin melpa-stable)

(use-package json-reformat
  :ensure t
  :commands (json-reformat-region))

(use-package json-snatcher
  :ensure t
  :commands (jsons-print-path))

;; Markdown
(use-package markdown-mode
  :ensure t
  :pin melpa-stable
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Python

;; Scala
(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode))

(use-package ensime
  :ensure t
  :pin melpa-stable)

;; Web-Mode
(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.php\\'" . web-mode))
  :config (progn
            (setq web-mode-markup-indent-offset 2
                  web-mode-css-indent-offset 2
                  web-mode-code-indent-offset 2)))

;;;
;;; Auto Generated Stuff. Let's not touch
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-boot-parameters "dev")
 '(custom-safe-themes
   (quote
    ("10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" default)))
 '(org-agenda-files
   (quote
    ("~/org/agendas/projects.org" "~/org/agendas/personal.org" "~/org/agendas/work.org")))
 '(org-capture-templates
   (quote
    (("t" "Add TODO task in personal " entry
      (file+headline "~/org/agendas/personal.org" "Tasks")
      "* TODO %^{Task}
%?
%U")
     ("p" "Add TODO into projects" entry
      (file+headline "~/org/agendas/projects.org" "Tasks")
      "* TODO %^{Task}
%?
%U")
     ("P" "Add TODO into projects with a file link" entry
      (file+headline "~/org/agendas/projects.org" "Tasks")
      "* TODO %^{Task}
%?
%f
%U")
     ("w" "Add TODO to work agenda" entry
      (file+headline "~/org/agendas/work.org" "Unsorted Tasks")
      "* TODO %^{Task}
%?
%U")
     ("W" "Add TODO with file link" entry
      (file+headline "~/org/agendas/work.org" "Unsorted Tasks")
      "* TODO %^{Task}
%?
%f
%U"))))
 '(package-selected-packages
   (quote
    (erlang intero haskell-mode json-mode org-plus-contrib ido-completing-read+ cider company-emacs-eclim eclimd eclim ensime scala-mode flycheck rainbow-delimiters web-mode clojure-mode ag smartparens company yasnippet editorconfig undo-tree git-gutter use-package coffee-mode gruvbox-theme flx-ido projectile magit smex ido-ubiquitous better-defaults))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

