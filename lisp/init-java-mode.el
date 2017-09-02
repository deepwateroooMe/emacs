;;; for Java environment
;(require 'cedet) ; cannot find the package
;semantiec基本配置
;见http://emacser.com/built-in-cedet.htm
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				  global-semanticdb-minor-mode
				  global-semantic-idle-summary-mode
				  global-semantic-mru-bookmark-mode))
;(semantic-mode 1)
;(global-semantic-highlight-edits-mode (if window-system 1 -1))
;(global-semantic-show-unmatched-syntax-mode 1)
;(global-semantic-show-parser-state-mode 1)
;代码跳转和官方版本一样还是用semantic-ia-fast-jump命令，不过在emacs-23.2里直接用这个命令可能会报下面的错误,所以运行时这个feature没被load进来，我们需要自己load一下：
;(require 'semantic/analyze/refs)
;(global-ede-mode t)



;;; 解压缩放入load-path目录。然后load，require。
;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")
;(require 'font-lock)
;(require 'ecb)
;(require 'ecb-autoloads)
;(require 'jde)

;(add-to-list 'ac-modes 'jde-mode)
;(add-to-list 'ac-modes 'java-mode)
;(add-hook 'java-mode-hook (lambda () ; this one does not help
;			    (company-mode 0)))
;(add-hook 'jde-mode-hook (lambda () (push 'ac-source-semantic ac-sources)))
;(autoload 'jde-mode "jde" "JDE mode." t)
;(setq auto-mode-alist (append '(("\\.java\\'" . java-mode)) auto-mode-alist))

;(load-file "~/.emacs.d/lisp/cdb-gud.el")
;(add-hook 'jdb-mode-hook '(lambda ()
;			    (setq jdb-need-run t)
;			    (global-set-key [(f4)]   'gud-kill)
;			    (global-set-key [(f5)]   'jdb-run-cont)
;			    (global-set-key [(f7)]   'gud-print)
;			    (global-set-key [(f8)]   'gud-remove)
;			    (global-set-key [(f9)]   'gud-break)
;			    (global-set-key [(f10)]  'gud-step)
;			    (global-set-key [(f11)]  'gud-next)
;			    (global-set-key [(f12)]  'gud-finish)
;
;			    (split-window-horizontally)
;			    (tabbar-backward-group)
;			    ))

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
;  (flet ((process-list ())) ad-do-it))
  (cl-flet ((process-list ())) ad-do-it))

;(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)
;(defun joaot/delete-process-at-point ()
;  (interactive)
;  (let ((process (get-text-property (point) 'tabulated-list-id)))
;    (cond ((and process
;                (processp process))
;           (delete-process process)
;           (revert-buffer))
;          (t
;           (error "no process at point!")))))


;(setq interpreter-mode-alist
;      (cons '("python" . python-mode) interpreter-mode-alist))


;;; java macro
(fset 'lm   ; line message
   "System.out.println(\"\C-f);\C-p\C-e\C-b\C-b\C-b")
(fset 'mg   ; ?
   "System.out.println(\": \C-f + \C-f;\C-p\346\346\346\C-f\C-f")
(fset 'j    ; java header for leetcode problems
      [?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?H ?a ?s ?h ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?M ?a ?p ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?A ?r ?r ?a ?y ?L ?i ?s ?t ?\; return ?i ?m ?p ?o ?r ?t ?  ?j ?a ?v ?a ?. ?u ?t ?i ?l ?. ?L ?i ?s ?t ?\; return return ?p ?u ?b ?l ?i ?c ?  ?c ?l ?a ?s ?s ?  ?\{ return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?c ?l ?a ?s ?s ?  ?S ?o ?l ?u ?t ?i ?o ?n ?  ?\{ return return ?\} return return ?p ?u ?b ?l ?i ?c ?  ?s ?t ?a ?t ?i ?c ?  ?v ?o ?i ?d ?  ?m ?a ?i ?n ?( ?S ?t ?r ?i ?n ?g ?\[ ?\] ?  ?a ?r ?g ?s ?) ?\{ return ?S ?o ?l ?u ?t ?i ?o ?n ?  ?r ?e ?s ?u ?l ?t ?  ?= ?  ?n ?e ?w ?  ?S ?o ?l ?u ?t ?i ?o ?n ?( ?) ?\; return return ?S ?y ?s ?t ?e ?m ?\. ?o ?u ?t ?\. ?p ?r ?i ?n ?t ?l ?n ?( ?r ?e ?s ?) ?\; return ?\} return ?\} ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-p ?\C-a])

;;; mute one line of codes
(fset 'mu
      "\C-a//\C-n\C-a")
;;; de-mute one line of codes
(fset 'dm
   "\C-a\C-d\C-d\C-n\C-a")


(provide 'init-java-mode)
