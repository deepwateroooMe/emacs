;;; init-syslog-mode.el

;;; init-syslog-mode.el --- Basic log viewing editing features


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

;;; define log HIGHLIGHT COLORS for .log analysis
(fset 'deflog
      [
               
               ?h ?r ?M ?a ?i ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?b ?l ?u tab return ;;; MainActivity
               ?h ?l ?o ?n ?C ?r ?e ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onCreate()
               ?h ?r ?o ?n ?S ?a ?v ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onSaveInstanceState()
               ?h ?r ?o ?n ?R ?e ?s ?t ?o ?r ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onRestoreInstanceState()
               ;; ?h ?l ?e ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; error
               ;; ?h ?l ?E ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; Error
               ?h ?r ?o ?n ?C ?l ?i ?c ?k ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ; onClick()
               
               ?\M-g ?1 return ;;; goto line 1
               ])

(global-set-key (kbd "C-c o") 'deflog)
(put 'deflog 'kmacro t)



(provide 'init-syslog-mode)
;;; init-syslog-mode.el ends here