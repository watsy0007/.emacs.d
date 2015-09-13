
;; -*- coding: utf-8 -*-
(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/custom"))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(load "alpha-window.el")
(global-set-key [(f9)] 'loop-alpha)

(set-default-font "Consolas 14")
;;(set-frame-parameter (selected-frame) 'alpha '(100 35))
;;(add-to-list 'default-frame-alist '(alpha 85 85))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;;----------------------------------------------------------------------------
;; Less GC, more memory
;;----------------------------------------------------------------------------
(defun my-optimize-gc (NUM PER)
"By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
@see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
We increase this to 16MB by `(my-optimize-gc 16 0.5)` "
  (setq-default gc-cons-threshold (* 1024 1024 NUM)
                gc-cons-percentage PER))


(require 'init-modeline)
(require 'cl-lib)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

;; win32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
;; (condition-case nil
;;     (when *win32*
;;       ;; (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
;;       (setq cygwin-mount-cygwin-bin-directory "c:/cygwin64/bin")
;;       (require 'setup-cygwin)
;;       ;; better to set HOME env in GUI
;;       ;; (setenv "HOME" "c:/cygwin/home/someuser")
;;       )
;;   (error
;;    (message "setup-cygwin failed, continue anyway")
;;    ))

(require 'idle-require)
(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)
;; any file use flyspell should be initialized after init-spelling.el
;; actually, I don't know which major-mode use flyspell.
(require 'init-spelling)
(require 'init-xterm)
(require 'init-gui-frames)
(require 'init-ido)
(require 'init-dired)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flymake)
(require 'init-smex)
(require 'init-helm)
(require 'init-hippie-expand)
(require 'init-windows)
(require 'init-sessions)
(require 'init-git)
(require 'init-crontab)
(require 'init-markdown)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-org)
(require 'init-org-mime)
(require 'init-css)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ruby-mode)
(require 'init-lisp)
(require 'init-elisp)
(require 'init-yasnippet)
;; Use bookmark instead
(require 'init-zencoding-mode)
(require 'init-cc-mode)
(require 'init-gud)
(require 'init-linum-mode)
;; (require 'init-gist)
(require 'init-moz)
(require 'init-gtags)
;; use evil mode (vi key binding)
(require 'init-evil)
(require 'init-sh)
(require 'init-ctags)
(require 'init-bbdb)
(require 'init-gnus)
(require 'init-lua-mode)
(require 'init-workgroups2)
(require 'init-term-mode)
(require 'init-web-mode)
(require 'init-slime)
(require 'init-clipboard)
(require 'init-company)
(require 'init-chinese-pyim) ;; cannot be idle-required
;; need statistics of keyfreq asap
(require 'init-keyfreq)
(require 'init-httpd)

;; projectile costs 7% startup time

;; misc has some crucial tools I need immediately
(require 'init-misc)
(require 'init-color-theme)
(require 'init-emacs-w3m)
(load "init-custom-ruby")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.5.1/elpa/auto-complete-1.5.0/dict/")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

;;ag
(add-to-list 'load-path "/Users/watsy/.emacs.d/github/ag.el/ag.el")
(require 'ag)

;;(require 'smartparens-config)
;;(require 'smartparens-ruby)
;;(smartparens-global-mode)
;;(show-smartparens-global-mode t)

(add-to-list 'load-path "/Users/watsy/.emacs.d/github/grizzl")
(load "grizzl")
(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

;; highlight
(add-to-list 'load-path "~/.emacs.d/github/Highlight-Indentation-for-Emacs")
(load "highlight-indentation")
(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
	              (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'coffee-mode-hook
	              (lambda () (highlight-indentation-current-column-mode)))

;; Dash at point
(add-to-list 'load-path "~/.emacs.d/github/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
	  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)
(add-hook 'rinari-minor-mode-hook
	            (lambda () (setq dash-at-point-docset "rails")))

;; load rvm
(add-to-list 'load-path "~/.emacs/github/rvm.el/rvm.el")
(require 'rvm)
(rvm-use-default)

;; yasnippet
(add-to-list 'load-path
	                   "~/.emacs.d/github/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; rinari rails mode
(add-to-list 'load-path "~/.emacs.d/github/rinari")
(require 'rinari)

;; map command to meta key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(eval-after-load 'enh-ruby-mode
		  '(remove-hook 'enh-ruby-mode-hook 'erm-define-faces))

;; ess 
(add-to-list 'load-path "~/.emacs.d/custom/ess-15.03-1/lisp")
(require 'ess-site)

;; markdown
(custom-set-variables
   '(markdown-command "/usr/local/bin/pandoc"))
(add-to-list 'load-path "~/.emacs.d/github/markdown-mode")
(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
	     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;neo tree
(add-to-list 'load-path "~/.emacs.d/github/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq projectile-switch-project-action 'neotree-projectile-action)

;; {{ idle require other stuff
(setq idle-require-idle-delay 3)
(setq idle-require-symbols '(init-misc-lazy
                             init-which-func
                             init-fonts
                             init-hs-minor-mode
                             init-stripe-buffer
                             init-textile
                             init-csv
                             init-writting
                             init-doxygen
                             init-pomodoro
                             init-emacspeak
                             init-artbollocks-mode
                             init-semantic))
(idle-require-mode 1) ;; starts loading
;; }}

(when (require 'time-date nil t)
   (message "Emacs startup time: %d seconds."
    (time-to-seconds (time-since emacs-load-start-time))))

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

;; my personal setup, other major-mode specific setup need it.
;; It's dependent on init-site-lisp.el
(if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
