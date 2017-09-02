(setq interpreter-mode-alist
     (cons '("swift" . swift3-mode) interpreter-mode-alist))

; swift-mode
(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/swift-mode-2.3.0") load-path))

(custom-set-variables
 '(swift-indent-offset 2)
 '(swift-indent-multiline-statement-offset 1)
 )

; quickrun keybindings to swift-mode-hook
(add-hook 'swift-mode-hook
  '(lambda()
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


;;; mute one line of codes
(fset 'mu
      "\C-a//\C-n\C-a")
;;; de-mute one line of codes
(fset 'dm
   "\C-a\C-d\C-d\C-n\C-a")


(provide 'init-swift-mode)