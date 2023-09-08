(setq interpreter-mode-alist
      (cons '("asm" . asm-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.s\\'" . asm-mode))

;;; 只是需要把常用銉定义一下
;;; 把 csharp-mode 里，几个便利的功能，搬过来，测试一下，是否可以用
;; for pyim mode, 需要获取这个模式内部中英文输入法的名字以及转换方法 
(fset 'cmtEnCh;;; 这里的 C-j C-i 与上面的 C-c-f 会给 C-cf 制造麻烦，需要绑定不同的鍵，这里暂时移动一下，看看它有没有什么区别 ?
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtChCh;;; 有点儿延迟
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtEnCh 'kmacro t)
(put 'cmtChCh 'kmacro t)
(defun gp/ss-vscode-current-buffer-file-at-point ()
  (interactive)
  (start-process-shell-command "code"
                               nil
                               (concat "code --goto "
                                       (buffer-file-name)
                                       ":"
                                       (number-to-string (+ (if (bolp) 1 0) (count-lines 1 (point)))) ;; 定位精确: 可以定位到了 当前行 当前列
                                       ":"
                                       (number-to-string (current-column)))))
(add-hook 'asm-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c i") 'gp/ss-vscode-current-buffer-file-at-point) 
             (local-set-key (kbd "C-x x") 'cmtEnCh)
             (local-set-key (kbd "C-j") 'cmtChCh) 
             ))
;; (defun asm-mode-hook-setup ()
;;   (unless (is-buffer-file-temp)
;;     (setq imenu-create-index-function 'my-asm-imenu-make-index)))
;; (add-hook 'asm-mode-hook 'asm-mode-hook-setup)


(provide 'init-asm-mode)