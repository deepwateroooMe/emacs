;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

(setq default-directory "C:/Users/blue_/AppData/Roaming/.emacs.d/")
;; (setq default-directory "f:/")

(setq debug-on-error t);; 它会无数次地停掉程序，去掉

;; ;; Bootstrap 'use-package'
;; (eval-after-load 'gnutls
;;   '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
;; (unless (package-installed-p 'use-packsage)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; (eval-when-compile
;;   (require 'use-package))
;; (require 'bind-key)
;; (setq use-package-always-ensure t)
;; ;(debug-on-entry 'package-initialize)    


;; (global-set-key (kbd "M-SPC") 'set-mark-command)

(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
(setq gc-cons-threshold most-positive-fixnum) ;; don't GC during startup to save time

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))


;;; setup defaults for all modes
(setq default-frame-alist
      ;; '((top . 0)(left . 427)(height . 75)(width . 180)(menubar-lines . 70)(tool-bar-line . 0))
      '((top . 0)(left . 527)(height . 90)(width . 180)(menubar-lines . 83)(tool-bar-line . 0))
      ;; '((top . 0)(left . 400)(height . 157)(width . 180)(menubar-lines . 70)(tool-bar-line . 0)) ; ori
      ) ; tmp.p


;;----------------------------------------------------------------------------
;; which functionality to enable (use t or nil for true and false)
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


;;; for emacs 27.1 specifically ,it does not recognize system key modifier switches 
(setq mac-option-modifier 'meta)
;; (setq mac-right-option-modifier nil)


;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))


;; not stable: sometimes it works, sometimes does not.
;; (defgroup gio-group nil
;;   "Group for customization"
;;   :prefix "gio-")
;; (defface gio-highlight-numbers-face
;;   '((t :inherit (default)
;;        :foreground "#f6546a")) ;;; ori: #ffff00 #fff68f
;;   "Face for numbers"
;;   :group 'gio-group )
;; (defvar gio-keywords '(("\\(\\b\\|[-]\\)\\([-]?\\([0-9]+\\)\\(\\.?[0-9]\\)*\\)\\b" . 'gio-highlight-numbers-face)) ;; Integers & Decimals
;;   "Keywords for gio-minor-mode highlighting")
;; (define-minor-mode gio-minor-mode
;;   "Minor mode for customization"
;;   :init-value 1
;;   :lighter " GioMode"
;;   :group 'gio-group
;;   (when (bound-and-true-p gio-minor-mode)
;;     (font-lock-add-keywords nil gio-keywords)
;;     (font-lock-fontify-buffer)) ;;; 这里会导致csharp-mode里的一些问题
;;   (when (not (bound-and-true-p gio-minor-mode))
;;     (font-lock-remove-keywords nil gio-keywords)
;;     (font-lock-fontify-buffer)))  ;;; 这里会导致csharp-mode里的一些问题
;; (define-globalized-minor-mode gio-global-minor-mode gio-minor-mode gio-minor-mode :group 'gio-group)
;; (gio-global-minor-mode 1)


;; ;;; bypassing default build in org-mode, and try to use customized version
;; (use-package org
;;   :ensure nil
;;   :ensure htmlize                       ; For org-publish
;;   :load-path ("~/.emacs.d/elpa/org-20140901/")
;;   :init
;;   :config
;;   (add-to-list 'org-modules 'org-habit))



(defface org-block-begin-line
  '((t (:foreground "#008ED1" :background "#D3D3D3"))) ;; #EAEAFF
  ;; '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#D3D3D3"))) ;; #EAEAFF
  "Face used for the line delimiting the begin of source blocks.")
;; (defface org-block-background
;;   '((t (:background "#D3D3D3"))) ;;; #FFFFEA
;;   "Face used for the source block background.")
(defface org-block-end-line
  '((t (:foreground "#008ED1" :background "#D3D3D3"))) ;; #EAEAFF
  ;; '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#D3D3D3"))) ;; #EAEAFF
  "Face used for the line delimiting the end of source blocks.")

;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let ((file-name-handler-alist nil))
  (require 'init-autoload)  ;; too many, commented this one out
  (require 'init-modeline)
  (require 'init-compat)
  (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
  (require 'init-utils) ; (defun is-buffer-file-temp())   ;;;;;;; comment for temp only, debug later today
  (require 'idle-require)
  (require 'init-elpa)
  (require 'init-exec-path) ;; Set up $PATH
  ;; any file use flyspell should be initialized after init-spelling.el
  ;; actually, I don't know which major-mode use flyspell.
  (require 'init-cc-mode)
  (require 'init-spelling)
  (require 'init-gui-frames)
  (require 'init-ido)
  ;; (require 'init-dired)
  (require 'init-uniquify)
  (require 'init-ibuffer)
  (require 'init-ivy)
  (require 'init-hippie-expand)
  (require 'init-windows)
  (require 'init-sessions)
  (require 'init-git)
  (require 'init-crontab)
  (require 'init-markdown)
  (require 'init-erlang)
  (require 'init-css)
  (require 'init-sr-speedbar)
  (require 'org-move-tree)
  (require 'init-java-mode)
  (require 'init-javascript)
  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)
  (require 'init-auto-complete)
  (require 'cpputils-cmake) ; to do more work on this one
  ;; Use bookmark instead
  (require 'init-gud) 
  (require 'init-linum-mode)
  (require 'init-moz)
  (require 'init-gtags)
  ;; init-evil dependent on init-clipboard
  (require 'init-clipboard)
  ;; use evil mode (vi key binding)
;;;;; 不会用下现在的这个mode 开启了就无法输入了，暂时放一放，研究一下这个到底是在干什么的了之后再看要不要试着用  
  ;; (require 'init-evil) ;;;;; 它们说切到 evil-normal-mode就可以自动上屏了
  ;; (require 'init-multiple-cursors)
  (require 'init-sh)
  (require 'init-ctags)
  (require 'init-bbdb)
  (require 'init-gnus)
  ;; (require 'init-lua-mode) ;;;;; cmp for tmp
  (require 'init-workgroups2)
  (require 'init-term-mode)
  (require 'init-web-mode)
  (require 'init-slime)
  (require 'shader-mode)
;  (require 'init-kotlin-mode)
  (require 'init-nxml-mode)
  ;; (require 'init-company)
  ;; have NOT passed  
  (require 'init-org);; 这个还是可以用的	org.el-wrong-numberkfdjfjd 我爱亲爱的表哥，活宝妹一定要嫁的亲爱的表哥！！！ dlkfjdfkljf 
  (require 'init-yasnippet)
  (require 'init-text)
  (require 'init-syslog-mode)
  (require 'init-misc)  ;; comment for replace-string
  (require 'init-autopair) 
  ;; (require 'init-hydra) ;; 不知道这个会影响哪些功能  
  (require 'pangu-spacing)
  (require 'expand-region)
  (require 'init-protobuf-mode)
  (require 'init-pyim) ;; 这个东西，一时半会儿可能还弄不出来，先放一下
  ;;   ;; (require 'init-company) ;;; 不喜欢它老是跑出一大堆的路径相关的,不方便,暂时不同这个模式
  ;; (require 'init-pdf-tools) ;;;; 我并没有使用这个
;  (require 'init-org-noter-pdftools)
  ;; (require 'init-company) ;;; 不喜欢它老是跑出一大堆的路径相关的,不方便,暂时不同这个模式
  (require 'init-csharp-mode) 
  ;; (require 'swift-mode) ;;; C-j C-i 容易被其它模式重写 ？
  )

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 4))
(defun shift-left ()
  (interactive)
  (shift-region -4))

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

(setq auto-save-default nil)

;;;; for one-dark-pro like visual studio theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/atom-one-dark-theme.el")
(load-theme 'atom-one-dark t)

(global-pangu-spacing-mode 1)
;; C-; 不知道是什么原因，绑定到ISpell 或是 flycheck 之类的了，把其它的去掉，保留这个好用的键
(global-set-key (kbd "C-;") 'er/expand-region)

;; forward word to skip _ mark

(modify-syntax-entry ?_ "w" c-mode-syntax-table)
(modify-syntax-entry ?_ "w" c++-mode-syntax-table)
(global-set-key (kbd "M-f") 'forward-word)

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))

(setq ac-disable-faces nil) ;;; 这里再加一遍，好像 init.el-auto-complete.el 里有错，加载不好

(load "font-lock")
(setq font-lock-maximum-decoration t)
(global-font-lock-mode)

;;; move up or down multiple lines
(global-set-key (kbd "M-n")
                (lambda ()
                  (interactive)
                  (setq this-command 'next-line)
                  (next-line 6)))

;; replaces backward-sentence
(global-set-key (kbd "M-p")
                (lambda ()
                  (interactive)
                  (setq this-command 'previous-line)
                  (previous-line 6)))


;;; autorevert buffer
(require 'autorevert)
(global-auto-revert-mode 1)


;;; 设置字体
(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "SimSun"))
                                        ;(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "STSong"))
                                        ;让Emacs在保存时自动清除行尾空格及文件结尾空行
                                        ;(add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; don't like, especially for org-mode


;;;auto indent yank, this one doesn't seem to work
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))
(global-set-key (kbd "C-y") 'yank-and-indent)


;;; indent buffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f12] 'indent-buffer)


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
      ;; indent-tabs-mode t
      c-basic-offset 4)
;;; 设定行距
(setq default-line-spacing 0.2)
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
;; ;;; 锁定行高
(setq resize-mini-windows nil)
;;; 开启服务器模式
(server-start)

;;; 递妆mimibuffer
(setq enable-recursive-minibuffers t)

(show-paren-mode t);显示括号匹配
(setq show-paren-mode t) ;;打开括号匹配显示模式
(setq show-paren-style 'parenthesis)


(defun ac-latex-mode-setup()
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)
;;;okokok
;;;okokok
;;;okokok

;;; meta
(global-set-key "\M-l" 'replace-string) ; originally lowercase folling word
(global-set-key "\M-g" 'goto-line)
(setq c-brace-imaginary-offset 1)

;;;comment outbelow: 它把 pyim 的光标给弄没了。。。。。
;;;comment outbelow
;; (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
;; (set-language-environment 'utf-8)
;; (setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (unless (eq system-type 'windows-nt)
;;   (set-selection-coding-system 'utf-8))
;; (prefer-coding-system 'utf-8)
;; ;(setq desktop-restore-frames nil)

;;;comment outbelow: 它把 pyim 的光标给弄没了。。。。。
;;;comment outbelow
;; (set-language-environment 'UTF-8) 
;; (set-locale-environment "UTF-8")


;;; for iimage org-mode
(setq org-image-actual-width nil)

;;; delete backward one char
(global-set-key [(control h)] 'delete-backward-char)
;;; prohibit auto-generate backup files
(setq-default make-backup-files nil)

;; ;; check for spelling
;; (setq-default ispell-program-name "aspell")
;; (setq text-mode-hook '(lambda()
;;                         (flyspell-mode t)))
;; (setq org-mode-hook '(lambda()
;;                        (flyspell-mode t)))

(load-file "~/.emacs.d/ido-ubiquitous.el")
;; (require 'ido-ubiquitous)
(load-file "~/.emacs.d/undo-tree.el")
;; (require 'undo-tree)
(global-undo-tree-mode)

;;; require ido-ubiquitous
(require 'ido)
;; (require 'ido-ubiquitous) ; replaces ido-everywhere

;;; ido-mode
(ido-mode t)

;; ;;;; flx-ido
;; ;; (load-file "~/.emacs.d/ido-ubiquitous.el")
;; (require 'flx-ido)
;; (flx-ido-mode t)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
;; increase garbage collection threshold
(setq gc-cons-threshold 20000000)

(require 'ido)
(ido-mode)
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] (kbd "C-x C-w"))


(defun soft-wrap-lines (boo)
  "Make lines wrap at window edge and on word boundary, in current buffer."
  (interactive "r")
  (setq truncate-lines nil))

;;; turn off buffer-read-only property
(setq buffer-read-only nil)

(defun wsl-copy-region-to-clipboard (start end)
  "Copy region to Windows clipboard."
  (interactive "r")
  (call-process-region start end "clip.exe" nil 0))

(defun wsl-cut-region-to-clipboard (start end)
  (interactive "r")
  (call-process-region start end "clip.exe" nil 0)
  (kill-region start end))

(defun wsl-clipboard-to-string ()
  "Return Windows clipboard as string."
  (let ((coding-system-for-read 'dos))
    (substring; remove added trailing \n
     (shell-command-to-string
      "powershell.exe -Command Get-Clipboard") 0 -1)))

(defun wsl-paste-from-clipboard (arg)
  "Insert Windows clipboard at point. With prefix ARG, also add to kill-ring"
  (interactive "P")
  (let ((clip (wsl-clipboard-to-string)))
    (insert clip)
    (if arg (kill-new clip))))


;;; for formating files when copying codes from online or somewhere which format I don't like
(fset 'ta   ;;; C-i to be " & "  tab
      [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-i return ?  ?& ?  return])

(fset 'fom  ;;; { to be inline
      [?\M-x ?r ?e ?p ?l ?  ?s return ?\C-q ?\C-j ?\C-q ?\C-i ?\{ ?\C-q ?\C-j return ?  ?\{ ?\C-q ?\C-j return])
(fset 'el
      "\C-n\C-k\C-p\C-e\C-y\C-n\C-n\C-b\C-b\C-k\C-p\C-p\C-e\C-y\C-k\C-k\C-n\C-n\C-a")

(fset 'fn
      [?\M-p ?\C-q ?\C-j ?\{ return ?  ?\{ return])
(fset 'nd
      "\C-e|\C-n\C-e")

(fset 'lc ;;; c++ header for leetcode problems
      [?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?i ?o ?s ?t ?r ?e ?a ?m ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?v ?e ?c ?t ?o ?r ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?s ?t ?a ?c ?k ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?q ?u ?e ?u ?e ?> return ?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?c ?m ?a ?t ?h ?> return ?u ?s ?i ?n ?g ?  ?n ?a ?m ?e ?s ?p ?a ?c ?e ?  ?s ?t ?d ?\; return return return return ?i ?n ?t ?  ?m ?a ?i ?n ?\( ?\) ?  backspace ?\{ return return return ?r ?e ?t ?u ?r ?n ?  ?0 ?\; return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p])

;; (fset 
;;       [?\C-  ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\M-p ?* return return ?\C-p ?\C-p])


(set-face-attribute 'default nil :font "Inconsolata-dz")

;; (set-face-attribute 'region nil :background "#666" :foreground "#ffffff") 
(setq yas-indent-line 'auto)
(setq my/for-org nil)


;; ;;确保这一段是在所有配置文件的最后面执行,在最前面没有效果
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) ;
                    charset
                    (font-spec :family "Sarasa Mono Slab SC Semibold" :height 130)))



;;;; 加载snippets 的接口
(add-hook 'emacs-startup-hook (lambda () (yas-load-directory "C:/Users/blue_/AppData/Roaming/.emacs.d/snippets/")))


;;; save buffer, kill emacs when it has clients, automatically
(defadvice save-buffers-kill-emacs (around no-y-or-n activate)
  (flet ((yes-or-no-p (&rest args) t)
         (y-or-n-p (&rest args) t))
    ad-do-it))
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)


;; '(fci-rule-color "#dedede") ;;; 我又试着把它加回去了
;; '(custom-safe-themes
;;   '("0c860c4fe9df8cff6484c54d2ae263f19d935e4ff57019999edbda9c7eda50b8" "f490984d405f1a97418a92f478218b8e4bcc188cf353e5dd5d5acd2f8efd0790" "28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" default))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector)
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(fci-rule-color "#dedede")
 '(column-number-mode t)
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("0c860c4fe9df8cff6484c54d2ae263f19d935e4ff57019999edbda9c7eda50b8" "f490984d405f1a97418a92f478218b8e4bcc188cf353e5dd5d5acd2f8efd0790" "28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" default))
 '(display-time-mode t)
 '(fci-rule-color "#dedede")
 '(git-gutter:handled-backends '(svn hg git))
 '(latex-run-command "latex --shell-escape")
 '(line-spacing 0.1)
 '(nxml-slash-auto-complete-flag t)
 '(org-export-with-sub-superscripts nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-support-shift-select nil)
 '(package-selected-packages
   '(tree-sitter-indent tree-sitter-langs tree-sitter csharp-mode cnfonts go-mode slime rime xr pyim-wbdict web-mode-edit-element auctex fuzzy ppd-sr-speedbar lsp-mode py-autopep8 logview virtualenvwrapper company-jedi auto-complete-clang-async yaml-mode writeroom-mode workgroups2 wgrep web-mode w3m unfill tidy textile-mode tagedit sr-speedbar smex simple-httpd session scss-mode scratch rvm ruby-compilation robe rjsx-mode request regex-tool rainbow-delimiters quack pyim pomodoro paredit page-break-lines package-lint nvm neotree mwe-log-commands multi-term move-text markdown-mode link less-css-mode legalese jump js-doc iedit idomenu ibuffer-vc htmlize hl-sexp haskell-mode haml-mode groovy-mode gitignore-mode gitconfig-mode git-timemachine git-link gist fringe-helper flx-ido find-by-pinyin-dired expand-region exec-path-from-shell erlang emms emmet-mode elpy dumb-jump dsvn dropdown-list dired+ diminish dictionary define-word crontab-mode cpputils-cmake counsel-gtags counsel-bbdb connection company-c-headers cmake-mode cliphist buffer-move bookmark+ bbdb auto-yasnippet auto-complete auto-compile ace-window ace-mc ace-link))
 '(pdf-tools-handle-upgrades nil)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(speedbar-frame-parameters '((minibuffer) (width . 35)))
 '(speedbar-show-unknown-files nil)
 '(speedbar-smart-directory-expand-flag t)
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-default-width 35)
 '(sr-speedbar-max-width 35)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p nil)
 '(sr-speedbar-width-x 35 t)
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]])
 '(tex-run-command "\"latex --shell-escape\"")
 '(tex-start-commands "\"latex -ini -shell-escape\"")
 '(tex-start-options "\"latex -ini --shell-escape\"")
 '(tool-bar-mode nil)
 '(warning-minimum-level :error)
 '(warning-suppress-types '((use-package)))
 '(word-wrap nil)
 '(yas-also-auto-indent-first-line t)
 '(yas-also-indent-empty-lines t)
 '(yas-indent-line 'auto)
 '(yas-snippet-dirs
   '("~/.emacs.d/snippets" "~/.emacs.d/elpa/elpy-1.18.0/snippets/"))
 '(yas-wrap-around-region 'cua))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282C34" :foreground "#ABB2BF" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "Inconsolata-dz for Powerline"))))
 '(hi-blue-b ((t (:foreground "systemBlueColor" :weight bold))))
 '(hi-salmon ((t (:background "NavajoWhite1" :foreground "gray0"))))
 '(highlight ((t (:background "white smoke"))))
 '(org-level-1 ((t (:inherit outline-1))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(org-level-3 ((t (:inherit outline-3))))
 '(org-level-4 ((t (:inherit outline-4))))
 '(org-level-5 ((t (:inherit outline-5))))
 '(org-level-6 ((t (:inherit outline-6))))
 '(region ((t (:extend t :background "dodger blue" :foreground "#e1e1e0"))))
 '(speedbar-directory-face ((t (:foreground "light slate blue" :height 100 :family "Droid Sans"))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
