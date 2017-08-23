;;; for csharp-mode

;(add-to-list 'load-path "~/.emacs.d/elpa/csharp-mode-20130824.1200") ;拓展文件(插件)目录
;(require 'csharp-mode)
(add-to-list 'load-path (expand-file-name "/Users/jenny/.emacs.d/elpa/csharp-mode")) ;拓展文件(插件)目录
(require 'csharp-mode)

;;;for csharp-mode ; {} autoindent
(defun csharp-autoindent ()
  (when (and (eq major-mode 'csharp-mode) (looking-back "[;]"))
    (newline-and-indent)))
(add-hook 'post-self-insert-hook 'csharp-autoindent)
(add-hook 'csharp-mode-hook
	  #'(lambda ()
	      (local-set-key (kbd "{") 'cheeso-insert-open-brace)))

; work with autopair for {
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
    (insert ";")
    (backward-char 1)) ; this one works great now

   ;; doesn't cooperate well with autopair
   ;; else, it's a new scope., 
   ;; therefore, insert paired braces with an intervening newline, and indent everything appropriately.
   (t
    (if (cheeso-prior-sexp-same-statement-same-line)
	(self-insert-command 1))  ;;; so far only upto here, don't know how to eval & expand {}
    (insert "") 
    (c-indent-line-or-region)
					;   (self-insert-command 1))
					;   (newline-and-indent)
					;   (eval-last-sexp)
					;   (newline-and-indent)
					;   (c-indent-line-or-region)
					;   (previous-line)
    )))


(setq interpreter-mode-alist
      (cons '("cs" . csharp-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))

;;; csharp-mode ? now using snippets
(fset 'apf
   "printf(\": %5.8f\\n\",);\C-a\346\C-f\C-f")
(fset 'pf
   "printf(\": %\\n\C-f, \C-f;\C-p\346\C-f\C-f")


(provide 'init-csharp-mode)
