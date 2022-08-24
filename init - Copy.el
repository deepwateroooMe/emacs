;;;
;;; original came from https://github.com/redguardtoo/emacs.d

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;(package-initialize)

(defvar luna-dumped nil
  "non-nil when a dump file is loaded (because dump.el sets this variable).")


;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)


;(debug-on-entry 'package-initialize)    


(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
(setq gc-cons-threshold most-positive-fixnum) ;; don't GC during startup to save time

(setq default-directory "C:/Users/blue_/AppData/Roaming/.emacs.d/")
;; (setq default-directory "/Volumes/e/uMVVM/Assets/Sources/")
;; (setq default-directory "/Volumes/e/ILRuntimeHotFix/ILRuntimeU3D/ILRuntimeDemo/Assets/Samples/ILRuntime/1.6.4/Demo/Scripts/Examples")
;(setq default-directory "C:/Users/blue_/Desktop/")
;; (setq default-directory "e:/yunlangZhuZuoAndroid/trunk/client/trunk/")
;; (setq default-directory "h:/andrprac/RealTimeEval/app/src/main/")
;; (setq default-directory "h:/andrprac/FragmentsDemo/app/src/main/")
;; (setq default-directory "h:/andrprac/ContentProvider/app/src/main/")
;; (setq default-directory "h:/andrprac/ContentProvider-interp/app/src/main/")
;; (setq default-directory "h:/contentProviderTutorial/app/src/main/")
;; (setq default-directory "h:/andrprac/launchmode/app/src/main/")
;; (setq default-directory "h:/andrprac/Android-Activity-LaunchMode/app/src/main/")
;; (setq default-directory "h:/andrprac/mvx/app/src/main/")
;; (setq default-directory "h:/andrprac/ViewPagerFragmentLazyLoad/app/src/main/")
;; (setq default-directory "h:/andrprac/sunflower_java/app/src/main/")
;; (setq default-directory "h:/andrprac/android-navigation/app/src/main/")
;; (setq default-directory "h:/andrprac/SampleNavigation/app/src/main/")
;; (setq default-directory "h:/andrprac/Jetpack-databinding/compose_hoo/app/src/main/")
;; (setq default-directory "h:/andrprac/recyclerview-json-parsing/RecyclerJsonParsing/app/src/main/")
;; (setq default-directory "h:/andrprac/retrofit-example/app/src/main/")
;; (setq default-directory "h:/andrprac/MockitoExample/app/src/main/")
;; (setq default-directory "h:/andrprac/Sample_AndroidTest/app/src/main/")
;; (setq default-directory "h:/andrprac/SnakeKotlinDemo/app/src/main/")
;; (setq default-directory "h:/andrprac/wanandroid/app/src/main/")
;; (setq default-directory (concat "/andrprac/jv/app/src/main/java/com/me/jv/"))
;; (setq default-directory "h:/andrprac/coroutines-sample/app/src/main/")
;; (setq default-directory "h:/andrprac/PagingDemo/app/src/main/")
;; (setq default-directory "h:/andrprac/RxJavaLearningMaterial/app/src/main/")
;; (setq default-directory "h:/andrprac/AnchorTask/app/src/main/")
;; (setq default-directory "h:/andrprac/banner/app/src/main/")
;; (setq default-directory "h:/andrprac/Fan/app/src/main/")
;; (setq default-directory "h:/andrprac/MultiThread_learning/app/src/main/")
;; (setq default-directory "h:/andrprac/CustomView/app/src/main/")
;; (setq default-directory "h:/andrprac/HelloAnimations/app/src/main/")
;; (setq default-directory "h:/andrprac/listview/app/src/main/")
;; (setq default-directory "h:/andrprac/CustomView/app/src/main/")
;; (setq default-directory "h:/leetcodeCoding/")
;; (setq default-directory "h:/andrprac/")
;(setq default-directory "h:/andrprac/View-CustomLayout/app/src/main/")
;; (setq default-directory "h:/andrprac/Meizikt/app/src/main/")
;; (setq default-directory "h:/andrprac/GoodsDemo/app/src/main/")

;;; setup defaults for all modes
(setq default-frame-alist
      '((top . 0)(left . 350)(height . 50)(width . 160)(menubar-lines . 100)(tool-bar-line . 0)) ; ori
     ;; '((top . 0)(left . 400)(height . 63)(width . 180)(menubar-lines . 100)(tool-bar-line . 0))
      ) ; tmp.py

(setq emacs-load-start-time (current-time))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "C:/Users/blue_/AppData/Roaming/.emacs.d/lisp"))

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

;; w32-alt-is-meta
;; w32-lwindow-modifier
;; and w32-rwindow-modifier

;; (setq mac-option-modifier 'meta)
;; (setq mac-right-option-modifier nil)

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))


(defgroup gio-group nil
  "Group for customization"
  :prefix "gio-")

(defface gio-highlight-numbers-face
  '((t :inherit (default)
       :foreground "#f6546a")) ;;; ori: #ffff00 #fff68f
  "Face for numbers"
  :group 'gio-group )

(defvar gio-keywords '(("\\(\\b\\|[-]\\)\\([-]?\\([0-9]+\\)\\(\\.?[0-9]\\)*\\)\\b" . 'gio-highlight-numbers-face)) ;; Integers & Decimals
  "Keywords for gio-minor-mode highlighting")

(define-minor-mode gio-minor-mode
  "Minor mode for customization"
  :init-value 1
  :lighter " GioMode"
  :group 'gio-group
  (when (bound-and-true-p gio-minor-mode)
    (font-lock-add-keywords nil gio-keywords)
    (font-lock-fontify-buffer))
  (when (not (bound-and-true-p gio-minor-mode))
    (font-lock-remove-keywords nil gio-keywords)
    (font-lock-fontify-buffer)))

(define-globalized-minor-mode gio-global-minor-mode gio-minor-mode gio-minor-mode :group 'gio-group)
(gio-global-minor-mode 1)


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
  (require 'init-ivy)
  (require 'init-hippie-expand)
  ;; (require 'init-windows)
  (require 'init-sessions)
  (require 'init-git)
  (require 'init-crontab)
  (require 'init-markdown)
  (require 'init-erlang)
  (require 'init-javascript)
  (require 'init-css)
  (require 'init-sr-speedbar)

  (require 'org-move-tree)

  ;; (require 'init-java-mode)
  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)
;  (require 'init-auto-complete)

  (require 'cpputils-cmake) ; to do more work on this one
  ;; Use bookmark instead
  ;; (require 'init-cc-mode)
  (require 'init-gud)
  (require 'init-linum-mode)
  (require 'init-moz)
  (require 'init-gtags)
  ;; init-evil dependent on init-clipboard
  (require 'init-clipboard)
  ;; use evil mode (vi key binding)
  ;(require 'init-evil)
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
  (require 'shader-mode)
;  (require 'swift-mode)
  ;; (require 'init-kotlin-mode)
  ;; (require 'init-company)
  
;; have NOT passed  
 (require 'init-org)			
 (require 'init-yasnippet)
 (require 'init-text)
 (require 'init-syslog-mode)
 (require 'init-misc)  ;; comment for replace-string
 (require 'init-hydra)

 
;(require 'init-python-mode)
(require 'init-csharp-mode)
;(require 'init-company)
  )

;; ;;; org-mode auto complete, commented out only for dump fixes
;; (require 'org-ac)
;; (org-ac/config-default)


;; (defmacro luna-if-dump (then &rest else)
;;   "Evaluate IF if running with a dump file, else evaluate ELSE."
;;   (declare (indent 1))
;;   `(if luna-dumped
;;        ,then
;;      ,@else))

;; (luna-if-dump
;;     (progn
;;       (setq load-path luna-dumped-load-path)
;;       (global-font-lock-mode)
;;       (transient-mark-mode)
;;       (add-hook 'after-init-hook
;;                 (lambda ()
;;                   (save-excursion
;;                     ;; (switch-to-buffer "*scratch*")
;;                     (lisp-interaction-mode)))))
;;   ;; add load-path’s and load autoload files
;;   ;; (package-initialize)
;;   )

;; (defun spacemacs|load-modes (modes)
;;   (dolist (mode modes)
;;     (with-temp-buffer
;;       (funcall-interactively
;;        (intern (concat (symbol-name mode) "-mode"))))))
;; (spacemacs|load-modes '(dired emacs-lisp markdown org python))

(load "font-lock")
(setq font-lock-maximum-decoration t)
(global-font-lock-mode)

(defmacro luna-if-dump ()
  "Evaluate IF if running with a dump file, else evaluate ELSE."
  (declare (indent 1))
  `(if (eq luna-dumped t)
       (progn
         (setq load-path luna-dumped-load-path)
         (global-font-lock-mode)
         (transient-mark-mode)
         (add-hook 'after-init-hook
                   (lambda ()
                     (save-excursion
                       (lisp-interaction-mode)))))
     (progn
       (let ((file-name-handler-alist nil))
         (require 'init-python-mode)
         (require 'init-csharp-mode)
         (require 'init-company)
         (require 'init-sr-speedbar)
         )
       ;; (spacemacs|load-modes '(company csharp))
       (add-hook 'after-init-hook
                 (lambda ()
                   (save-excursion
                     (lisp-interaction-mode)
                   ))))))

(luna-if-dump)

;; (defun luna-dump ()
;;   "Dump Emacs."
;;   (interactive)
;;   (let ((buf "*dump process*"))
;;     (make-process
;;      :name "dump"
;;      :buffer buf
;;      :command (list "emacs" "--batch" "-q"
;;                     "-l" (expand-file-name "dump.el"
;;                                            user-emacs-directory)))
;;     (display-buffer buf)))


;;; make tab key always call a indent command
;; (setq-default tab-always-indent t)

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
  (shift-region 8))

(defun shift-left ()
  (interactive)
  (shift-region -8))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one 
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)


;;; move up or down multiple lines
(global-set-key (kbd "M-n")
                (lambda ()
                  (interactive)
                  (setq this-command 'next-line)
                  (next-line 8)))

;; replaces backward-sentence
(global-set-key (kbd "M-p")
                (lambda ()
                  (interactive)
                  (setq this-command 'previous-line)
                  (previous-line 8)))


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
(setq default-line-spacing 2)
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

;;; 递妆mimibuffer
(setq enable-recursive-minibuffers t)

(show-paren-mode t);显示括号匹配
(setq show-paren-mode t) ;;打开括号匹配显示模式
(setq show-paren-style 'parenthesis)


(defun ac-latex-mode-setup()
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)


(add-to-list 'load-path "C:/Users/blue_/AppData/Roaming/.emacs.d/wubi")
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
                                        ;(global-set-key "\M- " 'toggle-input-method)

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

;;; for iimage org-mode
(setq org-image-actual-width nil)

;;; delete backward one char
(global-set-key [(control h)] 'delete-backward-char)
;;; prohibit auto-generate backup files
(setq-default make-backup-files nil)



(add-to-list 'load-path (expand-file-name "C:/Users/blue_/AppData/Roaming/.emacs.d/lisp/")) ;拓展文件(插件)目录
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
(require 'flx-ido)
(flx-ido-mode t)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
;; increase garbage collection threshold
(setq gc-cons-threshold 20000000)


(require 'ido)
(ido-mode)
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] (kbd "C-x C-w"))


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





					; wsl-copy ;;; 
;; (defun wsl-copy (start end)
;;   (interactive "r")
;;   (shell-command-on-region start end "clip.exe")
;;   (deactivate-mark))
;; 					; wsl-paste
;; (defun wsl-paste ()
;;   (interactive)
;;   (let ((clipboard
;; 	 (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
;;     (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters
;;     (setq clipboard (substring clipboard 0 -1)) ; Remove newline added by Powershell
;;     (insert clipboard)))
;; 					; Bind wsl-copy to C-c C-v
;; (global-set-key
;;  (kbd "C-c c")
;;  'wsl-copy)
;; 					; Bind wsl-paste to C-c C-v
;; (global-set-key
;;  (kbd "C-c y")
;;  'wsl-paste)

;; ;;; for ediff
;; ;;git mergetool 使用ediff ,前提可以正常使用emacsclient ,并且Emacs已经启动。
;; ;; ~/.gitconfig
;; ;; [mergetool "ediff"]
;; ;; cmd = emacsclient --eval \"(git-mergetool-emacsclient-ediff \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
;; ;; trustExitCode = false
;; ;; [mergetool]
;; ;; prompt = false
;; ;; [merge]
;; ;; tool = ediff
;; ;; Setup for ediff.
;; ;;(require 'ediff)
;; (defvar ediff-after-quit-hooks nil
;;   "* Hooks to run after ediff or emerge is quit.")

;; (defadvice ediff-quit (after edit-after-quit-hooks activate)
;;   (run-hooks 'ediff-after-quit-hooks))

;; (setq git-mergetool-emacsclient-ediff-active nil)

;; (defun local-ediff-frame-maximize ()
;;   (when (boundp 'display-usable-bounds)
;;     (let* ((bounds (display-usable-bounds))
;;            (x (nth 0 bounds))
;;            (y (nth 1 bounds))
;;            (width (/ (nth 2 bounds) (frame-char-width)))
;;            (height (/ (nth 3 bounds) (frame-char-height))))
;;       (set-frame-width (selected-frame) width)
;;       (set-frame-height (selected-frame) height)
;;       (set-frame-position (selected-frame) x y))  )
;;   )
;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; (setq ediff-split-window-function 'split-window-horizontally)

;; (defun local-ediff-before-setup-hook ()
;;   (setq local-ediff-saved-frame-configuration (current-frame-configuration))
;;   (setq local-ediff-saved-window-configuration (current-window-configuration))
;;   (local-ediff-frame-maximize)
;;   (if git-mergetool-emacsclient-ediff-active
;;       (raise-frame)))

;; (defun local-ediff-quit-hook ()
;;   (set-frame-configuration local-ediff-saved-frame-configuration)
;;   (set-window-configuration local-ediff-saved-window-configuration))

;; (defun local-ediff-suspend-hook ()
;;   (set-frame-configuration local-ediff-saved-frame-configuration)
;;   (set-window-configuration local-ediff-saved-window-configuration))

;; (add-hook 'ediff-before-setup-hook 'local-ediff-before-setup-hook)
;; (add-hook 'ediff-quit-hook 'local-ediff-quit-hook 'append)
;; (add-hook 'ediff-suspend-hook 'local-ediff-suspend-hook 'append)

;; ;; Useful for ediff merge from emacsclient.
;; (defun git-mergetool-emacsclient-ediff (local remote base merged)
;;   (setq git-mergetool-emacsclient-ediff-active t)
;;   (if (file-readable-p base)
;;       (ediff-merge-files-with-ancestor local remote base nil merged)
;;     (ediff-merge-files local remote nil merged))
;;   (recursive-edit))
;; (defun git-mergetool-emacsclient-ediff-after-quit-hook ()
;;   (exit-recursive-edit))
;; (add-hook 'ediff-after-quit-hooks 'git-mergetool-emacsclient-ediff-after-quit-hook 'append)


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

(define-key global-map (kbd "C-x C-y") 'wsl-paste-from-clipboard)
(define-key global-map (kbd "C-x M-w") 'wsl-copy-region-to-clipboard)
(define-key global-map (kbd "C-x C-w") 'wsl-cut-region-to-clipboard)

;;; lisp mute & dmute
(fset 'ldm
      [?\C-a ?\C-  ?\C-f ?\C-w ?\C-n ?\C-a])


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

(fset 'st
      [?\C-  ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\M-p ?* return return ?\C-p ?\C-p])


;; @see https://www.reddit.com/r/emacs/comments/4q4ixw/how_to_forbid_emacs_to_touch_configuration_files/
                                        ;(setq custom-file (concat user-emacs-directory "custom-set-variables.el"))
                                        ;(load custom-file 'noerror)

                                        ;(setq gc-cons-threshold best-gc-cons-threshold)

(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")
(setq yas-indent-line 'auto)
;(setq yas/indent-line 'auto)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes '(leuven))
 '(display-time-mode t)
 '(git-gutter:handled-backends '(svn hg git))
 '(latex-run-command "latex --shell-escape")
 '(line-spacing 0)
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-support-shift-select nil)
 '(package-selected-packages
   '(lsp-mode py-autopep8 logview virtualenvwrapper company-jedi flycheck-color-mode-line auto-complete-clang-async flycheck-swift3 flycheck-swift flycheck swift3-mode swift-mode yaml-mode writeroom-mode workgroups2 wgrep web-mode w3m unfill tidy textile-mode tagedit sr-speedbar smex simple-httpd session scss-mode scratch rvm ruby-compilation robe rjsx-mode request regex-tool rainbow-delimiters quack pyim pomodoro paredit page-break-lines package-lint nvm neotree mwe-log-commands multi-term move-text markdown-mode lua-mode link less-css-mode legalese jump js-doc iedit idomenu ibuffer-vc hydra htmlize hl-sexp haskell-mode haml-mode groovy-mode gitignore-mode gitconfig-mode git-timemachine git-link gist fringe-helper flyspell-lazy flymake-ruby flymake-lua flymake-jslint flymake-css flx-ido find-by-pinyin-dired expand-region exec-path-from-shell erlang emms emmet-mode elpy dumb-jump dsvn dropdown-list dired+ diminish dictionary define-word csharp-mode crontab-mode cpputils-cmake counsel-gtags counsel-bbdb connection company-c-headers color-theme cmake-mode cliphist buffer-move bookmark+ bbdb auto-yasnippet auto-complete auto-compile ace-window ace-mc ace-link))
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(speedbar-frame-parameters
   '((minibuffer)
     (width . 35)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0)))
 '(speedbar-show-unknown-files nil)
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-default-width 30)
 '(sr-speedbar-max-width 30)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p nil)
 '(sr-speedbar-width-x 10)
 '(tex-run-command "\"latex --shell-escape\"")
 '(tex-start-commands "\"latex -ini -shell-escape\"")
 '(tex-start-options "\"latex -ini --shell-escape\"")
 '(tool-bar-mode nil)
 '(yas-also-auto-indent-first-line t)
 '(yas-also-indent-empty-lines t)
 '(yas-indent-line 'auto)
 '(yas-wrap-around-region 'cua))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata Medium" :foundry "outline" :slant normal :weight normal :height 113 :width normal))))
 '(org-level-1 ((t (:inherit outline-6))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(org-level-3 ((t (:inherit outline-5))))
 '(org-level-4 ((t (:inherit outline-1))))
 '(org-level-5 ((t (:inherit outline-3))))
 '(org-level-6 ((t (:inherit outline-4))))
 '(region ((t (:extend t :background "medium blue"))))
 '(speedbar-directory-face ((t (:foreground "light slate blue" :height 100 :family "Droid Sans"))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
	;;; Local Variables:
;;; no-byte-compile: t
;;; End:
                                        ;(put 'erase-buffer 'disabled nil)