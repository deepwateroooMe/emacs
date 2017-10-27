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
          ?h ?r ?/ ?B ?l ?u ?e ?t ?o ?o ?t ?h return return  ;;; Bluetooth 
          ?h ?r ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?y ?e ?l ?l ?o ?w return ;;; Activity( ?\( 
          ?h ?r ?/ ?B ?t return ?h ?i ?- ?y ?e ?l ?l ?o ?w return  ;;; /Bt
          ?h ?r ?/ ?b ?t return ?h ?i ?- ?y ?e ?l tab return       ;;; /bt 
          ?h ?r ?j ?e ?n ?n ?y return ?h ?i ?- ?y ?e ?l tab return ;;; jenny  
          ?h ?r ?C ?o ?u ?n ?t ?e ?r return ?h ?i ?- ?y ?e ?l tab return ;;; Counter
          ?h ?p ?c ?o ?n ?n ?e ?c ?t ?P ?l ?a ?y ?s ?e ?t ?\( ?\) return return ;;; connectPlayset()
          ?h ?p ?c ?o ?n ?n ?e ?c ?t ?T ?o ?P ?l ?a ?y ?s ?e ?t ?\( ?\) return ?h ?i ?- ?p ?i ?n ?k tab return ;;; connectToPlayset()
          ?h ?l ?e ?r ?r ?o ?r ?: ?  return ?h ?i ?- ?r ?e tab return ;;; error
          ?h ?l ?c ?o ?n ?n ?e ?c ?t ?P ?l ?a ?y ?s ?e ?t ?\( ?\) ?  ?r ?e ?s ?u ?l ?t ?: ?\S-  return return ;;; connectPlayset() result:_
          ?h ?l ?c ?o ?n ?n ?e ?c ?t ?\( ?\) ? ?s ?t ?a ?r ?t ?: return ?h ?i ?- ?y ?e tab return ;;; connect() start: 
          ?\M-g ?1 return ;;; goto line 1          
          ])
(global-set-key (kbd "C-c o") 'deflog)
(put 'deflog 'kmacro t)


(provide 'init-syslog-mode)
;;; init-syslog-mode.el ends here