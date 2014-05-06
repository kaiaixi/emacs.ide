;;Key Bindings
;;;;iedit-mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)
;;;;hsmode
(define-key global-map (kbd "C-c '") 'hs-toggle-hiding)

;;;;xcscope
(define-key global-map [(super f3)]  'cscope-set-initial-directory)
(define-key global-map [(super f4)]  'cscope-unset-initial-directory)
(define-key global-map [(super f5)]  'cscope-find-this-symbol)
(define-key global-map [(super f6)]  'cscope-find-global-definition)
(define-key global-map [(super f7)]
        'cscope-find-global-definition-no-prompting)
(define-key global-map [(super f8)]  'cscope-pop-mark)
(define-key global-map [(super f9)]  'cscope-history-forward-line)
(define-key global-map [(super f10)] 'cscope-history-forward-file)
(define-key global-map [(super f11)] 'cscope-history-backward-line)
(define-key global-map [(super f12)] 'cscope-history-backward-file)
(define-key global-map [(meta f9)]  'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)
(define-key global-map [(meta f11)] 'cscope-find-this-file)
(define-key global-map [(meta f12)] 'cscope-find-files-including-file)

;;;;Ctrl + c + a 
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
             char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'wy-go-to-char)

;;;; Jump windows
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;;;; ECB Display
(define-key global-map [(super f1)] 'ecb-activate)
(define-key global-map [(super f2)] 'ecb-deactivate)

;;initalization

;;;;my own c-mode-common-hook
(defun my:c-mode-common-hook()
  (highlight-indentation-mode)
  (setq tab-width 4 indent-tabs-mode nil)
  (setq tab-stop-list (number-sequence 4 200 4))
)
(add-hook 'c-mode-common-hook 'my:c-mode-common-hook)

;;;; Max Window
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

;;;; no startup msg  
(setq inhibit-startup-message t)

;;;; no tools bar
(tool-bar-mode -1)

;;;; Line Number 
(global-linum-mode t)

;;;; 80 columns
(setq default-fill-column 80)

;;;; TAB = 4 Spaces
(setq default-tab-width 4)


;; Package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; Auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
)

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;;Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;iedit
;;(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;flymake-google-init
(defun my:flymake-google-init () 
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; google-c-style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
(global-semantic-idle-scheduler-mode 1)
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic-raw)
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

(global-ede-mode 1)
; create a project for our program.
(ede-cpp-root-project "my project" :file "~/Dropbox/Source/freebsd_sctp/sys/netinet/sctp_output.c"
		      :include-path '("/"))
; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

;;function-args
(require 'function-args)
(fa-config-default)

;;cscope
(require 'xcscope)
(cscope-setup)

;;ecb
(require 'ecb)
(setq ecb-tip-of-the-day nil)

;;color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-robin-hood)

;; hsmode
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'ess-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

;;highlight-inidentatioon
(require 'highlight-indentation)
















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-windows-width 0.18)
 '(flymake-google-cpplint-command "/usr/bin/cpplint"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
