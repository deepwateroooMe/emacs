;; some cool org tricks
;; @see http://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode

;; {{ NO spell check for embedded snippets
(defun org-mode-is-code-snippet ()
  (let* (rlt
         (begin-regexp "^[ \t]*#\\+begin_\\(src\\|html\\|latex\\|example\\)")
         (end-regexp "^[ \t]*#\\+end_\\(src\\|html\\|latex\\|example\\)")
         (case-fold-search t)
         b e)
    (save-excursion
      (if (setq b (re-search-backward begin-regexp nil t))
          (setq e (re-search-forward end-regexp nil t))))
    (if (and b e (< (point) e)) (setq rlt t))
    rlt))

;; no spell check for property
(defun org-mode-current-line-is-property ()
  (string-match "^[ \t]+:[A-Z]+:[ \t]+" (my-line-str)))

;; Please note flyspell only use ispell-word
(defadvice org-mode-flyspell-verify (after org-mode-flyspell-verify-hack activate)
  (let ((run-spellcheck ad-return-value))
    (if ad-return-value
      (cond
       ((org-mode-is-code-snippet)
        (setq run-spellcheck nil))
       ((org-mode-current-line-is-property)
        (setq run-spellcheck nil))))
    (setq ad-return-value run-spellcheck)))
;; }}

;; Org v8 change log:
;; @see http://orgmode.org/worg/org-8.0.html

;; {{ export org-mode in Chinese into PDF
;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
;; and you need install texlive-xetex on different platforms
;; To install texlive-xetex:
;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
(setq org-latex-to-pdf-process ;; org v7
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-pdf-process org-latex-to-pdf-process) ;; org v8
;; }}

(defun my-setup-odt-org-convert-process ()
  (interactive)
  (let ((cmd "/Applications/LibreOffice.app/Contents/MacOS/soffice"))
    (when (and *is-a-mac* (file-exists-p cmd))
      ;; org v7
      (setq org-export-odt-convert-processes '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i")))
      ;; org v8
      (setq org-odt-convert-processes '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i"))))
    ))

(my-setup-odt-org-convert-process)

(defun narrow-to-region-indirect-buffer-maybe (start end use-indirect-buffer)
  "Indirect buffer could multiple widen on same file."
  (if (region-active-p) (deactivate-mark))
  (if use-indirect-buffer
      (with-current-buffer (clone-indirect-buffer
                            (generate-new-buffer-name
                             (concat (buffer-name) "-indirect-"
                                     (number-to-string start) "-"
                                     (number-to-string end)))
                            'display)
        (narrow-to-region start end)
        (goto-char (point-min)))
      (narrow-to-region start end)))

;; @see https://gist.github.com/mwfogleman/95cc60c87a9323876c6c
(defun narrow-or-widen-dwim (&optional use-indirect-buffer)
  "If the buffer is narrowed, it widens.
 Otherwise, it narrows to region, or Org subtree.
If use-indirect-buffer is not nil, use `indirect-buffer' to hold the widen content."
  (interactive "P")
  (cond ((buffer-narrowed-p) (widen))
        ((region-active-p)
         (narrow-to-region-indirect-buffer-maybe (region-beginning)
                                                 (region-end)
                                                 use-indirect-buffer))
        ((equal major-mode 'org-mode)
         (org-narrow-to-subtree))
        ((equal major-mode 'diff-mode)
         (let* (b e)
           (save-excursion
             (setq b (diff-beginning-of-file))
             (setq e (progn (diff-end-of-file) (point))))
           (when (and b e (< b e))
             (narrow-to-region-indirect-buffer-maybe b e use-indirect-buffer))))
        (t (error "Please select a region to narrow to"))))

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-src-content-indentation 0
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      ;; org v7
      org-export-odt-preferred-output-format "doc"
      ;; org v8
      org-odt-preferred-output-format "doc"
      org-tags-column 80
      ;; org-startup-indented t
      ;; {{ org 8.2.6 has some performance issue. Here is the workaround.
      ;; @see http://punchagan.muse-amuse.in/posts/how-i-learnt-to-use-emacs-profiler.html
      org-agenda-inhibit-startup t ;; ~50x speedup
      org-agenda-use-tag-inheritance nil ;; 3-4x speedup
      ;; }}
      )

;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
;; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

(eval-after-load 'org
  '(progn
     (setq org-imenu-depth 9)
     (require 'org-clock)
     ;; @see http://irreal.org/blog/1
     (setq org-src-fontify-natively t)))

(defun org-mode-hook-setup ()
  (setq evil-auto-indent nil)
  ;; org-mode's own flycheck will be loaded
  (enable-flyspell-mode-conditionally)

  ;; but I don't want to auto spell check when typing,
  ;; please comment out `(flyspell-mode -1)` if you prefer auto spell check
  (flyspell-mode -1)

  ;; for some reason, org8 disable odt export by default
  (add-to-list 'org-export-backends 'odt)
  ;; (add-to-list 'org-export-backends 'org) ; for org-mime

  ;; org-mime setup, run this command in org-file, than yank in `message-mode'
  (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)

  ;; don't spell check double words
  (setq flyspell-check-doublon nil)

  ;; display wrapped lines instead of truncated lines
  (setq truncate-lines nil)
  (setq word-wrap t))
(add-hook 'org-mode-hook 'org-mode-hook-setup)

(defadvice org-open-at-point (around org-open-at-point-choose-browser activate)
  "`C-u M-x org-open-at-point` open link with `browse-url-generic-program'"
  (let* ((browse-url-browser-function
          (cond
           ;; open with `browse-url-generic-program'
           ((equal (ad-get-arg 0) '(4)) 'browse-url-generic)
           ;; open with w3m
           (t 'w3m-browse-url))))
    ad-do-it))

(defadvice org-publish (around org-publish-advice activate)
  "Stop running major-mode hook when org-publish"
  (defvar load-user-customized-major-mode-hook)
  (let ((old load-user-customized-major-mode-hook))
    (setq load-user-customized-major-mode-hook nil)
    ad-do-it
    (setq load-user-customized-major-mode-hook old)))

;; {{ org2nikola set up
(setq org2nikola-output-root-directory "~/.config/nikola")
(setq org2nikola-use-google-code-prettify t)
(setq org2nikola-prettify-unsupported-language
      '(elisp "lisp"
              emacs-lisp "lisp"))
;; }}

(defun org-demote-or-promote (&optional is-promote)
  (interactive "P")
  (unless (region-active-p)
    (org-mark-subtree))
  (if is-promote (org-do-promote)
    (org-do-demote)))

;; {{ @see http://orgmode.org/worg/org-contrib/org-mime.html
(defun org-mime-html-hook-setup ()
  (org-mime-change-element-style "pre"
                                 "color:#E6E1DC; background-color:#232323; padding:0.5em;")
  (org-mime-change-element-style "blockquote"
                                 "border-left: 2px solid gray; padding-left: 4px;"))

(eval-after-load 'org-mime
  '(progn
     (setq org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil))
     (add-hook 'org-mime-html-hook 'org-mime-html-hook-setup)))

;; demo video: http://vimeo.com/album/1970594/video/13158054
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-htmlize)))
;; }}

(defun org-agenda-show-agenda-and-todo (&optional arg)
  "Better org-mode agenda view."
  (interactive "P")
  (org-agenda arg "n"))






;;; org-mode
(setq load-path (cons "~/.emacs.d/elpa/org-9.0.9/lisp" load-path))
(add-to-list 'load-path "~/.emacs.d/elpa/org-9.0.9/contrib/lisp" t)
(require 'ox)
(require 'org-install)
(require 'ob-ditaa)  ;;; for cn-article
(require 'ox-publish)
(require 'ox-latex)
(require 'ox-beamer)
(require 'ox-md)
(require 'ox-org)
(setq org-src-fontify-natively t)  ;;; 要对代码进行语法高亮   

(setq org-latex-listings t)                           ;;; added this one
(add-to-list 'org-latex-packages-alist '("" "color"))
(add-to-list 'org-latex-packages-alist '("" "minted")) ; 转化为minted时自动添加minted包     ;;; added this one
(setq org-latex-listings 'minted)                           ;;; added this one
;;; add frame and line number for source code
(setq org-latex-minted-options
      '(
; ("frame" "single")
  ("linenos" "true")))
(setq org-export-latex-minted t)                            ;;; added this one


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
(add-to-list 'ac-modes 'org-mode)


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
;;; \\setmainfont{STSong} ;;; after fontspec 这两行的作用是在生成的.tex文件中加入两行引入xeCJK包, 并设置中文的字体,这样在用xelatex编译.tex文件就不会出错
;\\setmainfont{STSong} ; after fontspec

;\\usepackage{longtable} ; 20170821 to install later
;\\usepackage{multirow}
;\\usepackage{multicol}
(add-to-list 'org-latex-classes
                  '("cn-article"
                    "\\documentclass[9pt, b5paper]{article}
\\usepackage{fontspec}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\setCJKmainfont[Boldfont = STSong SC Black, ItalicFont = STKaiti]{STSong}
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


;for latex
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2017/bin/x86_64-darwin"))
(setq exec-path (append exec-path '("/usr/local/texlive/2017/bin/x86_64-darwin")))

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


(provide 'init-org)
