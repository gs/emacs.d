(setq inhibit-startup-message t)

(tooltip-mode -1)           ; Disable tooltips

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; Highlight current line.
(global-hl-line-mode t)

(setq custom-file "~/.emacs.d/garbage.el")
;; Use `command` as `meta` in macOS.
(setq mac-command-modifier 'meta)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

; Require and initialize `package`.
(require 'package)
(package-initialize)

(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package company
 :config
  (setq company-idle-delay 0.1)
  (global-company-mode t))

(setq evil-want-keybinding nil)
(use-package command-log-mode)
(use-package neotree)
(use-package restart-emacs)
(use-package evil-surround)
(use-package py-autopep8)
(use-package undo-fu)
(use-package evil
  :init (setq evil-want-keybinding nil)
  :config
  (evil-mode t)
  (evil-set-undo-system 'undo-fu)
  (setq evil-move-cursor-back nil
        evil-move-beyond-eol t
        evil-want-fine-undo t
        evil-mode-line-format 'before
        evil-normal-state-cursor '(box "orange")
        evil-insert-state-cursor '(box "green")
        evil-visual-state-cursor '(box "#F86155")
        evil-emacs-state-cursor  '(box "purple"))
  ;; Prevent evil-motion-state from shadowing previous/next sexp
  (require 'evil-maps)
  (define-key evil-motion-state-map "L" nil)
  (define-key evil-motion-state-map "M" nil))
(use-package evil-collection
  :after (evil)
  :config
  (evil-collection-init)
  ;; Stop changing how last-sexp works. Even though we have evil-move-beyond-eol
  ;; set, this is still being added, and I can't figure out why. Resorting to
  ;; this hack.
  (cl-loop
   for fun
   in '(elisp--preceding-sexp cider-last-sexp pp-last-sexp)
   do (advice-mapc (lambda (advice _props) (advice-remove fun advice)) fun)))
(use-package evil-surround
  :config (global-evil-surround-mode 1))
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode 1))
(use-package winum
  :config (winum-mode 1))
(use-package smartparens
  :init (require 'smartparens-config)
  :diminish smartparens-mode
  :hook (prog-mode . smartparens-mode))

; We don't actually enable cleverparens, because most of their bindings we
;; don't want, we install our own bindings for specific sexp movements
(use-package evil-cleverparens
  :after (evil smartparens))
(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :hook ((clojurex-mode
          clojurescript-mode
          clojurec-mode
          clojure-mode
          emacs-lisp-mode
          lisp-data-mode)
         . aggressive-indent-mode))
(use-package rainbow-delimiters
  :hook ((cider-repl-mode
          clojurex-mode
          clojurescript-mode
          clojurec-mode
          clojure-mode
          emacs-lisp-mode
          lisp-data-mode
          inferior-emacs-lisp-mode)
         . rainbow-delimiters-mode))
(use-package evil-org)
(use-package projectile-ripgrep)
(use-package rg)
(use-package lispy)
(use-package helm-rg)
(use-package yasnippet-snippets)
(use-package magit)
(use-package rjsx-mode)
(use-package yaml-mode)
(use-package elpy)
(use-package helm-projectile)
(use-package helm)
(use-package projectile)
(use-package evil)
(use-package evil-leader)
(use-package noctilux-theme)
(use-package clojure-mode)
(use-package clojure-snippets)
(use-package markdown-mode)
(use-package clj-refactor)
(use-package lispy)
(use-package paredit)
(use-package smart-tab)
(use-package smart-yank)
(use-package clj-refactor)
(use-package doom-modeline)
(use-package company-tabnine)
(use-package cider)
(use-package flycheck)
(use-package flycheck-pos-tip)
(use-package flycheck-clojure)
(use-package jedi)
(use-package company-jedi)
(use-package auto-package-update)

(load-theme 'noctilux t)
(load-theme 'rubytapas t)

;;(setq whitespace-line-column 80)
(setq whitespace-style '(face tabs empty trailing lines-tail))
(setq projectile-enable-caching t)
(setq helm-autoresize-mode t)
(setq helm-buffer-max-length 40)
(setq elpy-rpc-timeout nil)

(evil-mode t)
(evil-org-mode t)
(elpy-enable)
(helm-mode t)
(helm-projectile-on)
(global-set-key (kbd "M-x") 'helm-M-x)
(projectile-global-mode)
(global-evil-leader-mode)
(paredit-mode 1)
(yas-global-mode 1)
(clj-refactor-mode 1)
(global-flycheck-mode 1)
(doom-modeline-mode 1)
(global-whitespace-mode)
(recentf-mode 1)

;;(define-key evil-normal-state-map (kbd "C-]") 'elpy-goto-definition)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-visual-state-map (kbd ";") 'evil-ex)
(define-key evil-motion-state-map (kbd ";") 'evil-ex)
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

(evil-leader/set-leader ",")
;; Special key mapings
(evil-leader/set-key
  "p" 'helm-projectile
  "f" 'projectile-find-file
  "F" 'projectile-recentf
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "/" 'projectile-ripgrep
  "t" 'eshell
  "gg" 'magit-status
  "gb" 'magit-blame-addition
  "m" 'minimize-window
  "M" 'maximize-window
  "e" 'neotree-toggle
  "s" 'swiper
  "!" 'async-shell-command
  "TAB" 'org-cycle)

(defun bury-compile-buffer-if-successful (buffer string)
 "Bury a compilation buffer if succeeded without warnings "
 (when (and
         (buffer-live-p buffer)
         (string-match "compilation" (buffer-name buffer))
         (string-match "finished" string)
         (not
          (with-current-buffer buffer
            (goto-char (point-min))
            (search-forward "warning" nil t))))
    (run-with-timer 1 nil
                    (lambda (buf)
                      (bury-buffer buf)
                      (switch-to-prev-buffer (get-buffer-window buf) 'kill))
                    buffer)))
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)
(put 'downcase-region 'disabled nil)

(setq make-backup-files nil)
;; tabnine completion support
(require 'company-tabnine)
(define-key global-map (kbd "C-l") #'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
