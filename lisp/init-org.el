;; org-mode
;; (global-linum-mode 1)
;; (setq load-path (cons "C:/Users/blue_/AppData/Roaming/.emacs.d/elpa/org-20140901/" load-path))
(require 'ox)
;; (require 'org-install)
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

(defun org/shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      (setq deactivate-mark nil))))
;;; 不想每次移的时候，因为要在 8  4 2 之间换值，重新启动，太麻烦。
;;; 【任何时候，活宝妹就是一定要嫁给亲爱的表哥！！！】这么就比较好用一点儿 org 里要重复，因为这个模式特殊。但现在至少不用我每次需要修改时不得不重启 emacs 了
(defcustom orgsftLen '4 ;;; 还得与主程序的自定义变量相区分，否则 org 下改了没效果
  "damn it org-mode"
  :type '(choice (integer :tag "Limit")
                 (const :tag "Unlimited" nil)))
(defun org/shift-right ()
  (interactive)
  (org/shift-region orgsftLen))
(defun org/shift-left ()
  (interactive)
  (org/shift-region (* -1 orgsftLen))) ;; 【活宝妹就是一定要嫁给亲爱的表哥！！！】

;;; 下面：是配置下划线和加粗的样式
;; (setq org-emphasis-alist (quote (("*" bold "<b>" "</b>") 
;;                                  ("/" italic "<i>" "</i>")
;;                                  ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
;;                                  ("=" org-code "<code>" "</code>" verbatim)
;;                                  ("~" org-verbatim "<code>" "</code>" verbatim)
;;                                  ("+" (:strike-through t) "<del>" "</del>")
;;                                  ("@" org-warning "<b>" "</b>"))))
(setq  org-export-latex-emphasis-alist (quote (("*" "\\textbf{%s}" nil)
                                           ("/" "\\emph{%s}" nil) 
                                           ("_" "\\underline{%s}" nil)
                                           ("+" "\\texttt{%s}" nil)
                                           ("=" "\\verb=%s=" nil)
                                           ("~" "\\verb~%s~" t)
                                           ("@" "\\alert{%s}" nil))))

(require 'cl)   ; for delete*
(setq org-emphasis-alist
      (cons '("+" '(:strike-through t :foreground "gray"))
            (delete* "+" org-emphasis-alist :key 'car :test 'equal)))
(setq org-emphasis-alist
      (cons '("*" '(:emphasis t :foreground "#00ffff")) ;; 1e90ff
            (delete* "*" org-emphasis-alist :key 'car :test 'equal)))


;; ;;; automated file-name-directory for current buffer , for windows, 使用powershell 
;; (defun my-org-screenshot ()
;;   "Take a screenshot into a time stamped unique-named file in the
;; same directory as the org-buffer and insert a link to this file."
;;   (interactive)
;;   (let* ((powershell (executable-find "powershell.exe"))
;;          (basename (format-time-string "%Y%m%d_%H%M%S.png"))
;;          (filename (concat (file-name-base (buffer-file-name))
;;                            "_"
;;                            basename))
;;          (winFilePathName (expand-file-name (concat "pic/" filename) (file-name-directory buffer-file-name)))
;;          (file-path-wsl (concat "./pic/" filename)))
;; ;;; 必须先用第三方软件将截图复制到剪贴板，再调用这个命令自动生成图片和插入到org文件中，不是全自动
;; ;;; (需要手动F1调用Snipaste[截图+自动复制到剪贴板，再emacs org 里C-i完成自动化，得两个步骤)；但仍差强人意
;;     (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save(\\\"" winFilePathName "\\\")\""))
;;     (org-indent-line)
;;     (insert (concat "\n[[" file-path-wsl "]]"))))
(defun my-org-screenshot () ;;; for mac: automated process, 
  "Take a screenshot into a time stamped unique-named file in the
    same directory as the org-buffer and insert a link to this file."
  (interactive)
  ;; (start-process "Snipaste" nil nil nil) ;;; 这一步主要目标是： 有时候Snipaste没有打开，这里确保截屏程序打开在运行，这里仍然不对，调用得可能太晚，第一次仍会失败，如果没有开启的话，但保证下一步执行成功
  (let* ((basename (format-time-string "%Y%m%d_%H%M%S.png"))
         (filename (concat (file-name-base (buffer-file-name))
                           "_"
                           basename))
         ;; (winFilePathName (expand-file-name (concat "pic/" filename) (file-name-directory buffer-file-name))) ;;; absolute directory for windows, don't like in mac
;;; 这里想要检查一下./pic文件夹是存在，如果不存在，创建文件夹
         (file-path-wsl (concat "./pic/" filename))
         (outdir (concat (file-name-directory (buffer-file-name)) "/pic")))
    (unless (file-directory-p outdir)
      (make-directory outdir t))
    (shell-command (concat "pngpaste " file-path-wsl))
    (org-indent-line)
    (insert (concat "\n[[" file-path-wsl "]]"))))
;;; global-set-key: producing side bugs for csharp-mode & java-mode whoever uses C-i commands .......
;; (global-set-key (kbd "C-i") 'my-org-screenshot) ;;; 今天终于明白了这个C-i是好用，但是在csharp-mode java-mode过程中因为使用到C-i【不知道为什么】会错配到org-mode中的这个合集


;;; 想要配置出：模式里，源码区块里，源码自动换行【就是一行太长】时，不是 pdf 里打印不出来，而是自动换行，转到下一行去
;;; 感觉下面的配置不起效，改天再解决这个问题
;; (defun indent-org-block-automatically ()
;;   (when (org-in-src-block-p)
;;     (org-edit-special)
;;     (indent-region (point-min) (point-max))
;;     (org-edit-src-exit)))
;; (run-at-time 1 10 'indent-org-block-automatically);;; 这里说，每 10 秒调用一次这个方法



(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "<C-S-left>") 'org/shift-left) ;; init.el 可以全局配置管理了
            (local-set-key (kbd "<C-S-right>") 'org/shift-right)
;;;;; auto paste and generate .png image file from clipboard-yank
            (local-set-key (kbd "C-i") 'my-org-screenshot)
            ;; (local-set-key (kbd "M-s") #'indent-org-block-automatically);; 想不出别的可用銉，暂时用这个测试一下。这里设置不对，参数不对
            ;; (autopair-mode 1)
            ))


;;; target: apply atom-one-dark color-theme before org-export into pdf for more colorful source code syntax highlighting
;;;- https://emacs.stackexchange.com/questions/3374/set-the-background-of-org-exported-code-blocks-according-to-theme不起作用，因为我不是导出html而是pdf
;;; 不喜欢我现在导出来的源码，因为着色太少，不好读，改天再干这个
;; (defun my-org-inline-css-hook (exporter)
;;   "Insert custom inline css"
;;   (when (eq exporter 'html)
;;     (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
;;            (path (concat dir "style.css"))
;;            (homestyle (or (null dir) (null (file-exists-p path))))
;;            (final (if homestyle "~/.emacs.d/org-style.css" path)))
;;       (setq org-html-head-include-default-style nil)
;;       (setq org-html-head (concat
;;                            "<style type=\"text/css\">\n"
;;                            "<!--/*--><![CDATA[/*><!--*/\n"
;;                            (with-temp-buffer
;;                              (insert-file-contents final)
;;                              (buffer-string))
;;                            "/*]]>*/-->\n"
;;                            "</style>\n")))))
;; (add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)


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
     ;; (define-key org-mode-map (kbd "<C-S-left>") nil)
     ;; (define-key org-mode-map (kbd "<C-S-right>") nil)
     (add-hook 'org-mode-hook #'my/org-comment-tweak)
     ))


;;; 因为陈桥全角半角符号容易失控,写* - 很容易写成全角,所以改成两个 键操作 减少 误操作
;;; // comment for csharp-mode
;; (fset 'cmtorg
;;       (kmacro-lambda-form [?\C-x ?1 ?  ?- ? ] 0 "%d"))
;; (put 'cmtorg 'kmacro t)
;; (global-set-key (kbd "C-j") 'cmtorg) ;;; 会把这个键组合抢去，影响他们使用
;; (fset 'cmtitem
;;       (kmacro-lambda-form [?\C-x ?1 ?* ] 0 "%d"))
;; ;;;; BUG: 这里有个副作用:把我的csharp-mode C-c f多加了一个＊(应该是由C-i在f  macro中引起的，改掉了)，需要去除
;; (put 'cmtitem 'kmacro t)
;; (global-set-key (kbd "C-m") 'cmtitem) ;;; 不想再设置全局,因为不同mode下会有不同的实现

(defun org-show-two-levels ()
  (interactive)
  (org-content 3))
(add-hook 'org-mode-hook
          (lambda ()
	        (local-set-key (kbd "C-c m") 'org-show-two-levels)
	        ;; (local-set-key (kbd "C-j") 'cmtorg)
            ;; (local-set-key (kbd "C-m") 'cmtitem) ;;; 不想再设置全局,因为不同mode下会有不同的实现
            )) ; very useful

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
                    (font-spec :family "Sarasa Mono SC" :size 12)))
                    ;; (font-spec :family "STHeiti" :size 12)))
                    ;; (font-spec :family "PingFang SC" :size 12)));; 换个字体试一下，是否会有加粗效果
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
  

(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
    (lambda ()
      (setq truncate-lines nil) ;;;解决编辑中文不会自动折行的问题
      (setq org-startup-indented t)
      (setq org-startup-truncated nil)
      (gio-global-minor-mode 1) ;; 因为 protobuf-mode 抛错，暂时禁用了
      ;; (soft-wrap-lines t) ;;; this one works
      ;; (auto-fill-mode 1) ;;; org里直线容易折断
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
   (makefile . t)
   (latex . t)
   ))

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

(add-to-list 'org-latex-classes
             '("IEEEtran"
               "\\documentclass[conference]{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
             ;; ("article" "\\documentclass[11pt]{article}" ;; I don't think i need this
             ;;  ("\\section{%s}" . "\\section*{%s}")
             ;;  ("\\subsection{%s}" . "\\subsection*{%s}")
             ;;  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ;;  ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ;;  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             ;; ("report" "\\documentclass[11pt]{report}"
             ;;  ("\\part{%s}" . "\\part*{%s}")
             ;;  ("\\chapter{%s}" . "\\chapter*{%s}")
             ;;  ("\\section{%s}" . "\\section*{%s}")
             ;;  ("\\subsection{%s}" . "\\subsection*{%s}")
             ;;  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             ;; ("book" "\\documentclass[11pt]{book}"
             ;;  ("\\part{%s}" . "\\part*{%s}")
             ;;  ("\\chapter{%s}" . "\\chapter*{%s}")
             ;;  ("\\section{%s}" . "\\section*{%s}")
             ;;  ("\\subsection{%s}" . "\\subsection*{%s}")
             ;;  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
'(org-latex-image-default-width "0.3\\linewidth")
'(package-selected-packages '(org-ref))

;; 因为新版本的 org.el 里源码区的样式（整条两长条开始结束行），活宝妹不喜欢，所以一直用老版本的 org-mode(两条短横线); 但是它影响了 beamer 里主题的使用
;; 仍然暂时先这样【基本功能齐全：图片、源码、除了报几个没改的错，基本不影响使用体验】老版本，基本功能齐全。不是必须，也可以不用再浪费时间配置这个
;; 改天可以配置成，新老 org-mode 都配置出来。使用时用哪个方便，就临时调整为使用哪个版本：就是当活宝妹不得不要作幻灯片时，如果有时间配置，可以临时用一下新版本的主题等
;;\\mode
;;%\\usecolortheme{{{{beamercolortheme}}}}
;;\\usetheme{{{{Warsaw}}}}
;;\\usepackage{graphicx}
;;\\institute{{{{beamerinstitute}}}}
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass[11pt,professionalfonts]{beamer}
\\beamertemplateballitem
\\setbeameroption{show notes}
\\usepackage{xeCJK}
\\usepackage[T1]{fontenc}
\\usepackage{bera}
\\usepackage[scaled]{beraserif}
\\usepackage[scaled]{berasans}
\\usepackage[scaled]{beramono}
\\usepackage[cache=false]{minted}
\\usepackage{xltxtra}
\\usepackage{xcolor}
\\usepackage{multirow}
\\usepackage{multicol}
\\usepackage{float}
\\usepackage{textcomp}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{tikz}
\\usepackage{xcolor}
\\usepackage{amsmath}
\\usepackage{lmodern}
\\usepackage{fontspec,xunicode,xltxtra}
\\usepackage{polyglossia}
\\usepackage{verbatim}
\\usepackage{listings}
\\subject{{{{beamersubject}}}}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}"
                "\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}")))


;; \\setmainfont{Times New Roman}
;; \\setCJKmainfont{DejaVu Sans YuanTi}
;; \\setCJKmonofont{DejaVu Sans YuanTi Mono}
(add-to-list 'org-latex-classes
             '("cn-article"
               "\\documentclass[9pt, b5paper]{article}
\\usepackage{xeCJK}
\\usepackage[T1]{fontenc}
\\usepackage{bera}
\\usepackage[scaled]{beraserif}
\\usepackage[scaled]{berasans}
\\usepackage[scaled]{beramono}
\\usepackage[cache=false]{minted}
\\usepackage{xltxtra}
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
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
\\newminted{common-lisp}{fontsize=\\footnotesize} 
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;; \\newcommand{\\MintedPygmentize}{/Users/hhj/Library/Python/3.9/bin/pygmentize}
;; \\usepackage[UTF8]{ctex}
;; \\SetCJKmainfont{PingFangSC-Regular}
;; \\setmainfont{Arial}


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
;; (setq org-image-actual-width nil) ;;; 这里不设置缺省为图片原本宽的  90%，现调为1
(setq org-image-actual-width :max-width)


;; outline-mode  
(add-to-list 'auto-mode-alist
  '("\\.outline\\'" . outline-mode))
(require 'outline-presentation)
(add-hook 'outline-presentation-mode-hook
          (lambda () (text-scale-increase 3)))

;for latex
(setenv "PATH" (concat (getenv "PATH") "/usr/local/texlive/2022basic/bin/universal-darwin"))
(setq exec-path (append exec-path '("/usr/local/texlive/2022basic/bin/universal-darwin")))
;;; for pygmentize
(setenv "PATH" (concat (getenv "PATH") "/Users/hhj/Library/Python/3.9/bin"))
(setq exec-path (append exec-path '("/Users/hhj/Library/Python/3.9/bin")))


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
;#+bind: org-latex-image-default-width "1.0\\linewidth"
;#+author: Heyan Huang 
;#+title: 
(fset 'cn
      [?# ?+ ?l ?a ?t ?e ?x ?_ ?c ?l ?a ?s ?s ?: ?  ?c ?n ?- ?a ?r ?t ?i ?c ?l ?e return
      ?# ?+ ?B ?I ?N ?D ?: ?  ?o ?r ?g ?- ?l ?a ?t ?e ?x ?- ?i ?m ?a ?g ?e ?- ?d ?e ?f ?a ?u ?l ?t ?- ?w ?i ?d ?t ?h ?  ?" ?1 ?. ?0 ?\ ?\ ?l ?i ?n ?e ?w ?i ?d ?t ?h ?" return
       ?# ?+ ?a ?u ?t ?h ?o ?r ?: ?  ?H ?e ?y ?a ?n ?  ?H ?u ?a ?n ?g return
       ?# ?+ ?t ?i ?t ?l ?e ?: ?  return
       return])

(fset 'cmts
   (kmacro-lambda-form [?\M-l ?/ ?/ return ?/ ?/ ?  return] 0 "%d"))

(fset 'cm
      (kmacro-lambda-form [?\C-a ?- ?  ?\C-e ?\C-n ?\C-a] 0 "%d"))
;; (global-set-key (kbd "C-c i") 'cm) ; 这里只是不能定义为全局，可以定义为局部
;; (global-set-key (kbd "C-c j") 'org-emphasize) ; very useful
(add-hook 'org-mode-hook
          '(lambda ()
            (local-set-key (kbd "C-c i") 'cm) ; 这里只是不能定义为全局，可以定义为局部
            (local-set-key (kbd "C-c j") 'org-emphasize) ; very useful
            ))


(provide 'init-org)


