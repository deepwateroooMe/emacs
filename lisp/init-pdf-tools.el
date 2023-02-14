;;;;; init pdf-tools
;; (require 'pdf-tools)

(use-package pdf-tools
  :ensure t
  :config
  ;; (custom-set-variables
  ;;  '(pdf-tools-handle-upgrades nil)) ; Use brew upgrade pdf-tools instead.
  ;; (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
  (setq pdf-info-epdfinfo-program "/Users/hhj/.emacs.d/elpa/pdf-tools-20230117.632/epdfinfo")
  )
;; (pdf-tools-install)  ; Standard activation command
;; (pdf-loader-install) ; On demand loading, leads to faster startup time


(provide 'init-pdf-tools)
