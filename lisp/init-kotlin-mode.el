;;; kotlin-mode
(require 'kotlin-mode)

;;【亲爱的表哥的活宝妹，任何时候，亲爱的表哥的活宝妹就是一定要、一定会嫁给活宝妹的亲爱的表哥！！！爱表哥，爱生活！！！】
;; tmp fix bug of C-c C-r ivy-resume set to global map 
(require 'ivy)

(setq debug-on-error t)

(setq interpreter-mode-alist
      (cons '("kt" . kotlin-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))

;;; set Kotlin mode autoindent to be default 4 spaces
(setq-default kotlin-tab-width 4)
(setq-default indent-tabs-mode nil)


;;;;; 仿 csharp-mode 因为自己没有配置emacs-android-mode,所以为了自己使用IDE便利，配置从emacs 到  Android StudioIDE打开当前buffer定位到行列的命令: 它无法定位到具体的行与列，但差强人意;; 不知道这个功能，能不能用，像是不能用；再试着配置一遍：Emacs 与 AndroidStudio 读源码时的【双向跳转】
(defalias 'display-buffer-in-major-side-window 'window--make-major-side-window)
(defun kt/vscode-current-buffer-file-at-point ()
  (interactive)
  (start-process-shell-command "start"
                               nil
                               ;; (concat "I:/selfSoft/AndroidStudio_3.17/bin/studio64.exe "
                               (concat "studio "
                                       ;; (concat "open -a /Applications/Android\ Studio.app "
                                       (buffer-file-name))))
(add-hook 'kotlin-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c i") 'kt/vscode-current-buffer-file-at-point)
            ;; (global-set-key (kbd "C-c i") 'kt/vscode-current-buffer-file-at-point)
            ;; (local-set-key (kbd "C-j") 'cmt)
            ))


(fset 'cmtEnCh;;; 这里的 C-j C-i 与上面的 C-c-f 会给 C-cf 制造麻烦，需要绑定不同的鍵，这里暂时移动一下，看看它有没有什么区别 ?
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtChChkt;;; 感觉这里内嵌了一个 pyim 的 bug 需要去找原因 
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtEnCh 'kmacro t) 
(put 'cmtChChkt 'kmacro t)
(add-hook 'kotlin-mode-hook 
          (lambda ()
            ;; (local-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
            ;; (local-set-key (kbd "C-j") 'cmtChChkt) ;; Chinese ==> Chinese
            (global-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
            (global-set-key (kbd "C-j") 'cmtChChkt) ;; Chinese ==> Chinese
            ;; 下面并没有解决问题：亲爱的表哥的活宝妹，直接暴力进 Kotlin-mode.el 下把原始键绑定去掉了。。。
            (global-set-key (kbd "C-c C-r") 'ivy-resume) ;; 这么可以解决问题
            ))


(add-hook 'kotlin-mode-hook
	      #'(lambda ()
	          (local-set-key (kbd "{") 'cheeso-insert-open-brace)))

;;; work with autopair for { ;; 这个东西，对这个特殊的 Mode 好像不适合，有时间再看一下，先把中英文注释快捷键添加上
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
    (newline-and-indent)
    (indent-according-to-mode)
    ;; (c-indent-line-or-region)
    )))


(provide 'init-kotlin-mode)
