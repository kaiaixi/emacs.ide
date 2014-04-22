;;;; CC-mode配置  http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;Max Window
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

;; no startup msg  
(setq inhibit-startup-message t)

;; no tools bar
(tool-bar-mode -1)

;;Line Number 
(global-linum-mode t)

;; 80 columns
(setq default-fill-column 80)

;; TAB = 4 Spaces
(setq default-tab-width 4)

;;Hide - Show
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'ess-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(global-set-key [f8] 'hs-toggle-hiding)

;; Go - to - char
;; go-to-char 非常感谢 Oliver Scholz 提供这个函数给 我。
;;这个函数是一个 vi 的 "f" 命令的替代品。vi的用户知道，vi有 一个特别好的命令 "f"。当你按 "fx", x 是任意一个字符时
;;光标 就会移动到下一个 "x" 处。这之后只要按 ";"(分号)，光标就到再 下一个 "x"。
;;举个例子说明这个命令的用途。比如我们有这样一行字，光标在 行首。
;;(setq unread-command-events (list last-input-event)))
;;                                             ^^^^^
;;我们希望迅速的到达最后那个 event 处，于是我在 vi 里按 "fe"。结果光标到了 "setq" 的那个 e 上面，这时候我接着按 ";",
;;不一会儿就到了我们想要的地方。很方便吧？可能起初不觉得，后来 你发现这真的非常好！

;;我一直觉得 Emacs 没有这样一个方便的命令，但是 Oliver 给了 我一个完美的答案：
;;有了这段代码之后，当你按 C-c a x (x 是任意一个字符) 时，光 标就会到下一个 x 处。再次按 x，光标就到下一个 x。比如 C-c a w w w w ..., C-c a b b b b b b ...
;;我觉得这个方式比 vi 的 "f" 要快。
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
;; Indent Line
(add-to-list 'load-path "~/.emacs.d/Highlight-Indentation-for-Emacs/")
(require 'highlight-indentation)






;; xcscope(setq cscope-do-not-update-database t)
(add-to-list 'load-path "~/.emacs.d/xcscope/")
(require 'xcscope)
(cscope-setup)
(setq cscope-do-not-update-database t)

(defun hide-cscope-buffer ()
  "Turn off the display of cscope buffer"
   (interactive)
   (if (not cscope-display-cscope-buffer)
       (progn
         (set-variable 'cscope-display-cscope-buffer t)
         (message "Turning ON display of cscope results buffer."))
     (set-variable 'cscope-display-cscope-buffer nil)
     (message "Toggling OFF display of cscope results buffer.")))

;(global-set-key [f8]  'cscope-set-initial-directory)
;(global-set-key [f9] 'cscope-find-this-symbol)
;(global-set-key [f10] 'cscope-find-global-definition-no-prompting)
;(global-set-key [f11] 'cscope-find-functions-calling-this-function)
;(global-set-key [f12] 'cscope-find-this-file)
;(global-set-key (kbd "C-t") 'cscope-pop-mark)
;(global-set-key (kbd "C-n") 'cscope-history-forward-line)
;(global-set-key (kbd "C-p") 'cscope-history-backward-line)
;(global-set-key (kbd "C-b") 'hide-cscope-buffer)
;(global-set-key [s-f7] 'cscope-history-forward-file
;(global-set-key [s-f8] 'cscope-history-backward-file)
;(global-set-key [s-f9] 'cscope-find-this-text-string)
;(global-set-key [s-f10] 'cscope-find-global-definition)
;(global-set-key [s-f11] 'cscope-find-egrep-pattern)
;(global-set-key [s-f12] 'cscope-find-files-including-file)
;(global-set-key [meta f9]  'cscope-display-buffer)
;(global-set-key [meta f10] 'cscope-display-buffer-toggle)
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




;;;;我的C/C++语言编辑策略

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (highlight-indentation-mode)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)

  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "stroustrup")
;;  (define-key c++-mode-map [f3] 'replace-regexp)
)
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/common/")
(require 'cedet)
(require 'semantic-gcc)
(require 'semantic-ia)
(require 'semantic-gcc)
(global-semantic-idle-scheduler-mode 1) ;The idle scheduler with automatically reparse buffers in idle time.
(global-semantic-idle-completions-mode 1) ;Display a tooltip with a list of possible completions near the cursor.
(global-semantic-idle-summary-mode 1) ;Display a tag summary of the lexical token under the cursor.

(setq semanticdb-project-roots 
      (list
        (expand-file-name "/")))

(defun my-indent-or-complete ()
   (interactive)
   (if (looking-at "\\>")
      (hippie-expand nil)
      (indent-for-tab-command))
 )

(global-set-key [(control tab)] 'my-indent-or-complete)

(autoload 'senator-try-expand-semantic "senator")

(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
)

(global-set-key [(f5)] 'speedbar)

(define-key c-mode-base-map [(f7)] 'compile)
'(compile-command "make")

;; Color Theme
;;(load-file "~/.emacs.d/color-theme-6.6.0/color-theme.el")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-robin-hood)
(load "~/.emacs.d/color-theme-molokai/color-theme-molokai.el")
(color-theme-molokai)

(add-to-list 'load-path "~/.emacs.d/ecb-2.40/")

;;(require 'ecb)
(setq stack-trace-on-error t)
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(global-set-key [f6] 'ecb-activate)
(global-set-key [f7] 'ecb-deactivate)

;;;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;;;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;;;; 使某一ecb窗口最大化
(define-key global-map "\C-c1" 'ecb-maximize-window-directories)
(define-key global-map "\C-c2" 'ecb-maximize-window-sources)
(define-key global-map "\C-c3" 'ecb-maximize-window-methods)
(define-key global-map "\C-c4" 'ecb-maximize-window-history)
;;;; 恢复原始窗口布局
(define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-auto-expand-tag-tree (quote all))
 '(ecb-auto-expand-tag-tree-collapse-other (quote always))
 '(ecb-auto-update-methods-after-save t)
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("./")))
 '(ecb-windows-width 0.25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/git-modes")
(add-to-list 'load-path "~/.emacs.d/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/.emacs.d/magit/")))
(require 'magit)
