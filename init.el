(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))


(setq default-directory "/Users/qunyan/AndroidStudioProjects/tetris/3d/app/src/main/java/dev/ttetris/")
;(setq default-directory "/Users/qunyan/AndroidStudioProjects/tetris/3d/")
;(setq default-directory "/Users/qunyan/Documents/spring16/java/hw2/")
;(setq default-directory "/Users/qunyan/AndroidStudioProjects/Cube/app/src/main/java/dev/cube/")
;(setq default-directory "/Users/qunyan/AndroidStudioProjects/DorkyMonkey/app/src/main/res/layout/")


;;; Meta
;(global-set-key "\C-SPC" 'set-mark-command)  ;;; doesn't have to set
(global-set-key "\M-p" 'replace-string)
(global-set-key "\M-g" 'goto-line)
;(global-set-key "\M-\C-h" 'backward-kill-word)
;(global-set-key "\M-\C-r" 'query-replace)
;(global-set-key "\M-h" 'help-command)


;;; autopair 
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers


;;; autorevert buffer
(require 'autorevert)
(global-auto-revert-mode 1)


;;; basic initialization, (require) non-ELPA packages, etc.
;(setq package-enable-at-startup nil)

;;; Initialize & Install Package
;(package-initialize)

;;; (require) your ELPA packages, configure them as normal
(require 'package)

(setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题 

;;; delete backward one char
(global-set-key [(control h)] 'delete-backward-char)
;;; prohibit auto-generate backup files
(setq-default make-backup-files nil)
;;; show line number
(global-linum-mode 1)
;;; no startup buffer
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
;;; frame titile file name
(setq use-file-dialog nil
      frame-title-format '(buffer-file-name "%b"))

;;; 设置字体
(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "SimSun"))
;(defvar font-list '("Microsoft Yahei" "SimHei" "NSimSun" "FangSong" "STSong"))

;;; fullscreen
;(defun fullscreen (&optional f)
;       (interactive)
;       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;               '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;               '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
					;(fullscreen)

;;; set startup frame size & location
(setq default-frame-alist
      '((top . 0)(left . 400)(height . 74)(width . 120)(menubar-lines . 20)(tool-bar-line . 0))) 


;; Workaround for Emacs (MacOS) bug where you can't set :height too large.
;; Bug is described here: http://emacswiki.org/emacs/SetFonts#toc14
;; This workaround is taken from http://www.emacswiki.org/emacs/GlobalTextScaleMode
;; If it interacts badly with some minor modes, that link offers an explanation.
;; Also, the modeline will still be the smaller size. The minibuffer will also start out small,
;; but get bigger if you type into it.
;; https://gist.github.com/tjg/aacf48cf4bfe692a4d6b
;;(define-globalized-minor-mode 
;;  global-text-scale-mode
;;  text-scale-mode
;;  (lambda () (text-scale-mode 1)))
;;(defun global-text-scale-adjust (inc) (interactive)
;;       (text-scale-set 1)
;;       (kill-local-variable 'text-scale-mode-amount)
;;       (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
;;       (global-text-scale-mode 1))
;;;; Example: you want Monaco 14, but that'd clip your frames' tops?
;;(set-face-attribute 'default nil :height 100)
;;(global-text-scale-adjust 1)


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


;;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
;;; followed three lines for java-mode snippets
					;(yas/initialize)
(yas--initialize)
;(yas-global-mode 1)
(yas/load-directory "~/.emacs.d/elpa/yasnippet-0.8.0/snippets")
(setq yas/trigger-key (kbd "TAB")) 

(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas-global-mode 1)
;(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;;; added for java-mode  
;(define-key yas/minor-mode-map [(tab)] nil)
;(define-key yas/minor-mode-map (kbd "TAB") nil)
;(setq yas/trigger-key "")
;(setq yas/next-field-key "")
;(setq yas/prev-field-key "")


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


;;; for company-mode
(add-to-list 'load-path "~/.emacs.d/elpa/company-20140928.1830") ;拓展文件(插件)目录
(autoload 'company-mode "company" nil t)
(setq company-idle-delay t)

;;; for csharp-mode
(add-to-list 'load-path "~/.emacs.d/elpa/csharp-mode-20130824.1200") ;拓展文件(插件)目录

;;; for python-mode
;(add-to-list 'load-path "~/.emacs.d/elpa/python-mode-6.1.3") ;拓展文件(插件)目录
;;; Indentation for python
;; Ignoring electric indentation
;(defun electric-indent-ignore-python (char)
;  "Ignore electric indentation for python-mode"
;  (if (equal major-mode 'python-mode)
;      `no-indent'
;    nil))
;(add-hook 'electric-indent-functions 'electric-indent-ignore-python)
;;; Enter key executes newline-and-indent
;(defun set-newline-and-indent ()
;  "Map the return key with `newline-and-indent'"
;  (local-set-key (kbd "RET") 'newline-and-indent))
;(add-hook 'python-mode-hook 'set-newline-and-indent)
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (let* ((my-lisp-dir "~/.emacs.d/elpa/python-mode-6.1.3")
              (default-directory my-lisp-dir))
           (setq load-path (cons my-lisp-dir load-path))
           (normal-top-level-add-subdirs-to-load-path)))
(autoload 'python-mode "python-mode" "Python Mode." t)

(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;(add-to-list 'interpreter-mode-alist '("\\.py\\'" . python-mode))


;(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")
;(semantic-load-enable-code-helpers)
;(semantic-load-enable-code-helpers)
;;;;semantic的自动补全快捷键
(global-set-key [(control tab)] 'semantic-ia-complete-symbol-menu) 
(setq semanticdb-project-roots
(list (expand-file-name "/")));semantic检索范围
;;设置semantic cache临时文件的路径，避免到处都是临时文件
(setq semanticdb-default-save-directory "~/.emacs.d/")

;;;;; yasnippet-bundle.el
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-bundle-0.6.1") ;拓展文件(插件)目录
(require 'yasnippet-bundle)     ;;; remove this one for java-mode


;;;我的C/C++语言编辑策略
(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)

  ;;这里的f6为调试，即用gdb调试，f7是调用make来对原文件进行编译
  (define-key c-mode-base-map [(f7)] 'compile)
  ;;默认情况下，emacs的compile命令是调用make -k，我把它改成了make。
  ;;你也可以把它改成其他的，比如gcc之类的。改下面的“make”就行了。
  '(compile-command "make")

  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  ;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  ;;  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
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


;;;; auto indent for ruby-mode                           
(define-key global-map (kbd "RET") 'newline-and-indent)
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))
(setq ruby-indent-level 4)

;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))


;;; org-mode
(setq load-path (cons "~/.emacs.d/elpa/org-20140901" load-path))
(require 'ox)
(require 'org-install)
(require 'ob-ditaa)  ;;; for cn-article
(require 'ox-publish)
(require 'ox-latex)
(require 'ox-beamer)
(require 'ox-md)
(require 'ox-org)
(setq org-src-fontify-natively t)  ;;; 要对代码进行语法高亮    ;;; added this one

(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))
;(add-to-list 'org-latex-packages-alist '(\"\" \"minted\"))  ;;; added this one


; (setq org-latex-listings 'minted)  ;;; added this one
; ;;; add frame and line number for source code
; (setq org-latex-minted-options
;       '(("frame" "single")
; 	("linenos" "true")))



;; Specify default packages to be included in every tex file, whether pdflatex or xelatex
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)))


(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 
	  (lambda ()
	    (setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题 
	    (setq org-startup-indented t)
	    (setq org-startup-truncated nil)
            (setq auto-indent-assign-indent-level 4)))
(setq org-startup-truncated nil)

;;; folding related
(load "folding" 'nomessage 'noerror)
;(folding−mode−add−find−file−hook)
;(folding−add−to−marks−list 'org−mode "# {{{" "# }}}" nil t)
;(add−hook 'org−mode−hook 'folding−mode)

;; iimage mode
(require 'iimage)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
;;; for resize


;;; 使用一步生成 xelatexPDF
;; Use XeLaTeX to export PDF in Org-mode
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))

;; 默认主模式为 org−mode
;(setq default−major−mode 'org−mode)

;; Make Org use ido−completing−read for most of its completing prompts.
(setq org−completion−use−ido t)

;; 执行免应答( codeEval code without ) confirm
(setq org−confirm−babel−evaluate nil)


;; Auctex
(setq TeX−auto−save t)
(setq TeX−parse−self t)
;(setq−default TeX−master nil)


;; set default tex engine to xetex, which has better support for chinese
(setq TeX-engine 'xetex)


;;; adapted to use latexmk 4.20 or higher, don't want this one, set default engine to be XeTeX
;(defun my-auto-tex-cmd (backend)
;  "When exporting from .org with latex, automatically run latex, pdflatex, or xelatex as appropriate, using latexmk."
;  (let ((texcmd)))
;  ;; default command: oldsyte alex via dvi
;  (setq texcmd "latexmk -dvi -pdfps -quiet %f")
;  ;; pdflatex -> .pdf
;  (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
;      (setq texcmd "latex -pdf -quiet %f"))
;  ;; xelatx -> .pdf
;  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
;      (setq texcmd "latexmk -pdflatex=xelatex -shell-escape -pdf -quiet %f"))
;  (setq org-latex-pdf-process (list texcmd)))
;(add-hook 'org-export-before-parsing-hook 'my-auto-tex-cmd)


;; generate pdf rather then dvi
(setq TeX-PDF-mode t)
(setq latex-run-command 'xetex)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; auto enable cdlatex-mode when use auctex
(setq reftex-plug-into-AUCTeX t)

;; add "-shell-escape" option to LaTeX command, which is needed by packages like minted
(eval-after-load "tex"
  '(setcdr (assoc "LaTeX" TeX-command-list)
           '("%`%l%(mode) -shell-escape%' %t"
             TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
           )
  )


;;; for .tex file modifications   ;;; I set this through emacs menu instead
;(setq tex-compile-commands '(("xelatex %r")))
;(setq tex-command "xelatex")
;(setq-default TeX-engine 'xelatex)


(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}    ;;; use the article class by default
                 [NO-DEFAULT-PACKAGES]
                 [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")))   ;;; map org headlines and lists to latex sections

(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;;; \\usepackage[utf8]{inputenc}   ;; I added this one, may need to remove later. can NOT add this one
;;; \\usepackage{fancyhdr}  ;;; 459
;;; \\setCJKmainfont{SimSun} SimSun does NOT work
;;; \\usepackage{xeCJK}   ;;; after xcolor 不再显示中文
;;; \\setmainfont{STSong} ;;; after fontspec
(add-to-list 'org-latex-classes
                  '("cn-article"
                    "\\documentclass[9pt,b5paper]{article}
\\usepackage{fontspec}
\\setmainfont{STSong} 
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\setCJKmainfont{STSong}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=0cm,right=0cm,top=0cm,bottom=0cm}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{listings}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;\\lstset{language=c++,numbers=left,numberstyle=\tiny,basicstyle=\ttfamily\tiny,tabsize=4,frame=none,escapeinside=``,extendedchars=false}


(add-to-list 'org-latex-classes
             '("org-article"
               "\\documentclass{org-article}
                 [NO-DEFAULT-PACKAGES]
                 [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
          '("koma-article"
             "\\documentclass{scrartcl}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;\\usepackage[unicode,dvipdfm]{hyperref}  ;; still don't want to use this one, so let it be


;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

;; want one for book
;;; http://wenku.baidu.com/view/3d20436caf1ffc4ffe47ac25.html
;;; \\setCJKmainfont{SimSun}  SimSun
(add-to-list 'org-latex-classes
             '("book"
               "\\documentclass[12pt]{book}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\setCJKmainfont{STSong} 
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=1.5cm,right=1.5cm,top=2cm,bottom=1.5cm}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{listings}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
;               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )

(add-to-list 'org-latex-classes
             '("cjk-article"
               "\\documentclass[10pt,b5paper]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{lmodern}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=0cm,right=0cm,top=0cm,bottom=0cm}
\\usepackage{listings}
\\lstset[language=c++,numbers=left,numberstyle=\tiny,basicstyle=\ttfamily\small,tabsize=4,frame=none,escapeinside=``,extendedchars=false]{listings}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
linkcolor=blue,
urlcolor=blue,
menucolor=blue]{hyperref}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}  
\\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}  
\\setmonofont{Bitstream Vera Sans Mono}  
\\newcommand\\fontnamemono{AR PL UKai CN}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%中文字体
\\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
marginparsep=7pt, marginparwidth=.6in}
\\definecolor{foreground}{RGB}{220,220,204}%浅灰
\\definecolor{background}{RGB}{62,62,62}%浅黑
\\definecolor{preprocess}{RGB}{250,187,249}%浅紫
\\definecolor{var}{RGB}{239,224,174}%浅肉色
\\definecolor{string}{RGB}{154,150,230}%浅紫色
\\definecolor{type}{RGB}{225,225,116}%浅黄
\\definecolor{function}{RGB}{140,206,211}%浅天蓝
\\definecolor{keyword}{RGB}{239,224,174}%浅肉色
\\definecolor{comment}{RGB}{180,98,4}%深褐色

\\definecolor{comdil}{RGB}{111,128,111}%深灰
\\definecolor{constant}{RGB}{220,162,170}%粉红
\\definecolor{buildin}{RGB}{127,159,127}%深铅绿
\\punctstyle{kaiming}
\\title{}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\pagestyle{fancy}
\\tolerance=1000
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;\\definecolor{doc}{RGB}{175,215,175}%浅铅绿
;\\usepackage{CJKutf8}
;\\begin{CJK}{UTF8}{gbsn}

(setq org-latex-packages-alist '(
    (""   "CJK"   t)
    (""     "indentfirst"  nil)
    ("pdftex"     "graphicx"  t)
    (""     "fancyhdr" nil)
    ("CJKbookmarks=true"     "hyperref"  nil)
"%% Define a museincludegraphics command, which is
%%   able to handle escaped special characters in image filenames.
\\def\\museincludegraphics{%
  \\begingroup
  \\catcode`\\\|=0
  \\catcode`\\\\=12
  \\catcode`\\\#=12
  \\includegraphics[width=0.75\\textwidth]
}"))

;(load-file "~/.emacs.d/org-presie.el")

;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置)
(setq org-export-latex-listings t)
;; Options for \lset command（reference to listing Manual)
(setq org-export-latex-listings-options
      '(
        ("basicstyle" "\\color{foreground}\\small\\mono")           ; 源代码字体样式
        ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; 关键词字体样式
        ("identifierstyle" "\\color{doc}\\small\\mono")
        ("commentstyle" "\\color{comment}\\small\\itshape")         ; 批注样式
        ("stringstyle" "\\color{string}\\small")                    ; 字符串样式
        ("showstringspaces" "false")                                ; 字符串空格显示
        ("numbers" "left")                                          ; 行号显示
        ("numberstyle" "\\color{preprocess}")                       ; 行号样式
        ("stepnumber" "1")                                          ; 行号递增
        ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
        ("tabsize" "4")                                             ; TAB等效空格数
        ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
        ("breaklines" "true")                                       ; 自动断行
        ("breakatwhitespace" "true")                                ; 只在空格分行
        ("showspaces" "false")                                      ; 显示空格
        ("columns" "flexible")                                      ; 列样式
        ("frame" "single")                                          ; 代码框：阴影盒
        ("frameround" "tttt")                                       ; 代码框： 圆角
        ("framesep" "0pt")
        ("framerule" "8pt")
        ("rulecolor" "\\color{background}")
        ("fillcolor" "\\color{white}")
        ("rulesepcolor" "\\color{comdil}")
        ("framexleftmargin" "10mm")
        ))
(setq org-src-preserve-indentation t)

(setq org-todo-keywords
      '((type "job(j!)" "emacs(s!)" "git(g!)" "clanguage(c!)" "homework(h!)" "interview(i!)")
      (sequence "PENDING(p!)" "TODO(t!)" "|" "DONE(d!)" "ABORT(a@/!)")
))

(setq org-todo-keyword-faces
  '(("job" .      (:background "red" :foreground "white" :weight bold))
    ("emacs" .      (:background "white" :foreground "red" :weight bold))
    ("git" .      (:background "white" :foreground "red" :weight bold))
    ("clanguage" .      (:background "white" :foreground "red" :weight bold))
    ("interview" .      (:foreground "MediumBlue" :weight bold)) 
    ("PENDING" .   (:background "LightGreen" :foreground "gray" :weight bold))
    ("TODO" .      (:background "DarkOrange" :foreground "black" :weight bold))
    ("DONE" .      (:background "azure" :foreground "Darkgreen" :weight bold)) 
    ("ABORT" .     (:background "gray" :foreground "black"))
))

;; 优先级范围和默认任务的优先级
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?E)
(setq org-default-priority ?E)
;; 优先级醒目外观
(setq org-priority-faces
  '((?A . (:background "red" :foreground "white" :weight bold))
    (?B . (:background "DarkOrange" :foreground "white" :weight bold))
    (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
    (?D . (:background "DodgerBlue" :foreground "black" :weight bold))
    (?E . (:background "SkyBlue" :foreground "black" :weight bold))
))


;; outline-mode
(add-to-list 'auto-mode-alist
  '("\\.outline\\'" . outline-mode))
(require 'outline-presentation)
(add-hook 'outline-presentation-mode-hook
          (lambda () (text-scale-increase 3)))


(require 'exec-path-from-shell)
(add-to-list 'exec-path "/usr/local/texlive/2015/bin/x86_64-darwin/")

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
   [?# ?! ?/ ?u ?s ?r ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n return return])
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
(require 'cedet)
;semantiec基本配置
;见http://emacser.com/built-in-cedet.htm
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				  global-semanticdb-minor-mode
				  global-semantic-idle-summary-mode
				  global-semantic-mru-bookmark-mode))
(semantic-mode 1)
(global-semantic-highlight-edits-mode (if window-system 1 -1))
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-show-parser-state-mode 1)
;代码跳转和官方版本一样还是用semantic-ia-fast-jump命令，不过在emacs-23.2里直接用这个命令可能会报下面的错误,所以运行时这个feature没被load进来，我们需要自己load一下：
(require 'semantic/analyze/refs)
(global-ede-mode t)



;;; 解压缩放入load-path目录。然后load，require。
;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")
;(require 'font-lock)
;(require 'ecb)
;(require 'ecb-autoloads)
;(require 'jde)

;(add-to-list 'ac-modes 'jde-mode)
(add-to-list 'ac-modes 'java-mode)
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

(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)
(defun joaot/delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))

(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary, in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t));;; 1)
;(setq soft-wrap-lines t) ;; for chinese
;(setq debug-on-error t)

(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet                                                        
            (make-variable-buffer-local 'yas/trigger-key)
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field)  ;;; next-field-group, no
            ;; flyspell mode for spell checking everywhere                      
	    ;;            (flyspell-mode 1)                                                 
            ;; auto-fill mode on      
	    (soft-wrap-lines t) ;;; this one works
            (auto-fill-mode 1)))
(add-to-list 'ac-modes 'org-mode)

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
(global-set-key [(f4)] 'speedbar-get-focus) 
(speedbar 1)

;;;; for speedbar
;;;; 在site-lisp/subdirs.el中加入 
;(add-to-list 'load-path "~/.emacs.d/elpa/cedet-1.1/speedbar") 
;(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t) 
;(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t) 
;(global-set-key [(f4)] 'speedbar-get-focus) 
;;;如果你用Emacs,加入: 
;(define-key-after (lookup-key global-map [menu-bar tools]) 
;[speedbar] '("Speedbar" . speedbar-frame-mode) [calendar]) 
;(speedbar 1)
;;;; 设置它的出现位置 
;;;设置speedbar默认出现在左侧
;(add-hook 'speedbar-mode-hook
;        (lambda ()
;         (auto-raise-mode 1)
;         (add-to-list 'speedbar-frame-parameters '(top . 0))
;         (add-to-list 'speedbar-frame-parameters '(left . 10))
;         ))
;;显示所有文件
;(setq speedbar-show-unknown-files t)
;;;设置tags排列顺序为按照出现的先后次序排列
;(setq speedbar-tag-hierarchy-method '(speedbar-prefix-group-tag-hierarchy))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(jde-jdk-registry (quote (("1.6.0" . "/usr/lib/jvm/jdk1.8.0_25"))))
 '(jde-sourcepath (quote ("/home/jenny/lc/")))
 '(show-paren-mode t)
 '(speedbar-default-position (quote left-right))
 '(sr-speedbar-default-width 28)
 '(sr-speedbar-max-width 30)
 '(sr-speedbar-right-side nil))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

(fset 'mt
   "\346\342//\C-n\C-a")
(fset 'dt
   "\346\342\C-h\C-h\C-n\C-a")

(put 'downcase-region 'disabled nil)
