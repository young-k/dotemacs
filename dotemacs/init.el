;;; package --- Summary

;;; Commentary:

;;;     Nothing

;;; Code:
(package-initialize nil)

(add-to-list 'load-path "~/.emacs.d/packages/org-mode/contrib/lisp") 
(add-to-list 'load-path "~/.emacs.d/packages/org-mode/lisp")	     
(add-to-list 'load-path "~/.emacs.d/packages/lisp")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; Added for special powerline mode-line

(require 'package)						     
								     
(add-to-list 'package-archives					     
	     '("melpa" . "http://melpa.org/packages/") t)	     

(package-initialize t)
(setq package-enable-at-startup nil)

(setq user-full-name "Young Kim"
      user-mail-address "young-k@protonmail.com")

;; Multi-line commenting
(setq comment-style 'multi-line)

;; Asks "y-or-n" instead of asking "yes-or-no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Set font to DejaVu Sans Mono
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

;; Taken from Zamansky's Emacs Config
(defun sacha/package-install (package &optional repository)
  "Install PACKAGE if it has not yet been installed.
If REPOSITORY is specified, use that."
  (unless (package-installed-p package)
    (let ((package-archives (if repository
                                (list (assoc repository package-archives))
                              package-archives)))
      (package-install package))))

;; Installing use-package
(sacha/package-install 'use-package)
(require 'use-package)			; Better package installation

;; Installing company
(sacha/package-install 'company)
(use-package company			; Text completion framework
  :init
  (company-mode t))

;; Installing company-jedi
(sacha/package-install 'company-jedi)	; Company for Python
(use-package company-jedi
  :init
  (company-jedi t))

;; Taken from Aaron Bieber's Config
(require 'init-powerline)		; Powerline mode-line

;; Installing markdown-mode
(sacha/package-install 'markdown-mode)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Installing jade-mode
(sacha/package-install 'sws-mode)
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))

;; Installing auto-complete
(sacha/package-install 'auto-complete)
(use-package auto-complete
:init
(progn
(require 'auto-complete-config)
(ac-config-default)
(setq ac-sources '(
                   ac-source-symbols
                   ac-source-words-in-same-mode-buffers
                   ac-source-functions
                   ac-source-variables
                   ac-source-dictionary
                   ac-source-filename
                   ac-source-yasnippet
                   ))
(setq ac-auto-show-menu 0)
(auto-complete-mode t)
))

;; Installing aggresive-indent
(use-package aggressive-indent
:ensure t
:init (progn
  (global-aggressive-indent-mode 1)
)
)

;; Installing helm and helm-swoop
(sacha/package-install 'helm)
(sacha/package-install 'helm-swoop)
(require 'helm-swoop)
      (use-package helm
        :init
        (progn 
          (require 'helm-config) 
          (require 'helm-eshell)
          (require 'helm-files)
          (require 'helm-grep)
  (setq helm-candidate-number-limit 10)
          (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
                helm-input-idle-delay 0.01  ; this actually updates things
                                              ; reeeelatively quickly.
                helm-quick-update t
                helm-M-x-requires-pattern nil
                helm-ff-skip-boring-files t)
  (helm-mode))
  :config
      (add-to-list 'helm-completing-read-handlers-alist '(switch-to-buffer . ido)))

(use-package helm-swoop
  :bind (("C-S-s" . helm-swoop)))


(defun helm-backspace ()
  "Forward to `backward-delete-char'.
On error (read-only), quit without selecting."
  (interactive)
  (condition-case nil
      (backward-delete-char 1)
    (error
     (helm-keyboard-quit))))

(define-key helm-map (kbd "DEL") 'helm-backspace)

;; Installing tex
(use-package tex
:ensure auctex)

;; Installing smartparens
(use-package smartparens
:ensure smartparens
:config 
(progn
(require 'smartparens-config)
(require 'smartparens-html)
(require 'smartparens-python)
(require 'smartparens-latex)
(smartparens-global-mode t)
))

;; Special Key Bindings
(global-set-key (kbd "M-x") 'helm-M-x)	; Basically change M-x to helm-M-x
(global-set-key (kbd "C-s") 'helm-swoop) ; Basically change C-s to helm-swoop
(global-set-key (kbd "C-x C-f") 'helm-find-files) ; Basically change C-s to helm-swoop

;; Installing flycheck
(sacha/package-install 'flycheck)
(sacha/package-install 'flycheck-pyflakes)
(use-package flycheck
:init
(global-flycheck-mode t))

;; Installing yasnippet
(sacha/package-install 'yasnippet)
(use-package yasnippet
  :init
  (yas-global-mode t))

;; Rebinding yasnippet to <C-tab> to not interfere with auto-complete
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;; Installing dracula-theme
(use-package dracula-theme
  :ensure t
  :init
  (load-theme 'dracula t))

(setq ns-function-modifier 'control)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
