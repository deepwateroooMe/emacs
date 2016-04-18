 ;;; basic initialization, (require) non-ELPA packages, etc.
(setq package-enable-at-startup nil)

;;; Initialize & Install Package
(package-initialize)

;;; (require) your ELPA packages, configure them as normal
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(when (not package-archive-contents)
  (package-refresh-contents))
;(dolist (pkg jpk-packages)
;  (when (and (not (package-installed-p pkg))
;           (assoc pkg package-archive-contents))
;    (package-install pkg)))
(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `jpk-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x jpk-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))


;(setq default-directory "~/.emacs.d/")
(setq default-directory "~/120/lab5/")
;(setq default-directory "~/docu/gs/")
;(setq default-directory "~/docu/541/")
;(setq default-directory "~/docu/iv/lc/")
;(setq default-directory "~/docu/cv/cs/")

;(setq default-directory "~/499//")
;(setq default-directory "~/android/FirstApp/src/dev/sudoku/")
;(setq default-directory "~/android/FirstApp/res/layout/")
;(setq default-directory "~/android/FirstApp/res/values/")


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
      '(
;(top . 0)(left . 800)(height . 85)(width . 86)(menubar-lines . 20)(tool-bar-line . 0)))
;(top . 0)(left . 800)(height . 85)(width . 100)(menubar-lines . 20)(tool-bar-line . 0)))
(top . 0)(left . 2100)(height . 85)(width . 86)(menubar-lines . 20)(tool-bar-line . 0))) ;;; right most

;;; 编码设置 begin
(set-language-environment 'Chinese-GB)
;; default-buffer-file-coding-system变量在emacs23.2之后已被废弃，使用buffer-file-coding-system代替
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)
;; 另外建议按下面的先后顺序来设置中文编码识别方式。
;; 重要提示:写在最后一行的，实际上最优先使用; 最前面一行，反而放到最后才识别。
;; utf-16le-with-signature 相当于 Windows 下的 Unicode 编码，这里也可写成
;; utf-16 (utf-16 实际上还细分为 utf-16le, utf-16be, utf-16le-with-signature等多种)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)
;(prefer-coding-system 'utf-16le-with-signature)
(prefer-coding-system 'utf-16)
;; 新建文件使用utf-8-unix方式
;; 如果不写下面两句，只写
;; (prefer-coding-system 'utf-8)
;; 这一句的话，新建文件以utf-8编码，行末结束符平台相关
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)
;; 编码设置 end


;;; Meta
(global-set-key "\M-p" 'replace-string)
(global-set-key "\M-g" 'goto-line)
;(global-set-key "\M- " 'set-mark-command)
;(global-set-key "\M-\C-h" 'backward-kill-word)
;(global-set-key "\M-\C-r" 'query-replace)
;(global-set-key "\M-h" 'help-command)

;;设置括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;; 设置默认tab宽度为4
(setq tab-width 4
      indent-tabs-mode t
      c-basic-offset 4)

;;设置HTML-mode的默认tab宽度为4
;(add-hook 'html-mode-hook
;	  (lambda()
;	    (setq sgml-basic-offset 4)
;	    (setq indent-tabs-mode t)))


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
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
;;;;(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用


(add-to-list 'auto-mode-alist '("\\.l\\'" . c-mode))
;(add-to-list 'auto-mode-alist '("\\.y\\'" . c-mode))
(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)
;(add-to-list 'latex-math-preview-text-symbol-datasets
;	     latex-math-preview-textcomp-symbol-data)
;(add-to-list 'latex-math-preview-text-symbol-datasets
;	     latex-math-preview-pifont-zapf-dingbats-symbol-data)
;(add-to-list 'latex-math-preview-text-symbol-datasets
;	     latex-math-preview-pifont-symbol-fonts-symbol-data)
(setq latex-math-preview-command-path-alist
      '((latex . "/usr/bin/latex") (dvipng . "/usr/bin/dvipng") (dvips . "/usr/bin/dvips")))
;(setq tex-dvi-view-command &quot;xdvi&quot;)



;;;自动补全
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 2) ;; 输入4个字符才开始补全
(global-set-key "\M-/" 'auto-complete)  ;; 补全的快捷键，用于需要提前补全
;;; Show menu 0.8 second later
(setq ac-auto-show-menu 0.3)
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

;;;;;;;;;; for LATEX:
;(load-file "~/.emacs.d/auto-complete-yasnippet.el")
;(load-file "~/.emacs.d/auto-complete-auctex.el")

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
;(load "/usr/local/emacs23/my_plus/cedet/common/cedet" nil t)
(autoload 'company-mode "company" nil t)
(setq company-idle-delay t)


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
(require 'yasnippet-bundle)


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


;;; autopair 
(add-to-list 'load-path "~/.emacs.d/") ;; comment if autopair.el is in standard load path 
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;;; autorevert buffer
(load-file "~/.emacs.d/autorevert.el")
(global-auto-revert-mode 1)


;;; org-mode
(setq load-path (cons "~/.emacs.d/elpa/org-20140901" load-path))
(require 'ox)
(require 'org-install)
(require 'ox-publish)
(require 'ox-latex)
;(require 'org-export-latex)
(require 'ox-beamer)
(require 'ox-md)
(require 'ox-org)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 
	  (lambda ()
	    (setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题 
	    (setq org-startup-indented t)
	    (setq org-startup-truncated nil)
            (setq auto-indent-assign-indent-level 4)))

;; iimage mode
(load-file "~/.emacs.d/iimage.el")
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

;(setq org-latex-to-pdf-process
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode %b"
	 "xelatex -interaction nonstopmode %b"))

;(setq org-latex-pdf-process (quote ("texi2dvi -p -b -V %f")))

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

(add-to-list 'org-latex-classes
                  '("cn-article"
                    "\\documentclass[9pt,b5paper]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
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
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;\\lstset{language=c++,numbers=left,numberstyle=\tiny,basicstyle=\ttfamily\tiny,tabsize=4,frame=none,escapeinside=``,extendedchars=false}

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

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
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'auto-mode-alist
  '("\\.outline\\'" . outline-mode))
(require 'outline-presentation)
(add-hook 'outline-presentation-mode-hook
          (lambda () (text-scale-increase 3)))


(add-to-list 'load-path "~/.emacs.d/")
(require 'exec-path-from-shell)
;(require 'expand-region)
(require 'ido-ubiquitous)
(require 'undo-tree)

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
;(setq 'load-path "~/.emacs.d/")
;(require 'org-ac)
(load-file "~/.emacs.d/org-ac.el")
(org-ac/config-default)

;;; auto-indent-mode
;(load-file "~/.emacs.d/auto-indent-mode.el")
;(auto-indent-global-mode t)
;(add-to-list 'auto-indent-known-indent-levels 'c-basic-offset)
;(setq auto-indent-assign-indent-level 4)
;(setq auto-indent-newline-function 'newline-and-indent)



;;; copy from https://github.com/purcell/emacs.d/blob/master/init.el

;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time
;(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;
;;;----------------------------------------------------------------------------
;;; Bootstrap config
;;;----------------------------------------------------------------------------
;;(require 'init-compat)
;;(require 'init-utils)
;;(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;;(require 'init-elpa)      ;; Machinery for installing required packages
;;(require 'init-exec-path) ;; Set up $PATH
;
;;;----------------------------------------------------------------------------
;;; Allow users to provide an optional "init-preload-local.el"
;;;----------------------------------------------------------------------------
;(require 'init-preload-local nil t)
;
;;;----------------------------------------------------------------------------
;;; Load configs for specific features and modes
;;;----------------------------------------------------------------------------
;
;;(require-package 'wgrep)
;;(require-package 'project-local-variables)
;;(require-package 'diminish)
;;(require-package 'scratch)
;;(require-package 'mwe-log-commands)
;
;(require 'init-flycheck)
;(require 'init-ido)
;(require 'init-hippie-expand)
;(require 'init-auto-complete)
;(require 'init-org)
;(require 'init-html)
;(require 'init-css)
;(require 'init-python-mode)
;
;(when (>= emacs-major-version 24)
;  (require 'init-clojure-cider))
;(require 'init-common-lisp)
;
;(when *spell-check-support-enabled*
;  (require 'init-spelling))
;
;;(require 'init-marmalade)
;;(require 'init-misc)
;
;;(require 'init-dash)
;;(require 'init-ledger)
;;; Extra packages which don't require any configuration
;
;;(require-package 'gnuplot)
;;(require-package 'lua-mode)
;;(require-package 'htmlize)
;;(require-package 'dsvn)
;;(require-package 'regex-tool)
;
;;;----------------------------------------------------------------------------
;;; Allow access from emacsclient
;;;----------------------------------------------------------------------------
;(require 'server)
;(unless (server-running-p)
;  (server-start))
;
;;;----------------------------------------------------------------------------
;;; Variables configured via the interactive 'customize' interface
;;;----------------------------------------------------------------------------
;(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;(when (file-exists-p custom-file)
;  (load custom-file))
;
;;;----------------------------------------------------------------------------
;;; Allow users to provide an optional "init-local" containing personal settings
;;;----------------------------------------------------------------------------
;(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
;  (error "Please move init-local.el to ~/.emacs.d/lisp"))
;(require 'init-local nil t)
;
;;;----------------------------------------------------------------------------
;;; Locales (setting them earlier in this file doesn't work in X)
;;;----------------------------------------------------------------------------
;(require 'init-locales)
;
;(add-hook 'after-init-hook
;          (lambda ()
;            (message "init completed in %.2fms"
;                     (sanityinc/time-subtract-millis after-init-time before-init-time))))
;
;(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: 
;; End:


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

(fset 'lst
   [return up ?\\ ?b ?e ?g ?i ?n ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} ?\[ ?l ?a ?n ?g ?u ?a ?g ?e ?= ?C ?+ ?+ backspace backspace backspace ?P ?y ?t ?h ?o ?n ?\] return ?\\ ?e ?n ?d ?\{ ?l ?s ?t ?l ?i ?s ?t ?i ?n ?g ?\} ?\C-a])

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
