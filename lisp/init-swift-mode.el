(setq interpreter-mode-alist
      (cons '("swift" . swift-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.swift\\'" . swift-mode))

; swift-mode
;; (setq load-path (cons (expand-file-name "~/.emacs.d/elpa/swift3-mode-2.1.1") load-path))
;; (setq load-path (cons (expand-file-name "~/.emacs.d/elpa/swift-mode-2.3.0") load-path))
(require 'swift-mode)
(custom-set-variables
 '(swift-indent-offset 4)
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
;; (add-hook 'after-init-hook #'global-flycheck-mode) ;;; 暂时不要这些，把键弄得狠复杂 

; Add swift to flychecker-checkers when swift-mode-hook is enabled. Set swift SDK path to flycheck-swift-sdk-path.
(add-hook 'swift-mode-hook
  '(lambda()
     ;; (add-to-list 'flycheck-checkers 'swift)
     (setq autopair-dont-activate t)
     ;; (setq flycheck-swift-sdk-path
     ;;   (replace-regexp-in-string
     ;;    "\n+$" "" (shell-command-to-string
     ;;               "xcrun --show-sdk-path --sdk macosx")))
  ))


;;; C-c i 来从 appcode 中打开当前 buffer
(defalias 'display-buffer-in-major-side-window 'window--make-major-side-window)
(defun gp/vscode-current-buffer-file-at-point-sw ()
  (interactive)
  (start-process-shell-command "appcode"
                               nil
                               (concat "appcode "
                                       (buffer-file-name)
;; AppCode 目前还做不到定位到行，到列                                       
                                       ;; ":"
                                       ;; (number-to-string (+ (if (bolp) 1 0) (count-lines 1 (point)))) ;; 定位精确: 可以定位到了 当前行 当前列
                                       ;; ;; (number-to-string (1+ (current-line))) ;; +1 who knows why
                                       ;; ":"
                                       ;; (number-to-string (current-column))
                                       )))
;; (define-key global-map (kbd "C-c i") 'gp/vscode-current-buffer-file-at-point) 

;; C-j C-i
;;; for pyim mode only: for temporary-use, until bug fix
(fset 'cmtSwiftEnCh
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtSwiftChCh ;; 有点儿延迟，最好的办法应该是强制使用的半角 ？暂时如此处理
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtSwiftEnCh 'kmacro t)
(put 'cmtSwiftChCh 'kmacro t)
(add-hook 'swift-mode-hook 
          '(lambda()
            (local-set-key (kbd "C-c i") 'gp/vscode-current-buffer-file-at-point-sw) ;;;;; 目前只有这个不work, 像是所用的 emacs 86-64 与 swift 的环境 arm64 不匹配，这个留着想其它办法处理 
            (local-set-key (kbd "C-x x") 'cmtSwiftEnCh) ;; English ==> Chinese
            (local-set-key (kbd "C-j") 'cmtSwiftChCh)   ;; Chinese ==> Chinese
            ))


(provide 'init-swift-mode)