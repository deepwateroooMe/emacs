;;;;;;; init-autopair.el

(require 'autopair)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/")) ;拓展文件(插件)目录
;; (require 'autopair)
(defun turn-on-autopair-mode () (autopair-mode 1))
                                        ; turn off auto-pair for these modes
(setq autopair-global-modes
      '(not
                                        ;eshell-mode comint-mode erc-mode gud-mode rcirc-mode ; later on examples
        swift-mode))
;(autopair-global-mode) ;; enable autopair in all buffers


(provide 'init-autopair)
