;;; init-text.el --- Basic text editing features

;; No tabs, please
(set-default 'indent-tabs-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Kill the whole line
(setq kill-whole-line t)

;; Show column numbers
(column-number-mode t)

;; Delete the region
(delete-selection-mode t)

;; Snippets
(require 'yasnippet)
(yas-global-mode 1)
;(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet/snippets"))
(require 'auto-complete)
(auto-complete-mode 1)

;; Whitespace mode
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(trailing
                         lines
                         space-before-tab
                         indentation
                         space-after-tab))

;; Text mode
(defun text-hook ()
  (lambda ()
                                        ;    (auto-fill-mode)
    (set-fill-column 37)
    (turn-on-auto-fill)
;    (flyspell-mode)
    ))

(add-hook 'text-mode-hook 'text-hook)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(add-hook 'markdown-mode-hook 'text-hook)

;; Textile mode
(autoload 'textile-mode "textile-mode.el"
  "Major mode for editing Textile files" t)

(add-to-list 'auto-mode-alist '("\\.textile$" . textile-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . textile-mode))
(add-to-list 'auto-mode-alist '("\\.log$" . textile-mode))

(add-hook 'textile-mode-hook 'text-hook)


;; nxhtml stuff
;; this must be loaded before ELPA since it bundles its own
;; out-of-date js stuff. TODO: fix it to use ELPA dependencies
;(load "vendor/nxhtml/autostart")

(setq mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil)

(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))

;; CSS
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
;; ;; .properties: shell-mode
;; (add-to-list 'auto-mode-alist '("\\.properties" . sh-mode))

(linum-mode 1)

(provide 'init-text)
;;; init-text.el ends here