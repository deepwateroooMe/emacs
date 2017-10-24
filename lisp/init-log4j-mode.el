;;; init-log4j-mode.el --- Basic text editing features


(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

(linum-mode 1)

(provide 'init-log4j-mode)
