;;;;; 配置pyim emacs-rime 在emacs 中的前端

;; ;;; Require
;; ;; (add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime")) ;拓展文件(插件)目录
;; (require 'rime)
;; ;; (load-file "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime.el")
;; (setq default-input-method "rime")
;; (setq rime-user-data-dir "c:/Users/blue_/AppData/Roaming/Rime")
;; (setq rime-show-candidate 'posframe)
;; (setq rime-posframe-style 'vertical)
;; (setq rime-cursor "|")
;; ;; (setq rime-share-data-dir "C:/Program Files (x86)/Rime/weasel-0.14.3/data") ;; 说的是这样配置是不对的
;; (setq rime-share-data-dir "~/.emacs.d/elpa/rime/rime-data")
;; (setq rime-posframe-properties
;;       (list :background-color "#333333"
;;             :foreground-color "#dcdccc"
;;             :font "华文楷体"
;;             :internal-border-width 10))

;; (setq default-input-method "rime"
;;       rime-show-candidate 'posframe)



;; ;; Require
;; (add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime")) ;拓展文件(插件)目录
;; ;; (load-file "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime.el")
;; (require 'rime)

(require 'pyim)
(require 'posframe)
(require 'liberime nil t)

(setq default-input-method "pyim")
(setq pyim-page-tooltip 'posframe)
(setq pyim-page-length 5)

(setq rime-user-data-dir "c:/Users/blue_/AppData/Roaming/Rime")
;; (setq rime-share-data-dir "C:/Program Files (x86)/Rime/weasel-0.14.3/data") ;; 说的是这样配置是不对的,说是系统输入法的问题
(setq rime-share-data-dir "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime-data")

;; (liberime-start "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime-data" (file-truename "c:/Users/blue_/AppData/Roaming/Rime"))

(let ((liberime-auto-build t))
  (require 'liberime nil t))

(with-eval-after-load "liberime"
  ;; (liberime-try-select-schema "wubi86_jidian")
  (liberime-try-select-schema "wubi86") ; 不出效果，永远是拼音输入法。。。。。。
  ;; (liberime-select-schema "wubi86_jidian")  ;; 会报错，找不到方法
  ;; (setq pyim-default-scheme 'rime-quanpin)
  (setq pyim-default-scheme 'wubi)
  )


;; (defconst rime-usr-data-exists-p
;;   (file-exists-p "c:/Users/blue_/AppData/Roaming/Rime")
;;   "For checking if there is a rime user data.")

;; (when rime-usr-data-exists-p
;;   (require-package 'rime)

;;   (when (eq system-type 'windows-nt)
;;     (setq rime-share-data-dir "C:/Program Files (x86)/Rime/weasel-0.14.3/data")
;;     ;; (setq rime-share-data-dir
;;     ;;       "~/.emacs.d/elpa/rime/rime-data")
;;     )
;;   ;; (when (eq system-type 'darwin)
;;   ;;   (setq rime-librime-root  "~/emacs-data/librime/dist")
;;   )

;; (setq
;;  rime-inline-predicates '(rime-predicate-space-after-cc-p
;;                           rime-predicate-current-uppercase-letter-p)
;;  rime-translate-keybindings '("C-f" "C-b" "C-n" "C-p" "C-g")
;;  rime-inline-ascii-holder ?a
;;  default-input-method "rime"
;;  rime-cursor "|"
;; rime-show-candidate 'posframe
;;  ;; rime-show-candidate nil
;;  window-min-height 1
;;  rime-user-data-dir "c:/Users/blue_/AppData/Roaming/Rime"
;;  rime-title "")

;; (setq rime-inline-ascii-trigger 'shift-r)

;; (defun rime-toggle-show-candidate ()
;;   "Use minibuffer for candidate if current is nil."
;;   (interactive)
;;   (if (equal rime-show-candidate nil)
;;       (setq rime-show-candidate 'minibuffer)
;;     (setq rime-show-candidate nil)))

;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;; (global-set-key (kbd "s-m") 'rime-force-enable)
;; (global-set-key (kbd "C-`") 'rime-send-keybinding)


(provide 'init-pyim)