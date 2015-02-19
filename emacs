;;; package --- Summary
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/")

;;; emacs core settings
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(column-number-mode)
(windmove-default-keybindings)

;;; Theme
(load-theme 'zenburn t)

;;; Packages and their settings
(require 'evil)
(evil-mode 1)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(require 'autopair)
(autopair-global-mode)

(elpy-enable)

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(require 'projectile)
(projectile-global-mode)

(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'column-marker)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 79)))

;;; Coding and code cleanup
(electric-indent-mode 1)
;;; Indentation for python

;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'set-newline-and-indent)

(show-paren-mode)
(setq-default tab-width 4)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key (kbd "M-j")
	(lambda ()
		(interactive)
		(join-line -1)))

;;; (require 'js2-mode)
;;; (add-hook 'js-mode-hook 'js2-minor-mode)
;;; (add-hook 'js2-mode-hook 'ac-js2-mode)
;;; (setq js2-highlight-level 3)
;;; (define-key js-mode-map "{" 'paredit-open-curly)
;;; (define-key js-mode-map "}" 'paredit-close-curly-and-newline)


(byte-recompile-directory "~/.emacs.d" 0)




;;; (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;;; (add-hook 'message-mode-hook 'turn-on-flyspell)
;;; (add-hook 'text-mode-hook 'turn-on-flyspell)
;;; (add-hook 'python-mode-hook 'flyspell-prog-mode)
;;; (defun turn-on-flyspell ()
;;;   "Force flyspell-mode on using a positive arg.  For use in hooks."
;;;   (interactive)
;;;   (flyspell-mode 1))
;;; (add-hook 'js-mode-hook
;;; (lambda () (flycheck-mode t)))
;;; (setq flycheck-highlighting-mode 'lines)




(provide '.emacs)
;;; .emacs ends here
