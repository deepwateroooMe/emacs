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


             ?h ?l ?F ?A ?T ?A ?L ?  ?E ?X ?C ?E ?P ?T ?I ?O ?N ?: return ?h ?i ?- ?y ?e ?l tab return ;;; FATAL EXCEPTION:
             ?h ?l ?c ?o ?m ?. ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o ?. ?t ?e ?t ?r ?i ?s return ?h ?i ?- ?y ?e ?l tab return ;;; com.deepwaterooo.tetris
             ?h ?r ?c ?o ?m ?. ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o ?. ?d ?w return ?h ?i ?g ?h tab return ;;; com.deepwaterooo.dw
             ?h ?r ?c ?o ?m ?. ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o ?. ?s ?d ?k return ?h ?i ?- ?y ?e ?l tab return ;;; com.deepwaterooo.sdk
             ?h ?r ?D ?W ?U ?n ?i ?t ?y ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?g ?h tab return ;;; DWUnityActivity
             ?h ?l ?D ?W ?S ?D ?K return ?h ?i ?- ?y ?e ?l tab return ;;; DWSDK
             ?h ?l ?D ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o return ?h ?i ?- ?y ?e ?l tab return ;;; Deepwaterooo
             ?h ?r ?y ?  ?[ ?D ?W ?U ?p ?p ?e ?r ?] return ?h ?i ?g ?h tab return ;;; y [DWUpper]
             ?h ?r ?D ?W ?S ?p ?l ?a ?s ?h ?S ?c ?r ?e ?e ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?y ?e ?l tab return ;;; DWSplashScreenActivity
             ?h ?r ?D ?W ?H ?a ?v ?e ?A ?c ?c ?o ?u ?n ?t ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?p ?i ?n tab return ;;; DWHaveAccountActivity
             ?h ?r ?D ?W ?L ?o ?g ?i ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?p ?i ?n tab return ;;; DWLoginActivity
             ?h ?r ?D ?W ?S ?i ?g ?n ?U ?p ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?p ?i ?n tab return ;;; DWSignUpActivity
             ?h ?r ?P ?l ?a ?y ?e ?r ?U ?t ?i ?l return ?h ?i ?- ?y ?e ?l tab return ;;; PlayerUtil
             ?h ?r ?S ?h ?a ?r ?e ?d ?P ?r ?e ?f ?U ?t ?i ?l return ?h ?i ?- ?p ?i ?n tab return ;;; SharedPrefUtil
             ?h ?r ?o ?n ?C ?r ?e ?a ?t ?e ?\( ?\) return ?h ?i ?g ?h tab return ;;; onCreate()
             ?h ?r ?o ?n ?S ?t ?a ?r ?t ?\( ?\) return ?h ?i ?g ?h tab return ;;; onStart()
             ?h ?r ?o ?n ?R ?e ?s ?t ?a ?r ?t ?\( ?\) return ?h ?i ?g ?h tab return ;;; onRestart()
             ?h ?r ?o ?n ?P ?a ?u ?s ?e ?\( ?\) return ?h ?i ?g ?h tab return ;;; onPause()
             ?h ?r ?o ?n ?R ?e ?s ?u ?m ?e ?\( ?\) return ?h ?i ?g ?h tab return ;;; onResume()
             ?h ?r ?o ?n ?S ?t ?o ?p ?\( ?\) return ?h ?i ?g ?h tab return ;;; onStop()
             ?h ?r ?o ?n ?D ?e ?s ?t ?r ?o ?y ?\( ?\) return ?h ?i ?g ?h tab return ;;; onDestroy()
             ?h ?r ?o ?n ?W ?i ?n ?d ?o ?w ?F ?o ?c ?u ?s ?C ?h ?a ?n ?g ?e ?d ?\( ?\) return ?h ?i ?g ?h tab return ;;; onWindowFocusChanged()
             ?h ?r ?t ?r ?u ?e return ?h ?i ?- ?b ?l ?u tab return ;;; true
             ?h ?r ?f ?a ?l ?s ?e return ?h ?i ?- ?p ?i ?n tab return ;;; false

             
             ?h ?l ?F ?A ?T ?A ?L ?  ?E ?X ?C ?E ?P ?T ?I ?O ?N ?: return ?h ?i ?- ?y ?e ?l tab return ;;; FATAL EXCEPTION:
             ?h ?r ?C ?: ?/ ?U ?s ?e ?r ?s ?/ ?b ?l ?u ?e ?_ ?/ ?A ?p ?p ?D ?a ?t ?a ?/ ?L ?o ?c ?a ?l ?L ?o ?w ?/ ?D ?e ?f ?a ?u ?l ?t ?C ?o ?m ?p ?a ?n ?y ?/ ?t ?r ?u ?n ?k ?/ return ?h ?i ?- ?y ?e ?l tab return ;;; C:/Users/blue_/AppData/LocalLow/DefaultCompany/trunk/
             ?h ?r ?l ?a ?n ?d return ?h ?i ?- ?r ?e ?d ?- tab return ;;; land
             ?h ?l ?N ?u ?l ?l ?R ?e ?f ?e ?r ?e ?n ?c ?e ?E ?x ?c ?e ?p ?t ?i ?o ?n ?: return ?h ?i ?- ?y ?e ?l tab return ;;; NullReferenceException:
             ?h ?l ?A ?r ?g ?u ?m ?e ?n ?t ?O ?u ?t ?O ?f ?R ?a ?n ?g ?e ?E ?x ?c ?e ?p ?t ?i ?o ?n ?: return ?h ?i ?- ?y ?e ?l tab return ;;; ArgumentOutOfRangeException:
             ?h ?l ?K ?e ?y ?N ?o ?t ?F ?o ?u ?n ?d ?E ?x ?c ?e ?p ?t ?i ?o ?n ?: return ?h ?i ?- ?y ?e ?l tab return ;;; KeyNotFoundException:
             ?h ?l ?E ?v ?e ?n ?t ?M ?a ?n ?a ?g ?e ?r ?: ?  ?F ?i ?r ?e ?E ?v ?e ?n ?t ?\( ?\) ?  ?t ?y ?p ?e ?: ?  ?l ?a ?n ?d return ?h ?i ?- ?y ?e ?l tab return ;;; EventManager: FireEvent() type: land
             ?h ?l ?G ?a ?m ?e ?V ?i ?e ?w ?M ?o ?d ?e ?l ?: ?  ?o ?n ?U ?n ?d ?o ?G ?a ?m ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; GameViewModel: onUndoGame()
             ?h ?l ?E ?R ?R ?O ?R ?: return ?h ?i ?- ?y ?e ?l tab return ;;; ERROR:
             ?h ?l ?e ?r ?r ?o ?r ?: return ?h ?i ?- ?y ?e ?l tab return ;;; error:
             ?h ?l ?E ?r ?r ?o ?r ?: return ?h ?i ?- ?y ?e ?l tab return ;;; Error:
             ?h ?l ?U ?n ?i ?t ?y ?G ?u ?i ?V ?i ?e ?w ?  ?H ?i ?d ?e ?\( ?\) ?  ?f ?o ?r ?  ?d ?e ?b ?u ?g ?g ?i ?n ?g ?  ?G ?a ?m ?e ?V ?i ?e ?w ?  ?H ?i ?d ?i ?n ?g return ?h ?i ?- ?y ?e ?l tab return ;;; UnityGuiView Hide() for debugging GameView Hiding
             ?h ?r ?o ?n ?G ?a ?m ?e ?M ?o ?d ?e ?C ?h ?a ?n ?g ?e ?d ?\( ?\) return ?h ?i ?g ?h tab return ;;; onGameModeChanged()
             ?h ?r ?o ?n ?C ?h ?a ?l ?l ?e ?n ?g ?e ?L ?e ?v ?e ?l ?C ?h ?a ?n ?g ?e ?d ?\( ?\) return ?h ?i ?- ?b ?l ?u ?e ?- tab return ;;; onChallengeLevelChanged()
             ?h ?r ?o ?n ?G ?a ?m ?e ?L ?e ?v ?e ?l ?C ?h ?a ?n ?g ?e ?d ?\( ?\) return ?h ?i ?- ?b ?l ?u ?e ?- tab return ;;; onGameLevelChanged()
             ?h ?r ?o ?n ?A ?c ?t ?i ?v ?e ?T ?e ?t ?r ?o ?m ?i ?n ?o ?L ?a ?n ?d return ?h ?i ?- ?y ?e ?l tab return ;;; onActiveTetrominoLand
             ?h ?r ?o ?n ?G ?a ?m ?e ?S ?a ?v ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onGameSave()
             ?h ?r ?L ?o ?a ?d ?D ?a ?t ?a ?F ?r ?o ?m ?P ?a ?r ?e ?n ?t ?L ?i ?s ?t ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; LoadDataFromParentList()
             ?h ?r ?D ?e ?l ?e ?t ?e ?R ?o ?w ?C ?o ?r ?o ?u ?t ?i ?n ?e ?\( ?\) return ?h ?i ?- ?g ?r ?e tab return ;;; DeleteRowCoroutine()
             ?h ?r ?G ?e ?t ?F ?r ?o ?m ?P ?o ?o ?l ?\( ?\) ?  ?t ?y ?p ?e ?: return ?h ?i ?- ?g ?r ?e tab return ;;; GetFromPool() type:
             ?h ?r ?1 ?  return ?h ?i ?- ?g ?r ?e tab return ;;; 1 
             ?h ?r ?2 ?  return ?h ?i ?- ?b ?l ?u tab return ;;; 2 
             ?h ?r ?3 ?  return ?h ?i ?- ?y ?e ?l tab return ;;; 3 
             ?h ?r ?p ?a ?r ?e ?n ?t ?D ?a ?t ?a ?. ?n ?a ?m ?e ?: return ?h ?i ?- ?p ?i ?n tab return ;;; parentData.name:
             ?h ?r ?m ?o ?v ?e return ?h ?i ?- ?p ?i ?n tab return ;;; move
             ?h ?r ?r ?o ?t ?a ?t ?e return ?h ?i ?- ?b ?l ?u tab return ;;; rotate
             ?h ?r ?G ?a ?m ?e ?V ?i ?e ?w return ?h ?i ?- ?r ?e ?d ?- tab return ;;; GameView
             ?h ?r ?G ?a ?m ?e ?V ?i ?e ?w ?M ?o ?d ?e ?l return ?h ?i ?- ?p ?i ?n tab return ;;; GameViewModel
             ?h ?r ?M ?e ?n ?u ?V ?i ?e ?w return ?h ?i ?- ?b ?l ?u tab return ;;; MenuView
             ?h ?r ?M ?e ?n ?u ?V ?i ?e ?w ?M ?o ?d ?e ?l return ?h ?i ?- ?b ?l ?u tab return ;;; MenuViewModel
             ?h ?r ?T ?e ?t ?r ?o ?m ?i ?n ?o return ?h ?i ?- ?b ?l ?u ?e ?- tab return ;;; Tetromino
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
             ?h ?r ?B ?a ?s ?e ?B ?o ?a ?r ?d ?S ?k ?i ?n ?: ?  return ?h ?i ?- ?b ?l ?u ?e ?- tab return ;;; BaseBoardSkin: 
             ?h ?r ?C ?h ?a ?l ?l ?e ?n ?g ?e ?R ?u ?l ?e ?s return ?h ?i ?- ?b ?l ?a ?c ?k ?- ?b return ;;; ChallengeRules
             ?h ?r ?p ?r ?i ?n ?t ?S ?k ?i ?n ?A ?r ?r ?a ?y ?\( ?\) ?  ?s ?. ?T ?o ?S ?t ?r ?i ?n ?g ?\( ?\) ?: return ?h ?i ?- ?p ?i ?n tab return ;;; printSkinArray() s.ToString():
             ?h ?r ?U ?n ?i ?t ?y ?P ?l ?a ?y ?e ?r ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?y ?e ?l tab return ;;; UnityPlayerActivity
             ?h ?r ?c ?o ?m ?. ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o ?. ?t ?e ?t ?r ?i ?s ?3 ?d return ?h ?i ?- ?y ?e ?l tab return ;;; com.deepwaterooo.tetris3d
             ?h ?r ?c ?o ?m ?. ?d ?e ?e ?p ?w ?a ?t ?e ?r ?o ?o ?o ?. ?d ?w ?s ?d ?k return ?h ?i ?g ?h tab return ;;; com.deepwaterooo.dwsdk
             ?h ?r ?c ?o ?m ?. ?d ?e ?f ?a ?u ?l ?t ?c ?o ?m ?p ?a ?n ?y ?. ?t ?r ?u ?n ?k return ?h ?i ?g ?h tab return ;;; com.defaultcompany.trunk
             ?h ?r ?c ?o ?m ?. ?u ?n ?i ?t ?y ?3 ?d ?. ?p ?l ?a ?y ?e ?r return ?h ?i ?g ?h tab return ;;; com.unity3d.player
             ?h ?l ?G ?a ?m ?e ?A ?p ?p ?l ?i ?c ?a ?t ?i ?o ?n return ?h ?i ?- ?y ?e ?l tab return ;;; GameApplication
             ?h ?r ?M ?a ?i ?n return ?h ?i ?- ?y ?e ?l tab return ;;; Main
             ?h ?l ?c ?l ?i ?c ?k ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; click()
             ?h ?r ?T ?e ?s ?t ?U ?n ?i ?t ?y ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?b ?l ?u tab return ;;; TestUnityActivity
             ?h ?r ?. ?M ?a ?i ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?p ?i ?n tab return ;;; .MainActivity

             
             ?h ?r ?M ?a ?i ?n ?A ?c ?t ?i ?v ?i ?t ?y return ?h ?i ?- ?b ?l ?u tab return ;;; MainActivity
               ?h ?l ?o ?n ?C ?r ?e ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onCreate()
               ?h ?r ?o ?n ?S ?a ?v ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onSaveInstanceState()
               ?h ?r ?o ?n ?R ?e ?s ?t ?o ?r ?e ?I ?n ?s ?t ?a ?n ?c ?e ?S ?t ?a ?t ?e ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ;;; onRestoreInstanceState()
               ?h ?l ?e ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; error
               ?h ?l ?E ?r ?r ?o ?r return ?h ?i ?- ?r ?e ?d tab return                ; Error
               ?h ?r ?o ?n ?C ?l ?i ?c ?k ?\( ?\) return ?h ?i ?- ?y ?e ?l tab return ; onClick()
               
               ?\M-g ?1 return ;;; goto line 1
               ])

(global-set-key (kbd "C-c o") 'deflog)
(put 'deflog 'kmacro t)


(provide 'init-syslog-mode)
;;; init-syslog-mode.el ends here