;;; kotlin-mode

(add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/kotlin-mode-20210917.1911")) ;拓展文件(插件)目录
(require 'kotlin-mode)

(setq debug-on-error t)

(setq interpreter-mode-alist
      (cons '("kt" . kotlin-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))

;;; set Kotlin mode autoindent to be default 4 spaces
(setq-default kotlin-tab-width 4)
;; (setq-default indent-tabs-mode nil)

(add-hook 'kotlin-mode-hook
	      #'(lambda ()
	          (local-set-key (kbd "{") 'cheeso-insert-open-brace)))

;;; work with autopair for {
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
    (c-indent-line-or-region)
    )))


(provide 'init-kotlin-mode)
