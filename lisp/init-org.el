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

;;; org-mode auto configure mode
(setq interpreter-mode-alist
      (cons '("org" . org-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))


(setq org-src-fontify-natively t)  ;;; 要对代码进行语法高亮
(setq org-src-tab-acts-natively t)
(setq linum-mode t)

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


;;; org mode source code comment with //
(defun my/org-comment-tweak ()
  (setq-local comment-start "// "))
;; (defun my/org-comment-dwim (&optional arg)
;;   (interactive "P")
;; (or (org-babel-do-key-sequence-in-edit-buffer (kbd "M-;"))
;; ;;   (setq-local comment-start "// ")
;;   (comment-dwim arg))
;; make `C-c C-v C-x M-;' more convenient
;; (define-key org-mode-map
;;   (kbd "M-;") 'my/org-comment-dwim)

(eval-after-load 'org
  '(progn
     (define-key org-mode-map (kbd "<C-S-left>") nil)
     (define-key org-mode-map (kbd "<C-S-right>") nil)
     (add-hook 'org-mode-hook #'my/org-comment-tweak)
     ))

;;; 因为陈桥全角半角符号容易失控,写* - 很容易写成全角,所以改成两个 键操作 减少 误操作
;;; // comment for csharp-mode
(fset 'cmt
      (kmacro-lambda-form [?\C-x ?1 ?  ?- ? ] 0 "%d"))
(global-set-key (kbd "C-j") 'cmt) ;;; 不想再设置全局,因为不同mode下会有不同的实现
(put 'cmt 'kmacro t)
;; (eval-after-load 'csharp
;;   '(define-key csharp-mode-map [(C-j)] 'cmt))
(fset 'cmtitem
      (kmacro-lambda-form [?\C-x ?1 ?* ] 0 "%d"))
;;;; BUG: 这里有个副作用:把我的csharp-mode C-c f多加了一个＊(应该是由C-i在f  macro中引起的，改掉了)，需要去除
(global-set-key (kbd "C-m") 'cmtitem) ;;; 不想再设置全局,因为不同mode下会有不同的实现
(put 'cmtitem 'kmacro t)


(defun org-show-two-levels ()
  (interactive)
  (org-content 3))
(add-hook 'org-mode-hook
          (lambda ()
	    (global-set-key (kbd "C-c m") 'org-show-two-levels))) ; very useful

(setq org-link-file-path-type 'relative)


(setq org-latex-listings t)                           ;;; added this one
(add-to-list 'org-latex-packages-alist '("" "color"))
(add-to-list 'org-latex-packages-alist '("" "minted")) ; 转化为minted时自动添加minted包     ;;; added this one
(setq org-latex-listings 'minted)                           ;;; added this one

;;; add frame and line number for source code
(setq org-latex-minted-options
      '(
        ;; ("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "false"))) ;; "true"
;; (setq org-latex-minted-options
;;       '(
;; ; ("frame" "single")
;;   ("linenos" "true")))
(setq org-export-latex-minted t)                            ;;; added this one

;; 中文与英文字体设置
;; Setting English Font
(set-face-attribute
 ;; 'default nil :font "Monaco 14")
 'default nil :font "Inconsolata 16")
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    ;; (font-spec :family "WenQuanYi Micro Hei Mono" :size 12))) 
                    ;; (font-spec :family "Sarasa Mono Slab SC Semibold" :size 12))) 
                    (font-spec :family "SimHei" :size 12)))
;; '(default ((t (:inherit nil :extend nil :stipple nil :background "#181a26" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight semi-bold :height 113 :width normal :foundry "outline" :family "Sarasa Mono Slab SC Semibold"))))

;; (When (member "Monaco" (font-family-list))
;;   (set-frame-font "Monaco-11" t t))
;; (when (member "Noto Sans Mono" (font-family-list))
;;   (set-fontset-font t 'han "Noto Sans Mono"))


(defvar md/font-size 100) ;; 125 100
(defun md/set-default-font ()
  (interactive)
  (set-face-attribute 'default nil
                      :height md/font-size
                      :family "Inconsolata")
  (setq-default line-spacing 0.1)
  (run-hooks 'after-setting-font-hook 'after-setting-font-hooks))

(md/set-default-font)

;; Specify default packages to be included in every tex file, whether pdflatex or xelatex
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (let* ((powershell (executable-find "powershell.exe"))
         (basename (format-time-string "%Y%m%d_%H%M%S.png"))
         (filename (concat (file-name-base (buffer-file-name))
                           "_"
                           basename))
         (file-path-wsl (concat "./pic/" filename)))
;;; 必须先用第三方软件将截图复制到剪贴板，再调用这个命令自动生成图片和插入到org文件中，不是全自动
;;; (需要手动F1调用Snipaste[截图+自动复制到剪贴板，再emacs org 里C-i完成自动化，得两个步骤)；但仍差强人意
;;; 文件的自动保存地址，需要再自动化一下到当前文件所在的目录
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"F:/AndroidAppDevelopmentStudy/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/mixed_recently/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"l:/PersonalInfo/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/tetris3D/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/MyServer/pic/" filename "\\\")\""))
    (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/ET/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/unityGamesExamples/GeekServer/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"f:/andrp/KotlinSampleApp/pic/" filename "\\\")\""))
    ;; (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"l:/PersonalInfo/pic/" filename "\\\")\""))
    (org-indent-line)
     (insert (concat "\n[[" file-path-wsl "]]"))
     ))

;; (global-set-key (kbd "C-i") 'my-org-screenshot)
(global-set-key (kbd "M-s") 'my-org-screenshot)


;; :base-directory "./" ;;; 可以把这个想像成是比如：　/mnt/f/tetris3D/pic/　字符串 还是改天再弄这个，但是小心这里容易出错，因为文件目录还没有自动化
;; (substring base-directory 0 3)


(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
    (lambda ()
      (setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题
      (setq org-startup-indented t)
      (setq org-startup-truncated nil)
      ;; (soft-wrap-lines t) ;;; this one works
      ;; (auto-fill-mode 1) ;;; org里直线容易折断
      (gio-global-minor-mode 0) ;;; 这个会 break 掉 org-level-faces,暂时把它关掉
      (linum-mode 1)
      ))
;; (setq org-startup-truncated nil)

(load "folding" 'nomessage 'noerror)

;; iimage mode
(require 'iimage)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)


;; ;;------------------------------------------------------------------------------
;; ;;;; Org Mode: Babel: Kotlin  没有弄好，不起作用
;; ;;------------------------------------------------------------------------------
;; ;; (init-message 3 "Org Mode: Babel: Kotlin") 
;; (use-package ob-kotlin
;;   ;;:quelpa (ob-kotlin)
;;   :straight t ;;;; 它说这里错了,找不到straight
;;   :after (org kotlin-mode)
;;   :commands (org-babel-execute:kotlin)
;;   :functions (flycheck-mode
;;               kotlin-send-buffer
;;               org-babel-kotlin-command)
;;   :defines (org-babel-kotlin-compiler)
;;   :config
;;   ;; customize org/babel for kotlin so it works
;;   (defcustom org-babel-kotlin-command "kotlin"
;;     "Name of the kotlin command.
;; May be either a command in the path, like kotlin or an absolute
;; path name, like /usr/local/bin/kotlin parameters may be used,
;; like kotlin -verbose"
;;     :group 'org-babel
;;     :type 'string)

;;   (defcustom org-babel-kotlin-compiler "kotlinc"
;;     "Name of the kotlin compiler.
;; May be either a command in the path, like kotlinc or an absolute
;; path name, like /usr/local/bin/kotlinc parameters may be used,
;; like kotlinc -verbose"
;;     :group 'org-babel
;;     :type 'string)

;;   (defun org-babel-execute:kotlin (body params)
;;     "If main function exists, then compile code and run jar
;; otherwise, run code in `kotlin-repl'."
;;     (let* ((classname (or (cdr (assq :classname params)) "main"))
;;            ;;(packagename (file-name-directory classname))
;;            (src-file (org-babel-temp-file classname ".kt"))
;;            (jar-file (concat (file-name-sans-extension src-file) ".jar"))
;;            (cmpflag (or (cdr (assq :cmpflag params)) ""))
;;            (cmdline (or (cdr (assq :cmdline params)) ""))
;;            (full-body (org-babel-expand-body:generic body params)))
;;       (if (or (string-match "fun main(args: Array<String>)" full-body)
;;               (string-match "fun main()" full-body))
;;           (progn
;;             (with-temp-file src-file (insert full-body))
;;             (org-babel-eval
;;              (concat org-babel-kotlin-compiler " " cmpflag " " src-file " -include-runtime -d " jar-file) "")
;;             (message (org-babel-eval (concat org-babel-java-command " " cmdline " -jar " jar-file) ""))
;;             )
;;         (with-temp-buffer
;;           (insert body)
          ;; (kotlin-send-buffer))))))


;;; 使用一步生成 xelatexPDF
(setq org-latex-pdf-process 
      '("xelatex -shell-escape -interaction nonstopmode %f"
        "xelatex -shell-escape -interaction nonstopmode %f"))

(setq org−completion−use−ido t)

;; 执行免应答( codeEval code without ) confirm
(setq org−confirm−babel−evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))

(setq TeX−auto−save t)
(setq TeX−parse−self t)

(setq TeX-engine 'xetex)

(setq TeX-PDF-mode t)
(setq latex-run-command 'xetex)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; auto enable cdlatex-mode when use auctex
(setq reftex-plug-into-AUCTeX t)

(eval-after-load "tex"
  '(setcdr (assoc "LaTeX" TeX-command-list)
           '("%`%l%(mode) -shell-escape%' %t"
             TeXlinu-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
           )
  )

(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setmainfont{DejaVu Sans}"))
(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setsansfont{DejaVu Serif}"))
(setq org-format-latex-header
      (concat org-format-latex-header "\n" "\\setmonofont{DejaVu Sans Mono}"))

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

;; \\usepackage[UTF8]{ctex}
;; \\newminted{common-lisp}{fontsize=\footnotesize} ;; scriptsize
;; \\usepackage{xltxtra}
;; \\usepackage{bera}
(add-to-list 'org-latex-classes
             '("cn-article"
               "\\documentclass[9pt, b5paper]{article}
\\usepackage{xeCJK}
\\usepackage{minted}
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
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{geometry}
\\geometry{left=1.2cm,right=1.2cm,top=1.5cm,bottom=1.2cm}
\\newminted{common-lisp}{fontsize=\\footnotesize} 
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; want one for book
;; \\usepackage{xltxtra}
;; \\usepackage{bera}
(add-to-list 'org-latex-classes
             '("book"
               "\\documentclass[9pt, b5paaper]{book}
\\usepackage{xeCJK}
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
\\newminted{common-lisp}{fontsize=\\footnotesize}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
               ;; ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )
;; \footnotesize

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
(setenv "PATH" (concat (getenv "PATH") "I:/selfSoft/texlive/texlive/bin/win32"))
(setq exec-path (append exec-path '("I:/selfSoft/texlive/texlive/bin/win32")))
(setenv "PATH" (concat (getenv "PATH") "C:/Users/blue_/OneDrive/Desktop"))
(setq exec-path (append exec-path '("C:/Users/blue_/OneDrive/Desktop")))

;; (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(add-to-list 'exec-path "C:/msys64/mingw64/bin/")
(setq ispell-program-name "aspell")
(require 'ispell)
(setq ispell-dictionary "en_US")
(setq ispell-personal-dictionary "C:/msys64/mingw64/lib/aspell-0.60/en_US") ;;; 

(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "<f9>") 'flyspell-mode)

; for emacs zsh
(setenv "ESHELL" (expand-file-name "~/.eshell"))

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

(fset 'cmts
   (kmacro-lambda-form [?\M-l ?/ ?/ return ?/ ?/ ?  return] 0 "%d"))

(fset 'cm
      (kmacro-lambda-form [?\C-a ?- ?  ?\C-e ?\C-n ?\C-a] 0 "%d"))
(global-set-key (kbd "C-c i") 'cm) ; very useful



(global-set-key (kbd "C-c j") 'org-emphasize) ; very useful

(provide 'init-org)
