(require 'package)
;; load autoload files and populate load-path’s

;; add load-path’s and load autoload files
(package-initialize)

;; (add-to-list 'load-path (expand-file-name "/Users/heyan/.emacs.d/lisp/")) ;拓展文件(插件)目录
(setq luna-dumped-load-path load-path)
(setq luna-dumped t)

;; (package-initialize) doens’t require each package, we need to load
;; those we want manually
(dolist (package '(use-package company ivy counsel swiper
                    rainbow-delimiters
                    buffer-move
                    savehist expand-region
		            exec-path-from-shell
                    flx-ido dired+ erlang-start elpy highlight-indentation
                    auto-complete
		            dropdown-list elpy ace-link dumb-jump hydra
		            session 
		            org yasnippet
                    ;; flyspell 
                    ;; flyspell-lazy 
                    ))
  (require package))


;; dump image
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")

