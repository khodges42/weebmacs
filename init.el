;;;;; PACKAGE MANAGEMENT
;;;; Melpa
(require 'package) 
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
;;;; GNU
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


;;;;; INTERFACE
;;;; Emacs the way stallman wanted it (removes menu bar, toolbar, scrollbar)
  (menu-bar-mode -1)
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (when (fboundp 'horizontal-scroll-bar-mode)
(horizontal-scroll-bar-mode -1))
;;;; Global Linum Mode (numbers all lines. You can turn on by M-x Linum-mode)
(global-linum-mode 0)
;;;; Turnoff backup (those annoying backup files.)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
;;;; Cool hacker transparency
(set-frame-parameter (selected-frame) 'alpha '(94 . 83))
(add-to-list 'default-frame-alist '(alpha . (94 . 83)))
;;;; trees
(require 'neotree)
;;;; shell-pop
(require 'shell-pop)
;;;; start fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;;; Show images in org mode
(setq org-startup-with-inline-images t)
;;;; Custom Startup Weeb Mode
(setq initial-buffer-choice "~/.emacs.d/startscreen/startscreen.org")
;;;; ido mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
;;;; Winner Mode
(when (fboundp 'winner-mode)
  (winner-mode 1))
;;;; Hippie Expand
 (global-set-key (kbd "M-/") 'hippie-expand)
;;;; Themes. You can replace the 'rebecca with any theme you have installed.
(require 'sublime-themes)
(add-hook 'emacs-startup-hook(lambda()(load-theme 'spolsky)))

;;;;; LANGUAGE SUPPORT
;;;; Python
;;; Python-Mode
(defvar pyPackages
  '(better-defaults
   elpy))
;;;; Golang
;;; set gopath
(setenv "GOPATH" "~/go")
;;; godoc
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))
;;; gofmt on save
(add-to-list 'exec-path "/usr/local/go/bin")
(add-hook 'before-save-hook 'gofmt-before-save)
















;;;;;; MACROS AND KEYBINDS
;;;; Split 4 automatically splits into 4 windows.
(fset 'split4
   [?\C-x ?2 ?\C-x ?3 S-down ?\C-x ?3])
(global-set-key (kbd "M-4") 'split4)
;; Toggle Neotree with C-Tab
(global-set-key (kbd "M-w") 'neotree-toggle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "f633d825e380caaaefca46483f7243ae9a663f6df66c5fad66d4cab91f731c86" default)))
 '(package-selected-packages
   (quote
    (cheatsheet sublime-themes shell-pop multi-term exec-path-from-shell dumb-jump go-autocomplete go-imports go-mode rebecca-theme neotree sublime-themes)))
 '(shell-pop-default-directory "~/")
 '(shell-pop-full-span t)
 '(shell-pop-shell-type
   (quote
    ("multi-term" "*multi-term*"
     (lambda nil
       (multi-term)))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-universal-key "M-q")
 '(shell-pop-window-position "bottom")
 '(shell-pop-window-size 30))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
