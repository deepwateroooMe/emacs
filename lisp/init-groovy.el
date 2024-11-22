;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
;; (autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(setq interpreter-mode-alist
      (cons '("groovy" . groovy-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
;; (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
 
;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          (lambda ()
            (require 'groovy-electric)
            (groovy-electric-mode)))

;;; 添加、中英文、注释的、快捷键
(fset 'cmtEnCh;;; 这里的 C-j C-i 与上面的 C-c-f 会给 C-cf 制造麻烦，需要绑定不同的鍵，这里暂时移动一下，看看它有没有什么区别 ?
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtChChGroovy;;; 感觉这里内嵌了一个 pyim 的 bug 需要去找原因 
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtEnCh 'kmacro t) 
(put 'cmtChChGroovy 'kmacro t)
(add-hook 'groovy-mode-hook 
          (lambda ()
            (local-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
            (local-set-key (kbd "C-j") 'cmtChChGroovy) ;; Chinese ==> Chinese
            ))

(provide 'init-groovy)
