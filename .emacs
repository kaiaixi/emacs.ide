;;;; CC-mode配置  http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;Line Number 
(global-linum-mode t)

;; xcscope(setq cscope-do-not-update-database t)
(add-to-list 'load-path "/home/niuroy/.emacs.d/xcscope/")
(require 'xcscope)
(cscope-setup)
(setq cscope-do-not-update-database t)
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]     'cscope-display-buffer)
(define-key global-map [(meta f10)]    'cscope-display-buffer-toggle)

;;;;我的C/C++语言编辑策略

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
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
(color-theme-robin-hood)

(add-to-list 'load-path "~/.emacs.d/ecb-2.40/")

;;(require 'ecb)
(setq stack-trace-on-error t)
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(global-set-key [f12] 'ecb-activate)
(global-set-key [f11] 'ecb-deactivate)

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
 '(ecb-source-path (quote ("./"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
