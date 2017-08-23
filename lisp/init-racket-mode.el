;(setq interpreter-mode-alist
;      (cons '("python" . python-mode) interpreter-mode-alist))


; for racket comment decomment
(fset 'lcomment
   "\C-a;\C-n\C-a")
(global-set-key (kbd "C-c c") 'lcomment)
(put 'lcomment 'kmacro t)

(fset 'ldecomment
   "\C-a\C-d\C-n\C-a")
(global-set-key (kbd "C-c d") 'ldecomment)
(put 'ldecomment 'kmacro t)


(provide 'init-racket-mode)
