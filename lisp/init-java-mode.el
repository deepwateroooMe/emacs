;;;
(setq interpreter-mode-alist
      (cons '("java" . java-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.aidl\\'" . java-mode))

(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
                                        ;  (flet ((process-list ())) ad-do-it))
  (cl-flet ((process-list ())) ad-do-it))


;; (autoload 'jtags-extras "jtags-extras" "Load jtags-extras.")
;; (add-hook 'java-mode-hook 'jtags-extras)
;; ;; (add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

;;;for java-mode ; {} auto-expand
(defun java-autoindent ()
  (when (and (eq major-mode 'java-mode) (looking-back "[;]"))
    (newline-and-indent)))
(add-hook 'post-self-insert-hook 'java-autoindent)
(add-hook 'java-mode-hook
          #'(lambda ()
              (local-set-key (kbd "{") 'cheeso-insert-open-brace-for-java)))

; work with autopair for {
(defun cheeso-looking-back-at-regexp (regexp)
  "calls backward-sexp and then checks for the regexp.  Returns t if it is found, else nil"
  (interactive "s")
  (save-excursion 
    (backward-sexp)
    (looking-at regexp))) 

(defun cheeso-looking-back-at-equals-or-array-init-java ()
  "returns t if an equals or [] is immediate preceding. else nil."
  (interactive)
  (cheeso-looking-back-at-regexp "\\(\\w+\\b *=\\|[[]]+\\)"))  

(defun cheeso-prior-sexp-same-statement-same-line-java ()
  "returns t if the prior sexp is on the same line. else nil"
  (interactive)
  (save-excursion
    (let ((curline (line-number-at-pos))
          (curpoint (point))
          (aftline (progn
                     (backward-sexp)
                     (line-number-at-pos))) )
      (= curline aftline))))  


(defun cheeso-insert-open-brace-for-java ()
  "if point is not within a quoted string literal, insert an open brace, two newlines, and a close brace; indent everything and leave point on the empty line. If point is within a string literal, just insert a pair or braces, and leave point between them."
  (interactive)
  (cond
   ;; are we inside a string literan? 
   ((c-got-face-at (point) c-literal-faces)
    ;; if so, then just insert a pair of braces and put the point between them
    (self-insert-command 1)
    (insert "")) ; this one works great now

   ;; was the last non-space an equals sign? or square brackets?  Then it's an initializer.
   ((cheeso-looking-back-at-equals-or-array-init-java)
    (self-insert-command 1)
    (forward-char 1)
    (insert ";") 
    (backward-char 2)) ; this one works great now

   ;; else, it's a new scope., 
   ;; therefore, insert paired braces with an intervening newline, and indent everything appropriately.
   (t
    (if (cheeso-prior-sexp-same-statement-same-line-java)
        (self-insert-command 1)) ;;; so far only upto here, don't know how to eval & expand {}
    (insert "")
    (newline-and-indent)
    (c-indent-line-or-region)
    )))


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
;;; ____// </summary>???
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
;;; ??????????????????????????????  qjqjqj-->AAAA; qjqj-->qj; AAAA-->qjqj         
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
             ?\M-g ?1 return  ;;; go back to beginning of file
             ])
(fset 'f
      [?\M-g ?1 return ?\M-x ?f ?o return ?\C-x ?h tab ?\C-  ?\C-  ?\M-g ?1 return]) ;; indent region f12
(global-set-key (kbd "C-c f") 'f) ; very useful
(put 'f 'kmacro t)

(fset 'nuf
      (kmacro-lambda-form [?\C-  ?\C-e ?\M-l ?\[ ?\C-k return return
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

(fset 'ccaa
      (kmacro-lambda-form [?\M-f ?\C-f ?\C-f ?\C-f ?\[ ?\C-f ?\M-f ?\M-f ?\M-f ?\C-f ?\C-f ?\C-f ?  backspace ?\[ ?\C-f ?\C-f ?\C-f ?\C-  ?\C-e ?\C-b ?\C-b ?\C-b ?\M-l ?\[ ?\C-k ?\{ ?\C-k backspace return ?\{ ?\C-k return ?\C-p ?\C-n ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\C-  ?\C-n ?\C-e ?\M-l ?\] return ?\} return ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-b ?\M-b ?\C-  ?\C-e ?\M-l ?\{ ?\{ ?\{ ?\C-k return ?\{ ?\{ ?\C-k return ?\C-  ?\C-e ?\M-l ?\} ?\} ?\} return ?\} ?\} return ?\C-e ?\C-n] 0 "%d"))
;; (fset 'cca
;;       (kmacro-lambda-form [?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\C-b ?\C-b ?\C-b ?\C-b ?\C-  ?\C-e ?\M-l ?\[ ?\C-k return ?\{ ?\C-k return ?\C-a ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\C-  ?\C-e ?\M-l ?\] return ?\} return ?\C-n] 0 "%d"))
(global-set-key (kbd "C-c a") 'ccaa) ; very useful

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

(provide 'init-java-mode)
