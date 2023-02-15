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
            (local-set-key (kbd "C-i") 'cmtSwiftChCh) ;; Chinese ==> Chinese
            ))

(provide 'init-swift-mode)