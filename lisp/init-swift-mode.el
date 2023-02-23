(setq interpreter-mode-alist
      (cons '("swift" . swift-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.swift\\'" . swift-mode))

; swift-mode
;; (setq load-path (cons (expand-file-name "~/.emacs.d/elpa/swift3-mode-2.1.1") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/swift-mode-2.3.0") load-path))

(custom-set-variables
 '(swift-indent-offset 2)
 '(swift-indent-multiline-statement-offset 1)
 )

;;; 不喜欢现在的 swift-mode 里的 {} 不能自动扩展开来，要个帮助方法，自动扩展
(add-hook 'swift-mode-hook
	      #'(lambda ()
	          (local-set-key (kbd "{") 'after-swift-mark)))
(defun after-swift-mark ()
  (interactive)
  (self-insert-command 1)  ;;; so far only upto here, don't know how to eval & expand {}
  (insert "")
  (newline-and-indent);; 处理当前空行
  (forward-char 1) ;; 1 希望的是，它前一个字付，会移到下一行，格式化下一行
  (indent-according-to-mode);; 这一行，可能不知道为什么不起俢了
  (previous-line);; 回到前一行，但是光标位置不对
  (indent-according-to-mode);; 这一行，仍然起作用，可以在当前行，将光标移到正确的位置 
  )


; quickrun keybindings to swift-mode-hook
(add-hook 'swift-mode-hook
          (lambda()
            (local-set-key "\C-c\C-c" 'quickrun)
            (local-set-key "\C-c\C-a" 'quickrun-with-arg)
            )
          )

; add global-flycheck-mode to after-ini-hook
(add-hook 'after-init-hook #'global-flycheck-mode)

; Add swift to flychecker-checkers when swift-mode-hook is enabled. Set swift SDK path to flycheck-swift-sdk-path.
(add-hook 'swift-mode-hook
  '(lambda()
     (add-to-list 'flycheck-checkers 'swift)
     (setq autopair-dont-activate t)
     (setq flycheck-swift-sdk-path
       (replace-regexp-in-string
        "\n+$" "" (shell-command-to-string
                   "xcrun --show-sdk-path --sdk macosx")))
  )
)


;;; kbd-macro that used to expand {|}
(fset 'expand
      [return])
;(global-set-key (kbd "{") '(execute-kbd-macro (symbol-function 'expand))) ; should work for function scope only


;;; mute one line of codes
(fset 'mu
      "\C-a//\C-n\C-a")
;;; de-mute one line of codes
(fset 'dm
   "\C-a\C-d\C-d\C-n\C-a")

;; C-j C-i
;;; for pyim mode only: for temporary-use, until bug fix
(fset 'cmtSwiftEnCh
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtSwiftChCh ;; 有点儿延迟，最好的办法应该是强制使用的半角 ？暂时如此处理
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtSwiftEnCh 'kmacro t)
(put 'cmtSwiftChCh 'kmacro t)

(add-hook 'after-mode-hook ;;; ?
          (lambda()
            (global-set-key (kbd "C-j") 'cmtSwiftEnCh) ;; English ==> Chinese
            (local-set-key (kbd "C-x x") 'cmtSwiftChCh) ;; Chinese ==> Chinese
            ))


(provide 'init-swift-mode)