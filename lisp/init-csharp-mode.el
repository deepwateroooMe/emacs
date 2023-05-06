;;; for csharp-mode

;; ;; new style: this could work perfectly well for emacs version 27.1 too !!! this one renders better
;; (use-package tree-sitter :ensure t)
;; (use-package tree-sitter-langs :ensure t)
;; (use-package tree-sitter-indent :ensure t)

(load-file "~/.emacs.d/elpa/csharp-mode-2.0.0/csharp-mode.el")
;; (use-package csharp-mode
;;   :ensure t
;;   :config
;;   ;; (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode))
;;   ;; (add-to-list 'auto-mode-alist '("\\.shader\\'" . csharp-tree-sitter-mode))
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
  (add-to-list 'auto-mode-alist '("\\.shader\\'" . csharp-mode))
  ;; )


;; ;;; old-school loading for emacs version 27.1 specificly
;; (load "~/.emacs.d/elpa/csharp-mode/csharp-mode.el") ;;;;; love my dear cousin, must marry him as soon as possible
;; ;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/csharp-mode/")) ;;;;; love my dear cousin, must marry him as soon as possible
;; ;; (require 'csharp-mode)
;; (setq interpreter-mode-alist
;;       (cons '("cs" . csharp-mode) interpreter-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
;; (add-to-list 'auto-mode-alist '("\\.shader\\'" . csharp-mode))


;;; fix bug for font lock breaks after ' or ": 这里以前古老版本里存在这种bug时，当时的补救修改办法,现在看来不起作用了，需要改回适配新的安装方法模式
;;;;; csharp-mode 之后容易出gio-minor-mode引起的一些问题，试着纠正一下
(defun csharp-disable-clear-string-fences (orig-fun &rest args)
  "This turns off `c-clear-string-fences' for `csharp-mode'. When
on for `csharp-mode' font lock breaks after an interpolated string
or terminating simple string."
  (unless (equal major-mode 'csharp-mode)
    (apply orig-fun args)))
(advice-add 'c-clear-string-fences :around 'csharp-disable-clear-string-fences)


;;; 这里添加一个从Emacs中直接要求从VSC中打开当前文件的命令
;; (defun my-open-current-file-in-vscode ()
;;   (interactive)
;;   (save-window-excursion
;;     (async-shell-command
;;      ;; (format "code --add ~/Notes/MD/notes --goto %S:%d" ;;; 不是很明白这里说的是什么意思: 不起作用, 把中间一堆乱七八糟的参数去掉就可以了
;;      (format "code --goto %S:%d:%d" 
;;              (shell-quote-argument buffer-file-name) ;;; 是因为这里面的""使得它不起作用,把这个引号去掉就可以了
;;              ;; (shell-argument buffer-file-name)
;;              (+ (if (bolp) 1 0) (count-lines 1 (point)))
;;              (current-column)
;;              ))))
(defalias 'display-buffer-in-major-side-window 'window--make-major-side-window)
(defun gp/vscode-current-buffer-file-at-point ()
  (interactive)
  (start-process-shell-command "code"
                               nil
                               (concat "code --goto "
                                       (buffer-file-name)
                                       ":"
                                       (number-to-string (+ (if (bolp) 1 0) (count-lines 1 (point)))) ;; 定位精确: 可以定位到了 当前行 当前列
                                       ;; (number-to-string (1+ (current-line))) ;; +1 who knows why
                                       ":"
                                       (number-to-string (current-column)))))
;; (defun xah-open-in-vscode ();;; 这个就列这里作参考，因为上面的，在 windows 下可以成功跳转，我就暂不考虑这个方法了
;;   "Open current file or dir in vscode.
;; URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'
;; Version: 2020-02-13 2021-01-18 2022-08-04"
;;   (interactive)
;;   (let (($path (if buffer-file-name buffer-file-name (expand-file-name default-directory))))
;;     (message "path is %s" $path)
;;     (cond
;;      ((string-equal system-type "windows-nt")
;;       (shell-command (format "code.cmd %s" (shell-quote-argument $path))))
;;      ((string-equal system-type "darwin")
;;       (shell-command (format "open -a Visual\\ Studio\\ Code.app %s" (shell-quote-argument $path))))
;;      ((string-equal system-type "gnu/linux")
;;       (shell-command (format "code %s" (shell-quote-argument $path)))))))
;; (define-key global-map (kbd "C-c i") 'gp/vscode-current-buffer-file-at-point) 


;; for pyim mode, 需要获取这个模式内部中英文输入法的名字以及转换方法 
(fset 'cmtEnCh ;;; 英语，之后是要转换为中文 [f4 // toggle-input-method]
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d")) 
(fset 'cmtChCh ;;; 有点儿延迟: [f4 toggle-input-method // toggle-input-method ]
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtEnCh 'kmacro t)
(put 'cmtChCh 'kmacro t)
(add-hook 'csharp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c i") 'gp/vscode-current-buffer-file-at-point) ;;;;; 这个键太复杂，不好用 ;;;;; distribute the work into 2 fingers
            ;; (local-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
            ;; (local-set-key (kbd "C-x j") 'cmtChCh) ;; Chinese ==> Chinese
            (local-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
            (local-set-key (kbd "C-j") 'cmtChCh) ;; Chinese ==> Chinese
            ;; due to the fact that C-; is globally binded to flyspell.cs some funtion, somehow not able to rebound to C-; for er/expand-region for csharp-mode
            (local-set-key (kbd "C-i") 'er/expand-region) ;; csharp-mode 这个功能可用；但是 tree-sitter-mode 这个功能不可用，狠奇怪 
            ))

 
;;;for csharp-mode ; {} autoindent
(defun csharp-autoindent ()
  (when (and (eq major-mode 'csharp-mode) (looking-back "[;]"))
    (newline-and-indent)))
(add-hook 'post-self-insert-hook 'csharp-autoindent)

(add-hook 'csharp-mode-hook
	      #'(lambda ()
	          (local-set-key (kbd "{") 'cheeso-insert-open-brace)))

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
    (forward-char 2) ;; 1
    (insert ";") 
    (backward-char 3)) ;; 2
   
   ;; Doesn't cooperate well with autopair
   ;; else, it's a new scope., 
   ;; therefore, insert paired braces with an intervening newline, and indent everything appropriately.
   (t
    (if (cheeso-prior-sexp-same-statement-same-line)
        (self-insert-command 1))  ;;; so far only upto here, don't know how to eval & expand {}
    (insert "")
    (newline-and-indent);; 处理当前空行
    (forward-char 1) ;; 1 希望的是，它前一个字付，会移到下一行，格式化下一行
    (indent-according-to-mode);; 这一行，可能不知道为什么不起俢了
    (previous-line);; 回到前一行，但是光标位置不对
    (indent-according-to-mode);; 这一行，仍然起作用，可以在当前行，将光标移到正确的位置 
    )))


;;; 我把这个暂时去掉，看还会引起那么多的问题吗？这个东西应该是不会起什么作用的
(add-hook 'csharp-mode-hook (lambda ()
                              (font-lock-add-keywords nil '(
                                        ; Valid hex number (will highlight invalid suffix though)
                                                            ("\\b0x[[:xdigit:]]+[uUlL]*\\b" . font-lock-string-face)
                                        ; Invalid hex number
                                                            ("\\b0x\\(\\w\\|\\.\\)+\\b" . font-lock-warning-face)
                                        ; Valid floating point number.
                                                            ("\\(\\b[0-9]+\\|\\)\\(\\.\\)\\([0-9]+\\(e[-]?[0-9]+\\)?\\([lL]?\\|[dD]?[fF]?\\)\\)\\b" (1 font-lock-string-face) (3 font-lock-string-face))
                                        ; Invalid floating point number.  Must be before valid decimal.
                                                            ("\\b[0-9].*?\\..+?\\b" . font-lock-warning-face)
                                        ; Valid decimal number.  Must be before octal regexes otherwise 0 and 0l
                                        ; will be highlighted as errors.  Will highlight invalid suffix though.
                                                            ("\\b\\(\\(0\\|[1-9][0-9]*\\)[uUlL]*\\)\\b" 1 font-lock-string-face)
                                        ; Valid octal number
                                                            ("\\b0[0-7]+[uUlL]*\\b" . font-lock-string-face)
                                        ; Floating point number with no digits after the period.  This must be
                                        ; after the invalid numbers, otherwise it will "steal" some invalid
                                        ; numbers and highlight them as valid.
                                                            ("\\b\\([0-9]+\\)\\." (1 font-lock-string-face))
                                        ; Invalid number.  Must be last so it only highlights anything not
                                        ; matched above.
                                                            ("\\b[0-9]\\(\\w\\|\\.\\)+?\\b" . font-lock-warning-face)
                                                            ))
                              ))
(font-lock-add-keywords
 'csharp-mode
 '(("0x\\([0-9a-fA-F]+\\)" . font-lock-builtin-face)))


;;; java macro
;;;; et
(fset 'et
      (kmacro-lambda-form [?\M-l ?A ?s ?s ?e ?t ?s ?. ?S ?c ?r ?i ?p ?t ?s return ?E ?T backspace backspace ?D ?W backspace backspace ?E ?T return ?\M-l ?i ?n ?t ?e ?r ?n ?a ?l return ?p ?u ?b ?l ?i ?c return ?\M-< ?\C-c ?f] 0 "%d"))

;;; famously formating .java file
(fset 'fo ;;; M-p --> M--l global replace-string commands changed
      [?\M-g ?1 return 
             ?\M-l ?\C-q ?\C-m return return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
             ?\M-l ?\} ?\C-q ?\C-j ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e return 
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return ;; 1 \t
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j ?\C-q ?\C-j return
             ?\M-g ?1 return ;;; for {} in one line
             ?\M-l ?\{ ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ;; ?\M-g ?1 return
             ;; ?\M-l ?\{ ?  ?  ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return 
             ?\M-l ?\{ ?\C-q ?\C-j ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-i ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?\C-q ?\C-j ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-i ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?  ?\C-q ?\C-j ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?  ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-i ?\} return ?\{ ?\} return
             ;;; tab ---> ____
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-i return  ?  ?  ?  ?  return
             ?\M-g ?1 return ?\M-l ?/ ?/ ?/ ?  return ?/ ?/ ?  return     ;;; /// --> //
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return  
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return    
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return 
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return    
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ;;;     // <returns></returns>
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?/ ?/ ?  ?< ?r ?e ?t ?u ?r ?n ?s ?> ?< ?/ ?r ?e ?t ?u ?r ?n ?s ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?/ ?/ ?  ?< ?r ?e ?t ?u ?r ?n ?s ?> ?< ?/ ?r ?e ?t ?u ?r ?n ?s ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?r ?e ?t ?u ?r ?n ?s ?> ?< ?/ ?r ?e ?t ?u ?r ?n ?s ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?r ?e ?t ?u ?r ?n ?s ?> ?< ?/ ?r ?e ?t ?u ?r ?n ?s ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?r ?e ?t ?u ?r ?n ?s ?> ?< ?/ ?r ?e ?t ?u ?r ?n ?s ?> ?\C-q ?\C-j return ?\C-q ?\C-j return
;;; 去除掉所有的空格行？  qjqjqj-->AAAA; qjqj-->qj; AAAA-->qjqj         
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return ?A ?A ?A ?A return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ? ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ? ? ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?A ?A ?A ?A return ?\C-q ?\C-j ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?/ ?/ ?/ return return
             ?\M-g ?1 return
             ?\M-l ?/ ?/ return ?/ ?/ ?  return
             ?\M-g ?1 return
             ?\M-l ?/ ?/ ?  ?  return ?/ ?/ ?  return
             ?\M-g ?1 return  ;;; go back to beginning of file
             ])
;; [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h ?\M-x ?i ?n ?d ?e ?n ?t ?- ?r ?e ?g ?i ?o ?n return ?\C-  ?\C-n ?\M-\; ?\C-p ?\C-a ?\C-d ?\C-d ?\C-d ?\C-x]) 
(fset 'f;; C-x h Tab for indent the region: exchanged to M-x indent-region instead to remove the bell ring
      [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h ?\M-x ?i ?n ?d ?e ?n ?t ?- ?r ?e ?g ?i ?o ?n return ?\C-x]) 
(global-set-key (kbd "C-c f") 'f) 
(put 'f 'kmacro t)


(fset 'nuf
      (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-l ?\[ ?\C-k return return
                                 ?\C-a ?\C-  ?\C-e ?\M-l ?\] return return
                                 ?\C-a ?\C-  ?\C-e ?\M-l ?n ?u ?l ?l return ?- ?1 return
                                 ?\C-a ?\C- ?\C-e ?\M-l ?, return ?, ?  return
                                 ?\C-a ?\M-f ?  ?\[ ?\C-f ?\C-d ?  ?\M-f ?\M-f ?\M-f ? ?\[ ?\C-f ?\C-d ? ?\C-n ?\C-p ?\C-e ?\C-n] 0 "%d"))
(global-set-key (kbd "C-c n") 'nuf) ; very useful
;; (fset 'nuaa
;;       (kmacro-lambda-form [?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-b ?\C-b ?\C-b ?\C-b ?\C-  ?\C-e ?\M-l ?\[ ?\C-k return ?\{ ?\C-k return
;;                                  ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-b ?\C-  ?\M-e ?\C-e ?\M-l ?\]] 0 "%d"))
;; (global-set-key (kbd "C-c n") 'nuaa) ; very useful

(fset 'cpf
      (kmacro-lambda-form [?\C-  ?\C-n ?\C-n ?\C-n ?\M-w ?\C-p ?\C-p ?\C-p ?\C-p ?\C-n ?\C-y ?\C-p ?\C-p ?\C-p ?\M-f ?\M-d ?\M-d ?  ?v ?o ?i ?d ? ?\C-e ?\M-b ?\M-d ?r ?e backspace ?\M-b ?\M-b \M-b ?\C-b ?R ?e ?c ?u ?r ?s ?i ?v ?e ?\C-p return ?p ?r ?i ?v ?a ?t ?e ? ] 0 "%d"))
(global-set-key (kbd "C-c p") 'cpf) ; very useful

(fset 'caa
      (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-l ?\[ ?\C-k return ?\{ ?\C-k return ?\C-a ?\C-  ?\C-e ?\M-l ?\] return ?\} return ?\C-a ?\C-  ?\C-e ?\M-l ?\{ ?\{ ?\{ ?\C-k return ?\{ ?\{ ?\C-k return ?\C-a ?\C-  ?\C-e ?\M-l ?\} ?\} ?\} return ?\} ?\} return ?\C-a ?\C-  ?\C-e ?\M-l ?\{ ?\} return ?\[ ?\] ?\[ ?\] return ?\C-n] 0 "%d"))
;; (fset 'ccaa
;;       (kmacro-lambda-form [?\M-f ?\C-f ?\C-f ?\C-f ?\[ ?\C-f ?\M-f ?\M-f ?\M-f ?\C-f ?\C-f ?\C-f ?  backspace ?\[ ?\C-f ?\C-f ?\C-f ?\C-  ?\C-e ?\C-b ?\C-b ?\C-b ?\M-l ?\[ ?\C-k ?\{ ?\C-k backspace return ?\{ ?\C-k return ?\C-p ?\C-n ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\C-  ?\C-e ?\C-e ?\M-l ?\] return ?\} return ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-b ?\M-b ?\C-  ?\C-e ?\M-l ?\{ ?\{ ?\{ ?\C-k return ?\{ ?\{ ?\C-k return ?\C-  ?\C-e ?\M-l ?\} ?\} ?\} return ?\} ?\} return ?\C-e ?\C-n] 0 "%d"))
(global-set-key (kbd "C-c a") 'caa) ; very useful

(fset 'qt
      (kmacro-lambda-form [?\C-  ?\C-e ?\M-l ?\[ ?\C-k return ?\{ ?\C-k return ?\C-a ?\C-  ?\C-e ?\M-l ?\] return ?\} return ?\C-a ?\C-  ?\C-e ?\M-l ?\{ ?\{ ?\{ ?\C-k return ?\{ ?\{ ?\C-k return ?\C-a ?\C-  ?\C-e ?\M-l ?\} ?\} ?\} return ?\} ?\} return ?\C-a ?\C-  ?\C-e ?\M-l ?\{ ?\} return ?\[ ?\] ?\[ ?\] return ?\C-a ?\C-  ?\C-e ?\M-l ?\" ?\C-k return ?\' return ?\C-n] 0 "%d"))
(global-set-key (kbd "C-c t") 'qt) ; char [][] a = {{"a"}, {"b"}} double quote to single quote

(fset 'lm   ; line message
      "System.out.println(\"\C-f);\C-p\C-e\C-b\C-b\C-b")
(fset 'mg   ; ?
      "System.out.println(\": \C-f + \C-f;\C-p\346\346\346\C-f\C-f")
(fset 'j    ; java header for leetcode problems
      [?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?H ?a ?s ?h ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?A ?r ?r ?a ?y ?L ?i ?s ?t ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?L ?i ?s ?t ?\; return return ?p ?u ?b ?l ?i ?c ?  ?c ?l ?a ?s ?s ?  ?\{ return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?c ?l ?a ?s ?s ?  ?S ?o ?l ?u ?t ?i ?o ?n ?  ?\{ return return ?\} return return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?v ?o ?i ?d ?  ?m ?a ?i ?n ?( ?S ?t ?r ?i ?n ?g ?\[ ?\] ?  ?a ?r ?g ?s ?) ?\{ return ?S ?o ?l ?u ?t ?i ?o ?n ?  ?s ?  ?= ?  ?n ?e ?w ?  ?S ?o ?l ?u ?t ?i ?o ?n ?( ?) ?\; return return ?S ?y ?s ?t ?e ?m ?\. ?o ?u ?t ?\. ?p ?r ?i ?n ?t ?l ?n ?( ?r ?e ?s ?) ?\; return ?\} return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-a])
;;; mute one line of codes
(fset 'mu
      "\C-a//\C-n\C-a")
;;; de-mute one line of codes
(fset 'dm
      "\C-a\C-d\C-d\C-n\C-a")

(fset 'cmts
      (kmacro-lambda-form [?\M-l ?/ ?/ return ?/ ?/ ?  return] 0 "%d"))
(global-set-key (kbd "C-c m") 'cmts) ; very useful


(fset 'co
      (kmacro-lambda-form [?\C-x ?\C-f ?\C-a ?\C-y ?\C-k return ?\C-x ?1] 0 "%d"))
(global-set-key (kbd "C-o") 'co)

(provide 'init-csharp-mode)
