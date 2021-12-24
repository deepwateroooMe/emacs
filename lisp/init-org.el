;;; org-mode
(global-linum-mode 1)
(setq load-path (cons "C:/Users/blue_/AppData/Roaming/.emacs.d/elpa/org-20140901/" load-path))
(require 'ox)
(require 'org-install)
(require 'ob-ditaa)  
(require 'ox-publish)
(require 'ox-latex)
(require 'ox-beamer)
(require 'ox-md)
(require 'ox-org)
(setq org-src-fontify-natively t)  ;;; 要对代码进行语法高亮   


;;; shift region for source code trials:
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

(eval-after-load 'org
  '(progn
     (define-key org-mode-map (kbd "<C-S-left>") nil)
     (define-key org-mode-map (kbd "<C-S-right>") nil)
     ))
;  '(define-key org-mode-map [(C-right)] 'shift-right))
;(eval-after-load 'org
;  '(define-key org-mode-map [(C-left)] 'shift-left))
;(global-set-key [C-S-right] 'shift-right)
;(global-set-key [C-S-left] 'shift-left)


(defun org-show-two-levels ()
  (interactive)
  (org-content 3))

(add-hook 'org-mode-hook
          (lambda ()
            ;; (define-key org-mode-map "C-c m" 'org-show-two-levels)))
	    (global-set-key (kbd "C-c m") 'org-show-two-levels))) ; very useful

(setq org-link-file-path-type 'relative)


(setq org-latex-listings t)                           ;;; added this one
(add-to-list 'org-latex-packages-alist '("" "color"))
(add-to-list 'org-latex-packages-alist '("" "minted")) ; 转化为minted时自动添加minted包     ;;; added this one
(setq org-latex-listings 'minted)                           ;;; added this one
;;; add frame and line number for source code
(setq org-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "false"))) ;; "true"
;; (setq org-latex-minted-options
;;       '(
;; ; ("frame" "single")
;;   ("linenos" "true")))
(setq org-export-latex-minted t)                            ;;; added this one

;; 中文与英文字体设置
;; Setting English Font
;; (set-face-attribute
;;  'default nil :font "Monaco 14")
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "WenQuanYi Micro Hei Mono" :size 16)))


(defvar md/font-size 100) ;; 125
(defun md/set-default-font ()
  (interactive)
  (set-face-attribute 'default nil
                      :height md/font-size
                      ;; :family "Inconsolata-dz for Powerline")
                      :family "Inconsolata")
  (setq-default line-spacing 0.1)
  (run-hooks 'after-setting-font-hook 'after-setting-font-hooks))

(md/set-default-font)

;; Specify default packages to be included in every tex file, whether pdflatex or xelatex
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)))

(defun my-org-screenshot (basename)
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive "sScreenshot name: ")
  (if (equal basename "")
      (setq basename (format-time-string "%Y%m%d_%H%M%S")))
  (setq filename
        (concat (file-name-directory (buffer-file-name))
                "pic/"
                (file-name-base (buffer-file-name))
                "_"
                basename
                ".png"))
  (call-process "screencapture" nil nil nil "-s" filename)
  (insert "#+CAPTION:")
  (insert basename)
  (insert "\n")
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))
(global-set-key "\M-s" 'my-org-screenshot)



;;------------------------------------------------------------------------------
;;;; Org Mode: Babel: Kotlin  没有弄好，不起作用
;;------------------------------------------------------------------------------

;; (init-message 3 "Org Mode: Babel: Kotlin") 

(use-package ob-kotlin
  ;;:quelpa (ob-kotlin)
  :straight t
  :after (org kotlin-mode)
  :commands (org-babel-execute:kotlin)
  :functions (flycheck-mode
              kotlin-send-buffer
              org-babel-kotlin-command)
  :defines (org-babel-kotlin-compiler)
  :config
  ;; customize org/babel for kotlin so it works
  (defcustom org-babel-kotlin-command "kotlin"
    "Name of the kotlin command.
May be either a command in the path, like kotlin or an absolute
path name, like /usr/local/bin/kotlin parameters may be used,
like kotlin -verbose"
    :group 'org-babel
    :type 'string)

  (defcustom org-babel-kotlin-compiler "kotlinc"
    "Name of the kotlin compiler.
May be either a command in the path, like kotlinc or an absolute
path name, like /usr/local/bin/kotlinc parameters may be used,
like kotlinc -verbose"
    :group 'org-babel
    :type 'string)

  (defun org-babel-execute:kotlin (body params)
    "If main function exists, then compile code and run jar
otherwise, run code in `kotlin-repl'."
    (let* ((classname (or (cdr (assq :classname params)) "main"))
           ;;(packagename (file-name-directory classname))
           (src-file (org-babel-temp-file classname ".kt"))
           (jar-file (concat (file-name-sans-extension src-file) ".jar"))
           (cmpflag (or (cdr (assq :cmpflag params)) ""))
           (cmdline (or (cdr (assq :cmdline params)) ""))
           (full-body (org-babel-expand-body:generic body params)))
      (if (or (string-match "fun main(args: Array<String>)" full-body)
              (string-match "fun main()" full-body))
          (progn
            (with-temp-file src-file (insert full-body))
            (org-babel-eval
             (concat org-babel-kotlin-compiler " " cmpflag " " src-file " -include-runtime -d " jar-file) "")
            (message (org-babel-eval (concat org-babel-java-command " " cmdline " -jar " jar-file) ""))
            )
        (with-temp-buffer
          (insert body)
          (kotlin-send-buffer))))))



(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 'word-like-count-mode)
(add-hook 'org-mode-hook
    (lambda ()
      (setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题
      (setq org-startup-indented t)
      (setq org-startup-truncated nil)
;            (setq auto-indent-assign-indent-level 4)))
            (setq auto-indent-assign-indent-level 4)
            ;; yasnippet
;            (make-variable-buffer-local 'yas/trigger-key)
;     (org-set-local 'yas/trigger-key [tab]) ; original 
;     (org-set-global 'yas/trigger-key [tab])     
;     (setq yas-insert-snippet)
;            (define-key yas/keymap [tab] 'yas/next-field)  ;;; next-field-group, no
            ;; flyspell mode for spell checking everywhere
      ;;(flyspell-mode 1)
            ;; auto-fill mode on
      (soft-wrap-lines t) ;;; this one works
            (auto-fill-mode 1)))
(setq org-startup-truncated nil)
;(add-to-list 'ac-modes 'org-mode)


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
      '("xelatex -shell-escape -interaction nonstopmode %f"
        "xelatex -shell-escape -interaction nonstopmode %f"))
; 上面xelatex命令的参数-shell-escape是为了调用minted包, 如果不加这个参数,代码高亮这部分会出错

;; 默认主模式为 org−mode
;(setq default−major−mode 'org−mode)

;; Make Org use ido−completing−read for most of its completing prompts.
(setq org−completion−use−ido t)

;; 执行免应答( codeEval code without ) confirm
(setq org−confirm−babel−evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))

;; Auctex
(setq TeX−auto−save t)
(setq TeX−parse−self t)
;(setq−default TeX−master nil)


;; set default tex engine to xetex, which has better support for chinese
(setq TeX-engine 'xetex)
;(setq TeX-engine 'xelatex)


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
             TeXlinu-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
           )
  )


;;; Org export to LaTeX default headers.
;; set LaTeX default font
(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setmainfont{DejaVu Sans}"))
(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setsansfont{DejaVu Serif}"))
(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setmonofont{DejaVu Sans Mono}"))
      ;; (concat org-format-latex-header "\n" "\\setmonofont{JetBrains Mono}"))


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
;;; \\setmainfont{STSong} ;;; after fontspec 这两行的作用是在生成的.tex文件中加入两行引入xeCJK包, 并设置中文的字体,这样在用xelatex编译.tex文件就不会出错
;\\setmainfont{STSong} ; after fontspec

;\\usepackage{longtable} ; 20170821 to install later
;\\setCJKmainfont[BoldFont = Songti SC Bold, ItalicFont = STFangsong]{Songti SC}
(add-to-list 'org-latex-classes
                  '("cn-article-ori"
                    "\\documentclass[9pt, b5paper]{article}
\\usepackage{fontspec}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage[slantfont,boldfont]{xeCJK}
\\setCJKmainfont[BoldFont = Heiti SC, ItalicFont = STFangsong]{STSong}
\\setCJKsansfont{STHeiti}
\\setCJKmonofont{STFangsong}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=0.1cm,right=0.1cm,top=0.1cm,bottom=0.1cm}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{listings}
\\usepackage{minted}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;\\usepackage[slantfont,boldfont]{xeCJK}
;\\setCJKmainfont[BoldFont = Heiti SC, ItalicFont = STFangsong]{STSong}
;\\setCJKsansfont{STHeiti}
;\\setCJKmonofont{STFangsong}

;\\usepackage{longtable} ; 20170821 to install later
;\\setCJKmainfont[BoldFont = Songti SC Bold, ItalicFont = STFangsong]{Songti SC}
;; \\usepackage{fontspec}
;; \\setmainfont[Ligatures=TeX]{Georgia}
;; \\setsansfont[Ligatures=TeX]{Arial}

;; :family "Inconsolata")
;; \\setsansfont{DejaVu Sans}
;; \\setmonofont{DejaVu Sans Mono}
;; \\usemintedstyle{monokai}     ;;%% sets default for all source-code blocks
;; \\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}

;; \\usepackage{listings}
;; \\lstset{basicstyle=\ttfamily\small}
;; \\usepackage{fontspec}
;; \\setmainfont{Linux Libertine O}
;; \\setsansfont{DejaVu Sans}
;; \\setmonofont[Scale=0.75]{DejaVu Sans Mono}
;; \\usemintedstyle{emacs}
;; \\usepackage{listings}
;; \\lstset{basicstyle=\ttfamily\small}
;; \\lstset{basicstyle=\\scriptsize\\ttfamily}
;; \\lstset[language=java,numbers=left,numberstyle=\tiny,basicstyle=\ttfamily\small,tabsize=4,frame=none,escapeinside=``,extendedchars=false]{listings}



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


(add-to-list 'org-latex-classes
             '("cn-article"
               "\\documentclass[9pt, b5paper]{article}
\\usepackage[UTF8]{ctex}
\\usepackage{xltxtra}
\\usepackage{bera}
\\usepackage[T1]{fontenc}
\\usepackage[scaled]{beraserif}
\\usepackage[scaled]{berasans}
\\usepackage[scaled]{beramono}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=1.2cm,right=1.2cm,top=1.5cm,bottom=1.2cm}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{minted}
\\newminted{common-lisp}{fontsize=\footnotesize}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; want one for book
;;; http://wenku.baidu.com/view/3d20436caf1ffc4ffe47ac25.html
;;; \\setCJKmainfont{SimSun}  SimSun
;\\usepackage{xeCJK}
;\\setCJKmainfont{STSong}
(add-to-list 'org-latex-classes
             '("book"
               "\\documentclass[9pt, b5paaper]{book}
\\usepackage[UTF8]{ctex}
\\usepackage{xltxtra}
\\usepackage{bera}
\\usepackage[T1]{fontenc}
\\usepackage[scaled]{beraserif}
\\usepackage[scaled]{berasans}
\\usepackage[scaled]{beramono}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{geometry}
\\geometry{left=1.2cm,right=1.2cm,top=1.5cm,bottom=1.2cm}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{minted}
\\newminted{common-lisp}{fontsize=\footnotesize}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
               ;; ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )
;; \\usepackage{fontspec}
;; \\usepackage{graphicx}
;; \\usepackage{xcolor}
;; \\usepackage{longtable}
;; \\usepackage{float}
;; \\usepackage{textcomp}
;; \\usepackage{geometry}
;; \\geometry{left=1.2cm,right=1.2cm,top=1.5cm,bottom=1.2cm}
;; \\usepackage{multirow}
;; \\usepackage{multicol}
;; \\usepackage{listings}
;; \\usepackage{algorithm}
;; \\usepackage{algorithmic}
;; \\usepackage{latexsym}
;; \\usepackage{natbib}
;; \\usepackage{fancyhdr}
;; \\usepackage{listings}
;; \\usepackage{minted}
;; \\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}


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


;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置) ; 31
;(setq org-export-latex-listings t)
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

(setq org-publish-project-alist
      '(
        ("org-files"
         :base-directory "./"
         :base-extension "org"
         :publishing-directory "./"
        ;:publishing-function org-html-publish-to-html
         :publishing-function org-latex-pdf-process
        ("example" :components ("org-files"))
        )
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


;;; for iimage org-mode
(setq org-image-actual-width nil)


;; outline-mode  
(add-to-list 'auto-mode-alist
  '("\\.outline\\'" . outline-mode))
(require 'outline-presentation)
(add-hook 'outline-presentation-mode-hook
          (lambda () (text-scale-increase 3)))


;for latex
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2015/bin/x86_64-darwin"))
(setq exec-path (append exec-path '("d:/texlive/2018/bin/win32")))

; for emacs zsh
(setenv "ESHELL" (expand-file-name "~/.eshell"))


;;; all the org-mode macros

(fset 'und  ;;; "_" to be "\_"
   [?\M-x ?r ?e ?p ?l ?  ?s return ?_ return ?\\ ?_ return])
; org-mode
(fset 'cp
   "#+caption: ")

;;; for org-mode
(fset 'oo
   [?# ?+ ?t ?i ?t ?l ?e ?: ?  return ?# ?+ ?a ?u ?t ?h ?o ?r ?: ?  ?H ?e ?y ?a ?n ?  ?H ?u ?a ?n ?g return ?# ?+ ?s ?t ?a ?r ?t ?u ?p ?: ?  ?b ?e ?a ?m ?e ?r return ?# ?+ ?l ?a ?t ?e ?x ?_ ?c ?l ?a ?s ?s ?: ?  ?b ?e ?a ?m ?e ?r return ?# ?+ ?o ?p ?t ?i ?o ?n ?s ?: ?  ?H ?: ?1 ?  ?n ?u ?m ?: ?t ?  ?t ?o ?c ?: ?n ?i ?l ?\C-p ?\C-p ?\C-p ?\C-p])
;#+title: 
;#+author: Heyan Huang
;#+startup: beamer
;#+latex_class: beamer
;#+options: H:1 num:t toc:nil

;#+latex_class: cn-article
;#+title: 
;#+author: deepwaterooo
(fset 'ocn
      [?# ?+ ?l ?a ?t ?e ?x ?_ ?c ?l ?a ?s ?s ?: ?  ?c ?n ?- ?a ?r ?t ?i ?c ?l ?e return ?# ?+ ?t ?i ?t ?l ?e ?: ?  return ?# ?+ ?a ?u ?t ?h ?o ?r ?: ?  ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o return return])


(provide 'init-org)
