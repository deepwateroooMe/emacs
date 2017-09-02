;;; original came from https://github.com/redguardtoo/emacs.d

;; -*- coding: utf-8 -*-
;(defvar best-gc-cons-threshold gc-cons-threshold "Best default gc threshold value. Should't be too big.")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)


;(setq default-directory "~/sp-infra-tools/spanda/tools/")
(setq default-directory "~/.emacs.d/elpa/yasnippet-0.12.1/snippets/swift-mode/")
;(setq default-directory "~/")

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))


;;;自动补全
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/auto-complete-1.4"))
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 3) ;; 输入4个字符才开始补全
(global-set-key "\M-/" 'auto-complete)  ;; 补全的快捷键，用于需要提前补全
;;; Show menu 0.8 second later
(setq ac-auto-show-menu 0.2)
;; 选择菜单项的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; menu设置为12 lines
(setq ac-menu-height 12)


;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *wind64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

(setq *emacs24old*  (or (and (= emacs-major-version 24) (= emacs-minor-version 3))
                        (not *emacs24*)))

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))



;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let ((file-name-handler-alist nil))
  (require 'init-autoload)  ;; too many, commented this one out
  (require 'init-modeline)
  ;; (require 'cl-lib) ; it's built in since Emacs v24.3
  (require 'init-compat)
  (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
  (require 'init-utils) ; (defun is-buffer-file-temp())   ;;;;;;; comment for temp only, debug later today

  ;; Windows configuration, assuming that cygwin is installed at "c:/cygwin"
  ;; (condition-case nil
  ;;     (when *win64*
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
  ;; any file use flyspell should be initialized after init-spelling.el
  ;; actually, I don't know which major-mode use flyspell.
  (require 'init-spelling)
  (require 'init-gui-frames)
  (require 'init-ido)
  (require 'init-dired)
  (require 'init-uniquify)
  (require 'init-ibuffer)
;  (require 'init-ivy) ; don't like the swiper from this mode
  (require 'init-hippie-expand)
  (require 'init-windows)
  (require 'init-sessions)
  (require 'init-git)
  (require 'init-crontab)
  (require 'init-markdown)
  (require 'init-erlang)
  (require 'init-javascript)
  (require 'init-org)
  (require 'init-css)
  (require 'init-python-mode)
  (require 'init-csharp-mode)
  (require 'init-java-mode)
  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)

  (require 'init-yasnippet)
  (setq yas/trigger-key (kbd "TAB"))
  (setq yas/prompt-functions
     '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
  (yas/global-mode 1)
  (yas-global-mode 1)

  (require 'cpputils-cmake) ; to do more work on this one
  ;; Use bookmark instead
  (require 'init-cc-mode)
  (require 'init-gud)
  (require 'init-linum-mode)
  (require 'init-moz)
  (require 'init-gtags)
  ;; init-evil dependent on init-clipboard
  (require 'init-clipboard)
  ;; use evil mode (vi key binding)
;  (require 'init-evil)
  (require 'init-multiple-cursors)
  (require 'init-sh)
  (require 'init-ctags)
  (require 'init-bbdb)
  (require 'init-gnus)
  (require 'init-lua-mode)
  (require 'init-workgroups2)
  (require 'init-term-mode)
  (require 'init-web-mode)
  (require 'init-slime)
  (require 'init-company)
  
  ;; need statistics of keyfreq asap
  (require 'init-keyfreq)
  ;; projectile costs 7% startup time
  ;; misc has some crucial tools I need immediately
  (require 'init-misc)
  ;; comment below line if you want to setup color theme in your own way
;  (if (or (display-graphic-p) (string-match-p "256color"(getenv "TERM"))) (require 'init-color-theme)) ; don't like
;  (require 'init-emacs-w3m) ; don't like the interface
  (require 'init-hydra)
  (require 'swift-mode)
  
  ;;; {{ idle require other stuff
;  (setq idle-require-idle-delay 2)
; (setq idle-require-symbols '(init-perforce
;                               init-misc-lazy
;                               init-which-func
;                               init-fonts
;                               init-hs-minor-mode
;                               init-writting
;                               init-pomodoro
;                               init-artbollocks-mode
;                               init-semantic))
;  (idle-require-mode 1) ;; starts loading
  ;;;; }}

                                        ; I commemted here  
                                        ;  (when (require 'time-date nil t)
                                        ;    (message "Emacs startup time: %d seconds."
                                        ;             (time-to-seconds (time-since emacs-load-start-time))))

  ;; my personal setup, other major-mode specific setup need it.
  ;; It's dependent on init-site-lisp.el
;  (if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))
  )


;;; setup defaults for all modes
(setq default-frame-alist
      '((top . 0)(left . 500)(height . 74)(width . 120)(menubar-lines . 20)(tool-bar-line . 0)))


;;; autorevert buffer
(require 'autorevert)
(global-auto-revert-mode 1)


;;; 设置字体
(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "SimSun"))
					;(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "STSong"))
					;让Emacs在保存时自动清除行尾空格及文件结尾空行
					;(add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; don't like, especially for org-mode

;;;auto indent yank
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))


;;; delete backward one char
(global-set-key [(control h)] 'delete-backward-char)
;;; prohibit auto-generate backup files
(setq-default make-backup-files nil)

;;; show line number
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/")) ;拓展文件(插件)目录
(autoload 'linum "linum" nil t)
(require 'linum)
(global-linum-mode 1)

;;; no startup buffer
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
;;; frame titile file name
(setq use-file-dialog nil
      frame-title-format '(buffer-file-name "%b"))
(setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题

;;设置括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;; 设置默认tab宽度为4
(setq tab-width 4
      indent-tabs-mode t
      c-basic-offset 4)

;;; 设定行距
(setq default-line-spacing 1)
;;; 开启语法高亮
(global-font-lock-mode 1)
;;; 高亮显示区域选择
(transient-mark-mode t)
;;; 将yes/no替换为y/n
(fset 'yes-or-no-p 'y-or-n-p)
;;; 显示列号
(column-number-mode t)
;;; 闪屏报警
(setq visible-bell t)
;;; 锁定行高
(setq resize-mini-windows nil)
;;; 递妆mimibuffer
(setq enable-recursive-minibuffers t)

(show-paren-mode t);显示括号匹配
(setq show-paren-mode t) ;;打开括号匹配显示模式
(setq show-paren-style 'parenthesis)


;;;; for latex-mode
(add-to-list 'ac-modes 'latex-mode)
(add-to-list 'ac-modes 'csharp-mode) ;;; csharp-mode
;(add-to-list 'ac-modes 'racket-mode) ;;; csharp-mode
(add-to-list 'ac-modes 'python-mode) 

(defun ac-latex-mode-setup()
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)


(add-to-list 'load-path "~/.emacs.d/wubi")
(require 'wubi)
(wubi-load-local-phrases) ; add user's Wubi phrases
(register-input-method
 "chinese-wubi" "Chinese-GB" 'quail-use-package
 "WuBi" "WuBi"
 "wubi")
(if (< emacs-major-version 21)
    (setup-chinese-gb-environment)
  (set-language-environment 'Chinese-GB))
(setq default-input-method "chinese-wubi")

;;; key bindings of WuBi
(global-set-key [?\C-+] 'add-wubi)
(global-set-key [?\C--] 'del-wubi)
(global-set-key "\M- " 'toggle-input-method)


;;; meta
(global-set-key "\M-l" 'replace-string) ; originally lowercase folling word
(global-set-key "\M-g" 'goto-line)
(setq c-brace-imaginary-offset 1)


(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
;(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only, uncommented this one for temp
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)

;(setq desktop-restore-frames nil)


;;;auto indent yank
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))


;;; delete backward one char
(global-set-key [(control h)] 'delete-backward-char)
;;; prohibit auto-generate backup files
(setq-default make-backup-files nil)


(require 'autopair)
(defun turn-on-autopair-mode () (autopair-mode 1))

; turn off auto-pair for these modes
(setq autopair-global-modes
      '(not
        ;eshell-mode comint-mode erc-mode gud-mode rcirc-mode ; later on examples
        swift-mode))

;(autopair-global-mode) ;; enable autopair in all buffers
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; 只高亮括号


;(require 'expand-region) 
(require 'ido-ubiquitous)
(require 'undo-tree)
(global-undo-tree-mode)

;;; require ido-ubiquitous
(require 'ido)
(require 'ido-ubiquitous) ; replaces ido-everywhere

;;; ido-mode
(ido-mode t)

;;;; flx-ido
;(require 'flx-ido)
;(flx-ido-mode t)
;;; disable ido faces to see flx highlights.
;(setq ido-use-faces nil)
;;; increase garbage collection threshold
;(setq gc-cons-threshold 20000000)


;;; org-mode auto complete
(require 'org-ac)
(org-ac/config-default)


;;; check for spelling
(setq-default ispell-program-name "aspell")
(setq text-mode-hook '(lambda()
			(flyspell-mode t)))
(setq org-mode-hook '(lambda()
			(flyspell-mode t)))


(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary, in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t));;; 1)
;(setq soft-wrap-lines t) ;; for chinese
;(setq debug-on-error t)


;;; for sr-speedbar
(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/sr-speedbar-20141004.532") load-path))
(require 'sr-speedbar)
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用
(global-set-key [(f5)] 'speedbar-get-focus)
(speedbar 1)
;;; ### Speedbar ###
;;; --- 资源管理器
(setq speedbar-show-unknown-files t)    ;显示文件


;;; try to exchange windows & Alt keys in windows keyboard
;(setq mac-option-key-is-meta nil)
;(setq mac-command-key-is-meta t)
;(setq mac-command-modifier 'meta)
;(setq mac-option-modifier nil)


(put 'downcase-region 'disabled nil)


(fset 'one
      [?\C-a ?\C-e ?\C-  ?\C-n ?\C-a ?\M-f ?\M-b ?\C-w ?  ?\C-e ?\C-  ?\C-n ?\C-b ?\C-w ?  ?\C-n ?\C-a ?\C-k])
(global-set-key (kbd "C-c o") 'one)
(put 'one 'kmacro t)


;;; for formating files when copying codes from online or somewhere which format I don't like
(fset 'ta   ;;; C-i to be " & "  tab
   [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-i return ?  ?& ?  return])

(fset 'fo   ;;; same short no C-i
   [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-j ?\{ ?  ?  ?\C-q ?\C-j return ?\{ ?\C-q ?\C-j return])
(fset 'fom  ;;; { to be inline
   [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-j ?\C-q ?\C-i ?\{ ?\C-q ?\C-j return ?  ?\{ ?\C-q ?\C-j return])
;(fset 'el   ;;; same short no C-i
;   [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-j ?\} ?  ?  ?\C-q ?\C-j ?e ?l ?s ?e ?  ?  ?\C-q ?\C-j ?\{ ?  ?  ?\C-q ?\C-j return ?\C-q ?\C-j ?\} ?  ?e ?l ?s ?e ?  ?\{ ?\C-q ?\C-j return])
(fset 'el
   "\C-n\C-k\C-p\C-e\C-y\C-n\C-n\C-b\C-b\C-k\C-p\C-p\C-e\C-y\C-k\C-k\C-n\C-n\C-a")

(fset 'fn
   [?\M-p ?\C-q ?\C-j ?\{ return ?  ?\{ return])
(fset 'nd
   "\C-e|\C-n\C-e")

(fset 'lc ;;; c++ header for leetcode problems
      [?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?i ?o ?s ?t ?r ?e ?a ?m ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?v ?e ?c ?t ?o ?r ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?s ?t ?a ?c ?k ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?q ?u ?e ?u ?e ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?c ?m ?a ?t ?h ?> return ?u ?s ?i ?n ?g ?  ?n ?a ?m ?e ?s ?p ?a ?c ?e ?  ?s ?t ?d ?\; return return return return ?i ?n ?t ?  ?m ?a ?i ?n ?\( ?\) ?  backspace ?\{ return return return ?r ?e ?t ?u ?r ?n ?  ?0 ?\; return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p])

(fset 'st
   [?\C-  ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\M-p ?* return return ?\C-p ?\C-p])

(fset 'fo
   [?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return])
(fset 'f
   [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h tab ?\C-  ?\C-  ?\C-v])
(global-set-key (kbd "C-c f") 'f) ; very useful
(put 'f 'kmacro t)

;;; don't really remember what I were doing here
(fset 'tw
   "- ")
(fset 'on
   "   ")
(fset 'fu
   [?\M-x ?t ?w ?\C-p ?\M-x ?o ?n return ?\C-p ?\M-x ?o ?n])


;; @see https://www.reddit.com/r/emacs/comments/4q4ixw/how_to_forbid_emacs_to_touch_configuration_files/
;(setq custom-file (concat user-emacs-directory "custom-set-variables.el"))
;(load custom-file 'noerror)

;(setq gc-cons-threshold best-gc-cons-threshold)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(package-selected-packages
   (quote
    (flycheck-swift3 flycheck-swift flycheck swift3-mode swift-mode yaml-mode writeroom-mode workgroups2 wgrep web-mode w3m unfill tidy textile-mode tagedit sr-speedbar smex simple-httpd session scss-mode scratch rvm ruby-compilation robe rjsx-mode request regex-tool rainbow-delimiters quack pyim pomodoro paredit page-break-lines package-lint nvm neotree mwe-log-commands multi-term move-text markdown-mode lua-mode link less-css-mode legalese jump js-doc iedit idomenu ibuffer-vc hydra htmlize hl-sexp haskell-mode haml-mode groovy-mode gitignore-mode gitconfig-mode git-timemachine git-link gist fringe-helper flyspell-lazy flymake-ruby flymake-lua flymake-jslint flymake-css flx-ido find-by-pinyin-dired expand-region exec-path-from-shell erlang emms emmet-mode elpy dumb-jump dsvn dropdown-list dired+ diminish dictionary define-word csharp-mode crontab-mode cpputils-cmake counsel-gtags counsel-bbdb connection company-c-headers color-theme cmake-mode cliphist buffer-move bookmark+ bbdb auto-yasnippet auto-complete auto-compile ace-window ace-mc ace-link)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
	;;; Local Variables:
;;; no-byte-compile: t
;;; End:
;(put 'erase-buffer 'disabled nil)
