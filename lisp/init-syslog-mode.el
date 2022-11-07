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
;;; 先对文件进行必要的处理,去除空行等
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j return

             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ? ?\C-q ?\C-j return ?\C-q ?\C-j return
             ?\M-g ?1 return
             ?\M-l ?\C-q ?\C-j ? ? ? ?\C-q ?\C-j return ?\C-q ?\C-j return

             ?h ?r ?F ?i ?r ?e ?E ?v ?e ?n ?t ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; FireEvent()
             ?h ?r ?l ?a ?n ?d return ?h ?i ?- ?r ?e ?d ?- tab return ;;; land
             ?h ?r ?m ?o ?v ?e return ?h ?i ?- ?b ?l ?u tab return ;;; move
             ?h ?r ?r ?o ?t ?a ?t ?e return ?h ?i ?- ?b ?l ?u tab return ;;; rotate
             ?h ?r ?G ?a ?m ?e ?V ?i ?e ?w return ?h ?i ?- ?r ?e ?d ?- tab return ;;; GameView
             ?h ?r ?G ?a ?m ?e ?V ?i ?e ?w ?M ?o ?d ?e ?l return ?h ?i ?- ?p ?i ?n tab return ;;; GameViewModel
             ?h ?r ?M ?e ?n ?u ?V ?i ?e ?w return ?h ?i ?- ?b ?l ?u tab return ;;; MenuView
             ?h ?r ?M ?e ?n ?u ?V ?i ?e ?w ?M ?o ?d ?e ?l return ?h ?i ?- ?b ?l ?u tab return ;;; MenuViewModel
             ?h ?r ?T ?e ?t ?r ?o ?m ?i ?n ?o return ?h ?i ?- ?g ?r ?e tab return ;;; Tetromino
             ?h ?r ?G ?h ?o ?s ?t ?T ?e ?t ?r ?o ?m ?i ?n ?o return ?h ?i ?- ?g ?r ?e tab return ;;; GhostTetromino
             ?h ?r ?n ?e ?x ?t ?T ?e ?t ?r ?o ?m ?i ?n ?o return ?h ?i ?- ?p ?i ?n tab return ;;; nextTetromino
             ?h ?r ?p ?r ?e ?v ?P ?r ?e ?v ?i ?e ?w return ?h ?i ?- ?b ?l ?u tab return ;;; prevPreview
             ?h ?r ?p ?r ?e ?v ?i ?e ?w return ?h ?i ?- ?b ?l ?u tab return ;;; preview
             ?h ?r ?M ?a ?n ?a ?g ?e ?r return ?h ?i ?- ?y ?e ?l tab return ;;; Manager
             ?h ?r ?V ?i ?e ?w ?M ?a ?n ?a ?g ?e ?r return ?h ?i ?- ?y ?e ?l tab return ;;; ViewManager
             ?h ?r ?D ?a ?t ?a return ?h ?i ?- ?g ?r ?e tab return ;;; Data
             ?h ?r ?G ?l ?o ?D ?a ?t ?a return ?h ?i ?- ?r ?e ?d ?- tab return ;;; GloData
             ?h ?r ?M ?o ?d ?e ?l return ?h ?i ?- ?a ?q ?u tab return ;;; Model
             ?h ?r ?M ?o ?d ?e ?l ?M ?o ?n ?o return ?h ?i ?- ?r ?e ?d ?- tab return ;;; ModelMono
             ?h ?r ?S ?a ?v ?e ?S ?y ?s ?t ?e ?m return ?h ?i ?- ?b ?l ?u tab return ;;; SaveSystem
             ?h ?r ?L ?o ?a ?d ?i ?n ?g ?S ?y ?s ?t ?e ?m ?H ?e ?l ?p ?e ?r return ?h ?i ?- ?g ?r ?e tab return ;;; LoadingSystemHelper
             ?h ?r ?M ?o ?v ?e ?C ?a ?n ?v ?a ?s return ?h ?i ?- ?g ?r ?e tab return ;;; MoveCanvas
             ?h ?r ?R ?o ?t ?a ?t ?e ?C ?a ?n ?v ?a ?s return ?h ?i ?- ?g ?r ?e tab return ;;; RotateCanvas

             
             ;; ?h ?r ?M ?a ?i ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?b ?l ?u tab return ;;; MainActivity
             ;;   ?h ?l ?o ?n ?C ?r ?e ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onCreate()
             ;;   ?h ?r ?o ?n ?S ?a ?v ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onSaveInstanceState()
             ;;   ?h ?r ?o ?n ?R ?e ?s ?t ?o ?r ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onRestoreInstanceState()
             ;;   ;; ?h ?l ?e ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; error
             ;;   ;; ?h ?l ?E ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; Error
             ;;   ?h ?r ?o ?n ?C ?l ?i ?c ?k ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ; onClick()
               
               ?\M-g ?1 return ;;; goto line 1
               ])

(global-set-key (kbd "C-c o") 'deflog)
(put 'deflog 'kmacro t)


(provide 'init-syslog-mode)
;;; init-syslog-mode.el ends here