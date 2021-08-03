;;; ### Speedbar ###
(setq load-path (cons (expand-file-name "/Users/heyan/.emacs.d/elpa/sr-speedbar-20141004.532") load-path))
(require 'sr-speedbar)

;(autoload 'sr-speedbar-toggle "sr-speedbar") ; avoid init until used
;; (setq speedbar-show-unknown-files t) ; 可以显示所有目录以及文件
(setq speedbar-use-images nil)       ; Turn off the ugly icons
(setq sr-speedbar-right-side nil)    ; Left-side pane
(setq sr-speedbar-auto-refresh nil) ; Don't refresh on buffer changes

;; Nicer fonts for speedbar when in GUI
(when (window-system)
  ;; keep monospace buttons, but smaller height
  (set-face-attribute 'speedbar-button-face nil :height 100)

  ;; change to system default UI font for entries
  (dolist (face (list 'speedbar-file-face 'speedbar-directory-face
                      'speedbar-tag-face  'speedbar-selected-face
                      'speedbar-highlight-face))
    (if (eq system-type 'darwin) ;; Lucida Grande on OS X
        (set-face-attribute face nil :family "Lucida Grande" :height 110)
      (set-face-attribute face nil :family "Droid Sans" :height 100))))


;; No left fringe and half-size right fringe. TODO: Doesn't work
(add-hook 'sr-speedbar-mode-hook (lambda()
                                   (interactive)
                                   (other-frame 0)
                                   (message "FROM SPEEDBAR HOOK")
                                   (message "window-fringes %S" (window-fringes))
                                        ;                                (speedbar-expand-all-lines ())
                                   (set-window-fringes nil 0)))

;; ;; No left fringe and half-size right fringe. TODO: Doesn't work
;; (add-hook 'speedbar-mode-hook (lambda()
;;                                 (message "FROM SPEEDBAR HOOK")
;;                                 (message "window-fringes %S" (window-fringes))
;;                                 (set-window-fringes nil 0)))


(setq speedbar-show-unknown-files nil)
(speedbar-add-supported-extension ".cs")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.cs" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".shader")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.shader" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".glsl")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.glsl" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".org")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.org" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".xml")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.xml" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kt")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.kt" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".gradle")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.gradle" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".tex")
(add-to-list 'speedbar-fetch-etags-parse-list
		     '("\\.tex" . speedbar-parse-tex-string))

;(setq speedbar-directory-unshown-regexp "^\\(\\.\\.?\\)$") ;; you won’t see . or .. --mykphyre


;(add-to-list 'speedbar-frame-parameters '(left-fringe . 0)) ; doesn't seem to work
(setq sr-speedbar-width 35)
;; (setq window-size-fixed 'width)


(global-set-key (kbd "<f5>") (lambda()  
                               (interactive)  
                               (sr-speedbar-toggle)))
;; (global-set-key [(f5)] 'speedbar-get-focus)


;(speedbar 1)

;(setq speedbar-initial-expansion-list-name "quick buffers")
;; (setq speedbar-initial-expansion-list-name "buffers")

(provide 'init-sr-speedbar)

