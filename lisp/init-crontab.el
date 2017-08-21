(require-package 'crontab-mode)
;(add-auto-mode 'crontab-mode "\\.?cron\\(tab\\)?\\'")
(add-to-list 'auto-mode-alist '("\\.?cron\\(tab\\)?\\'" . crontab-mode))
(provide 'init-crontab)
