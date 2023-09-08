
;; original: https://github.com/redguardtoo/emacs.d/blob/903aeb10c316c0f43b35bc0dc6101eea3f729da7/init-auto-complete.el
;; @see http://cx4a.org/software/auto-complete/manual.html

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
                                        ;(global-auto-complete-mode t)
                                        ;(setq ac-expand-on-auto-complete nil)
                                        ;(setq ac-auto-start nil)
(setq ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed
                                        ;(ac-set-trigger-key "TAB") ; AFTER input prefix, press TAB key ASAP

;;; 使用增强列表
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/auto-complete-1.4"))
;(require 'pos-tip)
;(setq ac-quick-help-prefer-pos-tip t)
;;添加backspac触发列表
;(setq ac-trigger-commands
;      (cons 'backward-delete-char-untabify ac-trigger-commands))

(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 3) ;; 输入4个字符才开始补全
(global-set-key "\M-/" 'auto-complete)  ;; "\M-/" 补全的快捷键，用于需要提前补全
;;; Show menu 0.8 second later
(setq ac-auto-show-menu 0.1) ;;; 0.1
;; 选择菜单项的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; menu设置为12 lines
(setq ac-menu-height 12)



(setq ac-disable-faces nil) ;;;; to be able to autocomplete in String and commends

(global-auto-complete-mode t)
;; extra modes auto-complete must support

;; (auto-completion :variables auto-completion-enable-sort-by-usage t
;;                  auto-completion-enable-snippets-in-popup t)
;;                  ;; :disabled-for org markdown)

(dolist (mode '(csharp-mode kotlin-mode java-mode python-mode swift-mode emacs-lisp-mode org-mode web-mode groovy-mode xml-mode nxml-mode 
                          magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode latex-mode
                          sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                          html-mode web-mode sh-mode smarty-mode clojure-mode
                          lisp-mode textile-mode markdown-mode tuareg-mode asm-mode ld-script ld-script-mode
                          js2-mode css-mode less-css-mode))
  (add-to-list 'ac-modes mode))

(setq completion-at-point-functions '(elisp-completion-at-point comint-dynamic-complete-filename t))

;;开启ac-dwin
;(setq ac-dwim t)
;;设置ac数据文件位置
;;;(setq ac-comphist-file (expand-file-name "ac-comphist/ac-comphist.dat" prelude-savefile-dir))
;;;(check-temp-dir (expand-file-name "ac-comphist/" prelude-savefile-dir))
;;添加ac补全源
;(set-default 'ac-sources
;             '(ac-source-semantic ;;ac使用semantic的分析结果
;               ac-source-yasnippet
;               ac-source-abbrev
;               ac-source-words-in-buffer
;               ac-source-words-in-all-buffer
;               ac-source-imenu
;               ac-source-files-in-current-dir
;               ac-source-filename))


;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)

;; clang stuff
;; @see https://github.com/brianjcj/auto-complete-clang
(defun my-ac-cc-mode-setup ()
  (require 'auto-complete-clang)
  (when (and (not *cygwin*) (not *win32*))
                                        ; I don't do C++ stuff with cygwin+clang
    (setq ac-sources (append '(ac-source-clang) ac-sources))
    )
  (setq clang-include-dir-str
        (cond
         (*is-a-mac* "
/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include
/usr/include/c++/4.2.1
/usr/include/c++/4.2.1/backward
/usr/local/include
/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include
/usr/include
")
         (*cygwin* "
/usr/lib/gcc/i686-pc-cygwin/3.4.4/include/c++/i686-pc-cygwin
/usr/lib/gcc/i686-pc-cygwin/3.4.4/include/c++/backward
/usr/local/include
/usr/lib/gcc/i686-pc-cygwin/3.4.4/include
/usr/include
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api
")
         (*linux* "
/usr/include
/usr/lib/wx/include/gtk2-unicode-release-2.8
/usr/include/wx-2.8
/usr/include/gtk-2.0
/usr/lib/gtk-2.0/include
/usr/include/atk-1.0
/usr/include/cairo
/usr/include/gdk-pixbuf-2.0
/usr/include/pango-1.0
/usr/include/glib-2.0
/usr/lib/glib-2.0/include
/usr/include/pixman-1
/usr/include/freetype2
/usr/include/libpng14
")
         (t "") ; other platforms
         )
        )
  (setq ac-clang-flags
        (mapcar (lambda (item) (concat "-I" item))
                (split-string clang-include-dir-str)))

  (cppcm-reload-all)
                                        ; fixed rinari's bug
  (remove-hook 'find-file-hook 'rinari-launch)

  (setq ac-clang-auto-save t)
  )

;;; 我把它comment掉了 22-01-29
;; (add-hook 'c-mode-hook 'my-ac-cc-mode-setup)
;; (add-hook 'c++-mode-hook 'my-ac-cc-mode-setup)

(ac-config-default)

(provide 'init-auto-complete)