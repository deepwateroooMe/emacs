;;;;;

;; (load-file "lua-mode.el")
(require 'lua-mode)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(defmacro add-trace-for (fn)
  (let ((trace-fn-name (intern (concat "trace--" (symbol-name fn)))))
    `(progn
       (defun ,trace-fn-name (&rest args)
         (message "%s was called with: %S" #',fn args))
       (add-function :before (symbol-function #',fn) #',trace-fn-name))))

;; (add-trace-for font-lock-fontify-region)
;; (add-trace-for font-lock-unfontify-region)
;; (add-trace-for lua--propertize-multiline-bounds)


;;; C-j 自己喜欢的标注键
(fset 'cmtlua
      (kmacro-lambda-form [f4 ?\C-x ?1 ?  ?- ?- ?  ?\M-x ?s ?i ?s ?- ?s ?e ?t ?- ?o ?t ?h ?e ?r return ?\C-x] 0 "%d"))
(put 'cmtlua 'kmacro t)
(add-hook 'lua-mode-hook
          (lambda ()
            (local-set-key (kbd "C-j") 'cmtlua)
          ))


(provide 'init-lua-mode)
