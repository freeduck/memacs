(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)
;; Turn off mouse interface early in startup to avoid momentary display
(when (fboundp 'menu-bar-mode) (menu-bar-mode 0))
(when (fboundp 'tool-bar-mode) (tool-bar-mode 0))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))

(defconst kristian-savefile-dir (expand-file-name "savefile" user-emacs-directory))


(defun control-media (command)
  (call-process "smplayer" nil nil nil "-send-action" command))

(defun media-play-pause ()
  "Play or pause"
  (interactive)
  (control-media "play_or_pause"))

(defun media-next ()
  "Play Next"
  (interactive)
  (control-media "play_next"))

(defun media-prev ()
  "Play Previous"
  (interactive)
  (control-media "play_prev"))

(defun media-forward ()
  "Forward 1 minute"
  (interactive)
  (control-media "forward2"))

(defun media-rewind ()
  "Rewind 1 minute"
  (interactive)
  (control-media "rewind2"))

(global-set-key (kbd "C-c m p") 'media-play-pause)
(global-set-key (kbd "C-c m n") 'media-next)
(global-set-key (kbd "C-c m P") 'media-prev)
(global-set-key (kbd "C-c m f") 'media-forward)
(global-set-key (kbd "C-c m r") 'media-rewind)

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
	  lisp-interaction-mode
	  ielm-mode
	  lisp-mode
	  eval-expression-minibuffer-setup) . paredit-mode))


(use-package recentf
  :ensure t
  :config
  (setq recentf-save-file (expand-file-name "recentf" kristian-savefile-dir)
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (recentf-mode +1))

(use-package cyberpunk-theme
  :ensure t)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))


(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))


;; ivy
(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind ("C-c C-r" . ivy-resume)
  :config
  (ivy-mode 1))


(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("<f1> f" . counsel-describe-function)
	 ("<f1> v" . counsel-describe-variable)
	 ("<f1> l" . counsel-find-library)
	 ("<f2> i" . counsel-info-lookup-symbol)
	 ("<f2> u" . counsel-unicode-char)
	 ("C-c g" . counsel-git)
	 ("C-c j" . counsel-git-grep)
	 ("C-c k" . counsel-ag)
	 ("C-c r" . counsel-recentf)
	 ("C-x l" . counsel-locate))
  :config
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))


;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-mode-line
	'(:eval (format " [%s]" (projectile-project-name))))
  (setq projectile-remember-window-configs t)
  (setq projectile-completion-system 'ivy))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (projectile counsel ivy diminish use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
