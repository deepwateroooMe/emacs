;;; kotlin-mode

(add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/kotlin-mode")) ;拓展文件(插件)目录
(require 'kotlin-mode)

(setq debug-on-error t)

(setq interpreter-mode-alist
      (cons '("kt" . kotlin-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))


;;; set Kotlin mode autoindent to be default 4 spaces
;(setq-default kotlin-tab-width 4)

(provide 'init-kotlin-mode)

