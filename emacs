;; .emacs

(custom-set-variables
 ;; uncomment to always end a file with a newline
 ;'(require-final-newline t)
 ;; uncomment to disable loading of "default.el" at startup
 '(inhibit-default-init t)
 ;; default to unified diffs
 '(menu-bar-mode nil)
 '(diff-switches "-u"))


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(setq package-load-list '((helm-core t) (helm t) (async t) (popup t)))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
      (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(which-key-setup-side-window-right)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(add-to-list 'load-path "/home/avinashp/helm")
(require 'helm-config)

(require 'helm-flycheck) ;; Not necessary if using ELPA package
(eval-after-load 'flycheck
     '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
(add-hook 'after-init-hook #'global-flycheck-mode)

(blink-cursor-mode -1)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)

(require 'helm-swoop)
;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;;Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; find files in the project
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)


(require 'helm-git-grep)
(global-set-key (kbd "C-c g") 'helm-git-grep)
;;(global-set-key (kbd "C-c s") 'helm-git-grep-at-point)
;; Invoke `helm-git-grep' from isearch.
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)

;; Invoke `helm-git-grep' from other helm.
(eval-after-load 'helm
    '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))


(global-set-key (kbd "C-s") 'occur)

(require 'helm-ag)
(global-set-key (kbd "C-x C-g") 'helm-do-ag)


(require 'magit)
(global-set-key (kbd "C-c s") 'magit-status)


(ac-config-default)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;;; .emacs - Emacs start-up file
(setq inhibit-startup-screen t)

;;; Default mode for new files is text-mode.
(setq default-major-mode 'c-mode)
(setq line-number-mode t)
(setq column-number-mode t)
(global-auto-revert-mode 1)

(load-library "font-lock")
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'dired-mode-hook 'turn-on-font-lock)
(add-hook 'asm-mode-hook 'turn-on-font-lock)
(setq c-font-lock-keywords t)
(set-face-background 'default "Dark")
(set-face-foreground 'default "White")
(set-face-foreground 'font-lock-function-name-face "LightYellow")
(set-face-foreground 'font-lock-comment-face "MediumAquamarine")
(set-face-foreground 'mode-line "ivory")



;; Load the Compile library.
(load-library "progmodes/compile")

;; Load the C and C++ library 
(load-library "progmodes/cc-mode")

(message "bold done")
(setq default-cursor-type 'box)


;; remove auto save
(setq auto-save-default nil)

;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; Do local C/C++ customizations
;;(load-library "progmodes/panos-setup")

; no electric mode in c
(c-toggle-electric-state -1)

;; Define our own C/C++ style */
;;(defconst my-c-style
;;  '(indent-tabs-mode nil)         ;; use whitespaces instead of tabs 
;;   )                                  
(setq c-default-style "k&r"
      c-basic-offset  4)            

;; display full path of file 
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))


(global-set-key "\C-xl" 'goto-line)
(setq x-select-enable-clipboard t)

;;(cua-mode)

;;Add global gtags
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path "/home/avinashp/gtags/global-6.5.4/")
(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
(setq load-path (cons "/home/avinashp/global" load-path))
(autoload 'gtags-mode "gtags" "" t)

;;(autoload 'highlight-changes-mode "highlight" "" t)

;;; Enable helm-gtags-mode
(require 'helm-gtags)
(setq helm-gtags-prefix-key "\C-t")
;; customize
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-use-input-at-cursor t)
 '(helm-gtags-pulse-at-cursor t)
 '(helm-gtags-suggested-key-mapping t)
 )


(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)


;; key bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
    (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))



(defun describe-last-function() 
  (interactive) 
  (describe-function last-command))


;;; Done!
(message "Welcome to emacs!")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 101 :width normal :foundry "unknown" :family "DejaVu Sans")))))

(put 'downcase-region 'disabled nil)


(defun toggle-maximize-buffer () "Maximize buffer"
       (interactive)
       (if (= 1 (length (window-list)))
           (jump-to-register '_)
         (progn
           (window-configuration-to-register '_)
           (delete-other-windows))))
(global-set-key (kbd "C-c C-f") 'toggle-maximize-buffer)

