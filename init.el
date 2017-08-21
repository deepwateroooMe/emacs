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

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;(setq default-directory "~/sp-infra-tools/spanda/tools/")
(setq default-directory "~/.emacs.d/")

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
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


;;; setup defaults for all modes

(setq default-frame-alist
      '((top . 0)(left . 500)(height . 74)(width . 120)(menubar-lines . 20)(tool-bar-line . 0)))
					; for laptop only
					;      '((top . 0)(left . 360)(height . 48)(width . 120)(menubar-lines . 20)(tool-bar-line . 0)))



;;; autopair
(require 'autopair)
(defun turn-on-autopair-mode () (autopair-mode 1))
(autopair-global-mode) ;; enable autopair in all buffers
					;(electric-pair-mode 1) ;;; emacs 24
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; 只高亮括号

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
(add-to-list 'load-path "~/.emacs.d/") ;拓展文件(插件)目录
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

;;; Yasnippet
					;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
					;(require 'yasnippet)
					;(yas--initialize)
					;(yas/load-directory "~/.emacs.d/elpa/yasnippet-0.8.0/snippets")
					;(setq yas/trigger-key (kbd "TAB"))
					;(setq yas/prompt-functions
					;   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
					;(yas/global-mode 1)
					;(yas-global-mode 1)
;;;;;(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;;;自动补全
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
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


;;; for csharp-mode
					;(add-to-list 'load-path "~/.emacs.d/elpa/csharp-mode-20130824.1200") ;拓展文件(插件)目录
					;(require 'csharp-mode)

(add-to-list 'load-path "~/.emacs.d/elpa/csharp-mode") ;拓展文件(插件)目录
(require 'csharp-mode)
;;;for csharp-mode ; {} autoindent
(defun csharp-autoindent ()
  (when (and (eq major-mode 'csharp-mode) (looking-back "[;]"))
    (newline-and-indent)))
(add-hook 'post-self-insert-hook 'csharp-autoindent)
(add-hook 'csharp-mode-hook
	  #'(lambda ()
	      (local-set-key (kbd "{") 'cheeso-insert-open-brace)))

					; work with autopair for {
(defun cheeso-looking-back-at-regexp (regexp)
  "calls backward-sexp and then checks for the regexp.  Returns t if it is found, else nil"
  (interactive "s")
  (save-excursion
    (backward-sexp)
    (looking-at regexp)))

(defun cheeso-looking-back-at-equals-or-array-init ()
  "returns t if an equals or [] is immediate preceding. else nil."
  (interactive)
  (cheeso-looking-back-at-regexp "\\(\\w+\\b *=\\|[[]]+\\)"))  

(defun cheeso-prior-sexp-same-statement-same-line ()
  "returns t if the prior sexp is on the same line. else nil"
  (interactive)
  (save-excursion
    (let ((curline (line-number-at-pos))
          (curpoint (point))
          (aftline (progn
		     (backward-sexp)
		     (line-number-at-pos))) )
      (= curline aftline))))  

(defun cheeso-insert-open-brace ()
  "if point is not within a quoted string literal, insert an open brace, two newlines, and a close brace; indent everything and leave point on the empty line. If point is within a string literal, just insert a pair or braces, and leave point between them."
  (interactive)
  (cond
   ;; are we inside a string literan? 
   ((c-got-face-at (point) c-literal-faces)
    ;; if so, then just insert a pair of braces and put the point between them
    (self-insert-command 1)
    (insert "")) ; this one works great now

   ;; was the last non-space an equals sign? or square brackets?  Then it's an initializer.
   ((cheeso-looking-back-at-equals-or-array-init)
    (self-insert-command 1)
    (insert ";")
    (backward-char 1)) ; this one works great now

   ;; doesn't cooperate well with autopair
   ;; else, it's a new scope., 
   ;; therefore, insert paired braces with an intervening newline, and indent everything appropriately.
   (t
    (if (cheeso-prior-sexp-same-statement-same-line)
	(self-insert-command 1))  ;;; so far only upto here, don't know how to eval & expand {}
    (insert "") 
    (c-indent-line-or-region)
					;   (self-insert-command 1))
					;   (newline-and-indent)
					;   (eval-last-sexp)
					;   (newline-and-indent)
					;   (c-indent-line-or-region)
					;   (previous-line)
    )))


;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let ((file-name-handler-alist nil))
;  (require 'init-autoload)  ;; too many, commented this one out
  (require 'init-modeline)
  ;; (require 'cl-lib) ; it's built in since Emacs v24.3
  (require 'init-compat)
  (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;  (require 'init-utils)

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
;  (require 'init-gui-frames)
  (require 'init-ido)
;  (require 'init-dired)
;  (require 'init-uniquify)
;  (require 'init-ibuffer)
;  (require 'init-ivy)
  (require 'init-hippie-expand)
;  (require 'init-windows)
;  (require 'init-sessions)
  (require 'init-git)
;  (require 'init-crontab)
;  (require 'init-markdown)
;  (require 'init-erlang)
;  (require 'init-javascript)
  (require 'init-org)
;  (require 'init-css)
  (require 'init-python-mode)
;  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)

  (require 'init-yasnippet)
  (setq yas/trigger-key (kbd "TAB"))
  (setq yas/prompt-functions
     '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
  (yas/global-mode 1)
  (yas-global-mode 1)

  ;; Use bookmark instead
  (require 'init-cc-mode)
  (require 'init-gud)
  (require 'init-linum-mode)
;  (require 'init-moz)
;  (require 'init-gtags)
  ;; init-evil dependent on init-clipboard
;  (require 'init-clipboard)
  ;; use evil mode (vi key binding)
;  (require 'init-evil)
;  (require 'init-multiple-cursors)
;  (require 'init-sh)
;  (require 'init-ctags)
;  (require 'init-bbdb)
;  (require 'init-gnus)
;  (require 'init-lua-mode)
;  (require 'init-workgroups2)
;  (require 'init-term-mode)
;  (require 'init-web-mode)
;  (require 'init-slime)
  (require 'init-company)
  ;; need statistics of keyfreq asap
 ; (require 'init-keyfreq)

  ;; projectile costs 7% startup time

  ;; misc has some crucial tools I need immediately
;  (require 'init-misc)

  ;; comment below line if you want to setup color theme in your own way
;  (if (or (display-graphic-p) (string-match-p "256color"(getenv "TERM"))) (require 'init-color-theme))

;  (require 'init-emacs-w3m)
;  (require 'init-hydra)

  ;;; {{ idle require other stuff
;  (setq idle-require-idle-delay 2)
;  (setq idle-require-symbols '(init-perforce
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


;;; meta
(global-set-key "\M-l" 'replace-string) ; originally lowercase folling word
(global-set-key "\M-g" 'goto-line)
(setq c-brace-imaginary-offset 1)

          ;(setq mac-option-key-is-meta nil)
          ;(setq mac-command-key-is-meta t)
          ;(setq mac-command-modifier 'meta)
          ;(setq mac-option-modifier nil)


;(define-key global-map "\C-n" 'next-line)
;(define-key global-map "\C-p" 'previous-line)
;(define-key global-map "\C-f" 'forward-char)
;(define-key global-map "\C-b" 'backward-char)
;(define-key global-map "\M-f" 'forward-word)
;(define-key global-map "\M-b" 'backward-word)



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


;;; for lisp
(fset 'dmut
   "\C-d\C-n")
(fset 'mut
   ";\C-n\C-a")

;;; for python
(fset 'mpy
   [?# ?! ?/ ?u ?s ?r ?/ ?l ?o ?c ?a ?l ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n ?3 return return])
(fset 'apt
   "print \C-n\C-a")
(fset 'dpt
   "\C-d\C-d\C-d\C-d\C-d\C-d\C-n")

(fset 'apf
   "printf(\": %5.8f\\n\",);\C-a\346\C-f\C-f")
(fset 'pf
   "printf(\": %\\n\C-f, \C-f;\C-p\346\C-f\C-f")

(fset 'ait
   "\\item \C-n\C-a")
(fset 'dit
   "\C-d\C-d\C-d\C-d\C-d\C-d\C-n")

(fset 'lst
   [?\\ ?b ?e ?g ?i ?n ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} ?\[ ?l ?a ?n ?g ?u ?a ?g ?e ?= ?c ?+ ?+ ?\] return ?\\ ?e ?n ?d ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} return ?\C-p])

(fset 'num
   [?\\ ?b ?e ?g ?i ?n ?\{ ?e ?n ?u ?m ?e ?r ?a ?t ?e ?\} return ?\\ ?i ?t ?e ?m ?s ?e ?p ?= ?- ?3 ?p ?t return ?\\ ?e ?n ?d ?\{ ?e ?n ?u ?m ?e ?r ?a ?t ?e ?\} ?\C-a])

(fset 'im
   [return up ?\\ ?b ?e ?g ?i ?n ?\{ ?i ?t ?e ?m ?i ?z ?e ?\} return ?\\ ?i ?t ?e ?m ?s ?e ?p ?= ?- ?3 ?p ?t return ?\\ ?e ?n ?d ?\{ ?e backspace ?i ?t ?e ?m ?i ?z ?e ?\} ?\C-a])

(fset 'desc
   [?\\ ?b ?e ?g ?i ?n ?\{ ?d ?e ?s ?c ?r ?i ?p ?t ?i ?o ?n ?\} return ?\\ ?e ?n ?d ?\{ ?d ?e ?s ?c ?r ?i ?p ?t ?o backspace ?i ?o ?n ?\} ?\C-a])

;(fset 'lst
;   [return up ?\\ ?b ?e ?g ?i ?n ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} ?\[ ?l ?a ?n ?g ?u ?a ?g ?e ?= ?C ?+ ?+ backspace backspace backspace ?P ?y ?t ?h ?o ?n ?\] return ?\\ ?e ?n ?d ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} ?\C-a])

(fset 'clst
   [?\\ ?l ?s ?t ?i ?n ?p ?u ?t ?l ?i ?s ?t ?i ?n ?g ?\[ ?l ?a ?n ?g ?u ?a ?g ?e ?= ?c ?+ ?+ ?\] ?\{ ?. ?c ?p ?p ?\} return ?\C-p ?\C-e ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b])

(fset 'tabl
   [return ?\\ ?b ?e ?g ?i ?n ?\{ ?t ?a ?b ?u ?l ?a ?r ?\} ?\{ ?| ?l ?| ?l ?| ?\} return ?\\ ?h ?l ?i ?n ?e return ?\\ ?h ?l ?i ?n ?e return return ?\\ ?h ?l ?i ?n ?e return ?\\ ?h ?l ?i ?n ?e return ?\\ ?e ?n ?d ?\{ ?t ?a ?b ?u ?l ?a ?r ?\} return ?\C-p ?\C-p ?\C-p ?\C-p])

(fset 'mc ;;; multicols 2
   [?\\ ?b ?e ?g ?i ?n ?\{ ?m ?u ?l ?t ?i ?c ?o ?l ?s ?\} ?\{ ?2 ?\} return ?\\ ?e ?n ?d ?\{ ?m ?u ?l ?t ?i ?c ?o ?l ?s ?\} ?\C-a])

(fset 'mulc
   [?\\ ?b ?e ?g ?i ?n ?\{ ?m ?u ?l ?t ?i ?c ?o ?l ?s ?\} ?\{ ?2 ?\} return ?\\ ?e ?n ?d ?\{ ?m ?u ?l ?t ?i ?c ?o ?l ?s ?\} return ?\C-p])

(fset 'gra
   "\\includegraphics{}\C-b")

(fset 'sp  ;;; two beginning spaces
   "  \C-n\C-a")

(fset 'hl  ;;; \hline beginning line
   [?\\ ?h ?l ?i ?n ?e return ?\C-n])

(fset 'end ;;; end of ling \\
   "\\\\\C-n\C-e")

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

(fset 'und  ;;; "_" to be "\_"
   [?\M-x ?r ?e ?p ?l ?  ?s return ?_ return ?\\ ?_ return])
(fset 'itm  ;;; \item{   }
;  "\\item{\C-e}\C-n\C-n\C-a")
   "\\item{\C-e}\C-n\C-a")

(fset 'ss   ;;; subsection{  }
   "\\subsection{\C-e}\C-n\C-a")
(fset 'sss  ;;; subsubsection{  }
   "\\subsubsection{\C-e}\C-n\C-a")

(fset 'cpp  ;;; C++ enter enter enter --> ""
;  [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return return])
   [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j return return])


(fset 'fn
   [?\M-p ?\C-q ?\C-j ?\{ return ?  ?\{ return])
(fset 'nd
   "\C-e|\C-n\C-e")
(fset 'hd
   [?# ?+ ?l ?a ?t ?e ?x ?_ ?c ?l ?a ?s ?s ?: ?  ?c ?n ?- ?a ?r ?t ?i ?c ?l ?e return ?# ?+ ?l ?a ?t ?e ?x ?_ ?h ?e ?a ?d ?e ?r ?: ?  ?\\ ?u ?s ?e ?p ?a ?c ?k ?a ?g ?e ?\{ ?C ?J ?K ?u ?t ?f ?8 ?\} return ?# ?+ ?l ?a ?t ?e ?x ?_ ?h ?e ?a ?d ?e ?r ?: ?  ?\\ ?b ?e ?g ?i ?n ?\{ ?C ?J ?K ?\} ?\{ ?U ?T ?F ?8 ?\} ?\{ ?g ?b ?s ?n ?\} return ?# ?+ ?l ?a ?t ?e ?x ?_ ?h ?e ?a ?d ?e ?r ?: ?\S-  ?\\ ?l ?s ?t ?s ?e ?t ?\{ ?l ?a ?n ?g ?u ?a ?t ?e ?= ?c ?+ ?+ ?, ?n ?u ?m ?b ?e ?r ?s ?= ?l ?e ?f ?t ?, ?n ?u ?m ?b ?e ?r ?s ?t ?y ?l ?e ?= ?\\ ?t ?i ?n ?y ?, ?b ?a ?s ?i ?c ?s ?t ?y ?l ?e ?= ?\\ ?t ?t ?f ?a ?m ?i ?l ?y ?\\ ?s ?m ?a ?l ?l ?, ?t ?a ?b ?s ?i ?z ?e ?= ?4 ?, ?f ?r ?a ?m ?e ?= ?n ?o ?n ?e ?, ?e ?s ?c ?a ?p ?e ?i ?n ?s ?i ?d ?e ?= ?` ?` ?, ?e ?x ?t ?e ?n ?d ?e ?d ?c ?h ?a ?r ?s ?= ?f ?a ?l ?s ?e ?\} return ?# ?+ ?t ?i ?t ?l ?e ?: ? ])
(fset 'cp
   "#+caption: ")

;;; c++ macro
;(fset 'ou
;   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?\" ?\C-f ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\; ?\C-p ?\C-e ?\M-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b])
(fset 'ou
   [?c ?o ?u ?t ?  ?< ?< ?  ?\" ?\C-f ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])

(fset 'ot
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?\" ?: ?  ?\C-f ?  ?< ?< ?  ?< ?< ?  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])

(fset 'out
   "cout <<  << endl;\C-p\C-f\C-f\C-f\C-f\C-f\C-f\C-f\C-f")

(fset 'lc
      [?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?i ?o ?s ?t ?r ?e ?a ?m ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?v ?e ?c ?t ?o ?r ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?s ?t ?a ?c ?k ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?q ?u ?e ?u ?e ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?c ?m ?a ?t ?h ?> return ?u ?s ?i ?n ?g ?  ?n ?a ?m ?e ?s ?p ?a ?c ?e ?  ?s ?t ?d ?\; return return return return ?i ?n ?t ?  ?m ?a ?i ?n ?\( ?\) ?  backspace ?\{ return return return ?r ?e ?t ?u ?r ?n ?  ?0 ?\; return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p])

(fset 'st
   [?\C-  ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\M-p ?* return return ?\C-p ?\C-p])

(fset 'fo
   [?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return ?\M-g ?1 return ?\M-p ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return])

(fset 'f
   [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h tab ?\C-  ?\C-  ?\C-v])
(global-set-key (kbd "C-c f") 'f)
(put 'f 'kmacro t)

(fset 'vi
   "typedef vector<int> vi;")
(fset 'vvi
   "typedef vector<vector<int> > vvi;")
(fset 'vc
   "typedef vector<char> vc;")
(fset 'vvc
   "typedef vector<vector<char> > vvc;")
(fset 'vs
   "typedef vector<string> vs;")
(fset 'vvs
   "typedef vector<vector<string> > vvs;")

;;; for org-mode
(fset 'oo
   [?# ?+ ?t ?i ?t ?l ?e ?: ?  return ?# ?+ ?a ?u ?t ?h ?o ?r ?: ?  ?H ?e ?y ?a ?n ?  ?H ?u ?a ?n ?g return ?# ?+ ?s ?t ?a ?r ?t ?u ?p ?: ?  ?b ?e ?a ?m ?e ?r return ?# ?+ ?l ?a ?t ?e ?x ?_ ?c ?l ?a ?s ?s ?: ?  ?b ?e ?a ?m ?e ?r return ?# ?+ ?o ?p ?t ?i ?o ?n ?s ?: ?  ?H ?: ?1 ?  ?n ?u ?m ?: ?t ?  ?t ?o ?c ?: ?n ?i ?l ?\C-p ?\C-p ?\C-p ?\C-p])
(fset 'tw
   "- ")
(fset 'on
   "   ")
;(fset 'on
;   " ")
(fset 'fu
   [?\M-x ?t ?w ?\C-p ?\M-x ?o ?n return ?\C-p ?\M-x ?o ?n])

;;; for c++/c
(fset 'el
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\;])


;;; for Java environment
;(require 'cedet) ; cannot find the package
;semantiec基本配置
;见http://emacser.com/built-in-cedet.htm
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				  global-semanticdb-minor-mode
				  global-semantic-idle-summary-mode
				  global-semantic-mru-bookmark-mode))
;(semantic-mode 1)
;(global-semantic-highlight-edits-mode (if window-system 1 -1))
;(global-semantic-show-unmatched-syntax-mode 1)
;(global-semantic-show-parser-state-mode 1)
;代码跳转和官方版本一样还是用semantic-ia-fast-jump命令，不过在emacs-23.2里直接用这个命令可能会报下面的错误,所以运行时这个feature没被load进来，我们需要自己load一下：
;(require 'semantic/analyze/refs)
;(global-ede-mode t)



;;; 解压缩放入load-path目录。然后load，require。
;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")
;(require 'font-lock)
;(require 'ecb)
;(require 'ecb-autoloads)
;(require 'jde)

;(add-to-list 'ac-modes 'jde-mode)
;(add-to-list 'ac-modes 'java-mode)
;(add-hook 'java-mode-hook (lambda () ; this one does not help
;			    (company-mode 0)))
;(add-hook 'jde-mode-hook (lambda () (push 'ac-source-semantic ac-sources)))
;(autoload 'jde-mode "jde" "JDE mode." t)
;(setq auto-mode-alist (append '(("\\.java\\'" . java-mode)) auto-mode-alist))

;(load-file "~/.emacs.d/lisp/cdb-gud.el")
;(add-hook 'jdb-mode-hook '(lambda ()
;			    (setq jdb-need-run t)
;			    (global-set-key [(f4)]   'gud-kill)
;			    (global-set-key [(f5)]   'jdb-run-cont)
;			    (global-set-key [(f7)]   'gud-print)
;			    (global-set-key [(f8)]   'gud-remove)
;			    (global-set-key [(f9)]   'gud-break)
;			    (global-set-key [(f10)]  'gud-step)
;			    (global-set-key [(f11)]  'gud-next)
;			    (global-set-key [(f12)]  'gud-finish)
;
;			    (split-window-horizontally)
;			    (tabbar-backward-group)
;			    ))

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
;  (flet ((process-list ())) ad-do-it))
  (cl-flet ((process-list ())) ad-do-it))

;(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)
;(defun joaot/delete-process-at-point ()
;  (interactive)
;  (let ((process (get-text-property (point) 'tabulated-list-id)))
;    (cond ((and process
;                (processp process))
;           (delete-process process)
;           (revert-buffer))
;          (t
;           (error "no process at point!")))))

(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary, in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t));;; 1)
;(setq soft-wrap-lines t) ;; for chinese
;(setq debug-on-error t)


;;; java macro
(fset 'lm
   "System.out.println(\"\C-f);\C-p\C-e\C-b\C-b\C-b")
(fset 'mg
   "System.out.println(\": \C-f + \C-f;\C-p\346\346\346\C-f\C-f")
(fset 'j
      [?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?H ?a ?s ?h ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?A ?r ?r ?a ?y ?L ?i ?s ?t ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?L ?i ?s ?t ?\; return return ?p ?u ?b ?l ?i ?c ?  ?c ?l ?a ?s ?s ?  ?\{ return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?c ?l ?a ?s ?s ?  ?S ?o ?l ?u ?t ?i ?o ?n ?  ?\{ return return ?\} return return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?v ?o ?i ?d ?  ?m ?a ?i ?n ?( ?S ?t ?r ?i ?n ?g ?\[ ?\] ?  ?a ?r ?g ?s ?) ?\{ return ?S ?o ?l ?u ?t ?i ?o ?n ?  ?r ?e ?s ?u ?l ?t ?  ?= ?  ?n ?e ?w ?  ?S ?o ?l ?u ?t ?i ?o ?n ?( ?) ?\; return return ?S ?y ?s ?t ?e ?m ?\. ?o ?u ?t ?\. ?p ?r ?i ?n ?t ?l ?n ?( ?r ?e ?s ?) ?\; return ?\} return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-a])

;;; for sr-speedbar
(setq load-path (cons "~/.emacs.d/elpa/sr-speedbar-20141004.532" load-path))
(require 'sr-speedbar)
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用
(global-set-key [(f5)] 'speedbar-get-focus)
(speedbar 1)
;;; ### Speedbar ###
;;; --- 资源管理器
(setq speedbar-show-unknown-files t)    ;显示文件





(fset 'mt
   "\346\342//\C-n\C-a")
(fset 'dt
   "\346\342\C-h\C-h\C-n\C-a")

(put 'downcase-region 'disabled nil)

(fset 'one
      [?\C-a ?\C-e ?\C-  ?\C-n ?\C-a ?\M-f ?\M-b ?\C-w ?  ?\C-e ?\C-  ?\C-n ?\C-b ?\C-w ?  ?\C-n ?\C-a ?\C-k])
(global-set-key (kbd "C-c o") 'one)
(put 'one 'kmacro t)

; for racket comment decomment
(fset 'lcomment
   "\C-a;\C-n\C-a")
(global-set-key (kbd "C-c c") 'lcomment)
(put 'lcomment 'kmacro t)

(fset 'ldecomment
   "\C-a\C-d\C-n\C-a")
(global-set-key (kbd "C-c d") 'ldecomment)
(put 'ldecomment 'kmacro t)


;;; for python-mode comment (cpy) and decommment (dcp)
(fset 'cpy
   "\C-a#\C-n\C-a")
(fset 'dcp
   "\C-a\C-d\C-n\C-a")
;;; for python-mode comment and decomment
(global-set-key (kbd "C-c c") 'cpy)
(put 'cpy 'kmacro t)
(global-set-key (kbd "C-c d") 'dcp)
(put 'dcp 'kmacro t)


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
 (yaml-mode writeroom-mode workgroups2 wgrep web-mode w3m unfill tidy textile-mode tagedit sr-speedbar smex simple-httpd session scss-mode scratch rvm ruby-compilation robe rjsx-mode request regex-tool rainbow-delimiters quack pyim pomodoro paredit page-break-lines package-lint nvm neotree mwe-log-commands multi-term move-text markdown-mode lua-mode link less-css-mode legalese jump js-doc iedit idomenu ibuffer-vc hydra htmlize hl-sexp haskell-mode haml-mode groovy-mode gitignore-mode gitconfig-mode git-timemachine git-link gist fringe-helper flyspell-lazy flymake-ruby flymake-lua flymake-jslint flymake-css flx-ido find-by-pinyin-dired expand-region exec-path-from-shell erlang emms emmet-mode elpy dumb-jump dsvn dropdown-list dired+ diminish dictionary define-word csharp-mode crontab-mode cpputils-cmake counsel-gtags counsel-bbdb connection company-c-headers color-theme cmake-mode cliphist buffer-move bookmark+ bbdb auto-yasnippet auto-complete auto-compile ace-window ace-mc ace-link))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
	;;; Local Variables:
;;; no-byte-compile: t
;;; End:
;(put 'erase-buffer 'disabled nil)
