
;; (add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/protobuf-mode")) ;拓展文件(插件)目录
(require 'protobuf-mode)

(setq interpreter-mode-alist
      (cons '("proto" . protobuf-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))


;; (add-hook 'protobuf-mode-hook
;;           (lambda () (c-add-style "my-style" my-protobuf-style t)))


(provide 'init-protobuf-mode)