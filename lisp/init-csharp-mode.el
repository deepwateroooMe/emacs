;;; for csharp-mode

(add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/csharp-mode")) ;拓展文件(插件)目录
(require 'csharp-mode)

(setq interpreter-mode-alist
      (cons '("cs" . csharp-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
(add-to-list 'auto-mode-alist '("\\.shader\\'" . csharp-mode))

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
    (newline-and-indent)
    (c-indent-line-or-region)
    )))


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


;;; fix bug for font lock breaks after ' or "
(defun csharp-disable-clear-string-fences (orig-fun &rest args)
  "This turns off `c-clear-string-fences' for `csharp-mode'. When
on for `csharp-mode' font lock breaks after an interpolated string
or terminating simple string."
  (unless (equal major-mode 'csharp-mode)
    (apply orig-fun args)))
(advice-add 'c-clear-string-fences :around 'csharp-disable-clear-string-fences)


;; added for init-java-mode.el temporatorially

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
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
                                        ;             ?\M-g ?1 return
                                        ;             ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?\{ delete return ?  ?\{ delete return
                                        ;             ?\M-g ?1 return
                                        ;             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\{ delete return ?  ?\{ delete return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e return 
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return ;; 1 \t
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e  return
             ?\M-g ?1 return
             ?\M-l ?\} ?\C-q ?\C-j ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?\C-q ?\C-i ?e ?l ?s ?e return ?\} ?  ?e ?l ?s ?e return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j ?\C-q ?\C-j return
             ?\M-g ?1 return ;;; for {} in one line
             ?\M-l ?\{ ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
             ?\M-g ?1 return
             ?\M-l ?\{ ?  ?  ?\C-q ?\C-j ?  ?  ?  ?  ?\} return ?\{ ?\} return
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
             ?\M-g ?1 return ?\M-l ?/ ?/ ?/ ?  return ?/ ?/ ?  return ?\M-g ?1 return    ;;; /// --> //
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
;;; ____// </summary>口
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return   ;;; // <summary>
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return ;;; // </summary>
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
                                        ;             ?\M-g ?1 return ?\M-l ?\C-q ?\C-j ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?/ ?/ ?  ?< ?/ ?s ?u ?m ?m ?a ?r ?y ?> ?  ?\C-q ?\C-j return ?\C-q ?\C-j return
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
(fset 'f
      [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h tab ?\C-  ?\C-  ?\M-g ?1 return]) ;; indent region f12
(global-set-key (kbd "C-c f") 'f) ; very useful
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
      (kmacro-lambda-form [?\C-  ?\C-n ?\C-n ?\C-n ?\M-w ?\C-p ?\C-p ?\C-p ?\C-p ?\C-n ?\C-y ?\C-p ?\C-p ?\C-p ?\M-f ?\M-d ?\M-d ?  ?v ?o ?i ?d ? ?\C-e ?\M-b ?\M-d ?r ?e backspace ?\M-b ?\M-b ?\M-b ?\C-b ?R ?e ?c ?u ?r ?s ?i ?v ?e ?\C-p return ?p ?r ?i ?v ?a ?t ?e ? ] 0 "%d"))
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

(provide 'init-csharp-mode)
