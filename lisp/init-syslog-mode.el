;;; init-syslog.el --- Basic log viewing editing features


;; syslog-mode
(autoload 'syslog-mode "syslog-mode.el"
  "Major mode for editing Textile files" t)

(add-to-list 'auto-mode-alist '("\\.log$" . syslog-mode))


;; No tabs, please
(set-default 'indent-tabs-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Kill the whole line
(setq kill-whole-line t)

;; Delete the region
(delete-selection-mode t)

;; Snippets
(require 'yasnippet)
(yas-global-mode 1)


;; Whitespace mode
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(trailing
                         lines
                         space-before-tab
                         indentation
                         space-after-tab))


;; Logview mode
(defun syslog-mode-hook ()
  (lambda ()
    (auto-fill-mode)
    (flyspell-mode)))


(dolist (hook (list            ; 13 for specific modes company-mode on
               'java-mode-hook
               'log4j-mode-hook))
  (add-hook hook 'syslog-mode))

(linum-mode 1)


(provide 'init-syslog-mode)
;;; init-syslog-mode.el ends here