
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; evil pre-setting
(setq evil-want-C-u-scroll t
      evil-search-module 'evil-search
      evil-ex-search-vim-style-regexp t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; load evil
(require 'evil)
(evil-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; global setting

(show-paren-mode t)
(setq indicate-empty-lines t)
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/themes/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; helm
(require 'helm)
(define-key helm-map (kbd "C-h") 'delete-backward-char)

(load-theme 'murooka t)

(eval-when-compile (require 'cl))

(require 'end-mark)
(global-end-mark-mode)

(global-linum-mode)
(setq linum-format "%4d ")
(column-number-mode t)

(menu-bar-mode 0)
(setq inhibit-startup-message t)

(global-set-key (kbd "C-h") 'delete-backward-char)


(require 'keymap)
