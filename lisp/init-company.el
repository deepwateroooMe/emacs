;;; 
(require 'company)

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load 'company
  '(progn
     ;; @see https://github.com/company-mode/company-mode/issues/348
     (require 'company-statistics)
     (company-statistics-mode)

     (add-to-list 'company-backends 'company-cmake)
     (add-to-list 'company-backends 'company-c-headers)
     ;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))
     ;; (setq company-backends (delete 'company-capf company-backends))
     
     (setq company-dabbrev-downcase nil ;; I don't like the downcase word in company-dabbrev!
           ;; make previous/next selection in the popup cycles
           company-selection-wrap-around t ;在弹出的补全列表里移动时可以前后循环，默认如果移动到了最后一个是没有办法再往下移动的
           ;; Some languages use camel case naming convention, so company should be case sensitive.
           company-dabbrev-ignore-case nil
           ;; press M-number to choose candidate
           company-show-numbers t ; 显示序号 ; display serial number
           company-idle-delay 0.2 ;菜单延迟 ; menu delay
           company-minimum-prefix-length 3 ; 开始补全字数 ; start completelyness number
           company-clang-insert-arguments nil
           company-require-match nil
; 补全列表里的项按照使用的频次排序，这样经常使用到的会放在前面，减少按键次数    
           company-transformers '(company-sort-by-backend-importance)
           company-tooltip-align-annotations t ; 让补全列表里的各项左右对齐
           company-continue-commands '(not helm-dabbrev) ;;; this one, not very sure
           company-etags-ignore-case t)

     ;; @see https://github.com/redguardtoo/emacs.d/commit/2ff305c1ddd7faff6dc9fa0869e39f1e9ed1182d
     (defadvice company-in-string-or-comment (around company-in-string-or-comment-hack activate)
       ;; you can use (ad-get-arg 0) and (ad-set-arg 0) to tweak the arguments
       (if (memq major-mode '(php-mode html-mode web-mode nxml-mode kotlin-mode))
           (setq ad-return-value nil)
         ad-do-it))

     ;; press SPACE will accept the highlighted candidate and insert a space
     ;; `M-x describe-variable company-auto-complete-chars` for details
     ;; That's BAD idea.
                                        ;     (setq company-auto-complete nil)

     ;; NOT to load company-mode for certain major modes.
     ;; Ironic that I suggested this feature but I totally forgot it
     ;; until two years later.
     ;; https://github.com/company-mode/company-mode/issues/29
     (setq company-global-modes
           '(not
             ;;; 这里【暂时】加上 org-mode 实现 scratch-buffer 改 org-mode 后的【】自动匹配
             ;; 【TODO：】检查是否后继【BUG：】或是使用不便  org-mode
             eshell-mode comint-mode erc-mode gud-mode rcirc-mode minibuffer-inactive-mode))))


;; {{ setup company-ispell
(defun toggle-company-ispell ()
  (interactive)
  (cond
   ((memq 'company-ispell company-backends)
    (setq company-backends (delete 'company-ispell company-backends))
    (message "company-ispell disabled"))
   (t
    (add-to-list 'company-backends 'company-ispell)
    (message "company-ispell enabled!"))))

(defun company-ispell-setup ()
  ;; @see https://github.com/company-mode/company-mode/issues/50
  (when (boundp 'company-backends)
    (make-local-variable 'company-backends)
    (add-to-list 'company-backends 'company-ispell)
    ;; https://github.com/redguardtoo/emacs.d/issues/473
    (if (and (boundp 'ispell-alternate-dictionary)
             ispell-alternate-dictionary)
        (setq company-ispell-dictionary ispell-alternate-dictionary))))

;; message-mode use company-bbdb.
;; So we should NOT turn on company-ispell
(add-hook 'org-mode-hook 'company-ispell-setup)
;; }}

(eval-after-load 'company-etags
  '(progn
     ;; insert major-mode not inherited from prog-mode
     ;; to make company-etags work
     (add-to-list 'company-etags-modes 'web-mode)
     (add-to-list 'company-etags-modes 'lua-mode)))


;(setq company-idle-delay nil) ;;; for auto-complete to work ; t


;; grammal check: flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);global enable 
                                        ; close flymake,  start flycheck                                        
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

                                        ; 补全后端使用anaconda
(add-to-list 'company-backends '(company-anaconda :with company-yasnippet))
                                        ; 默认使用 M-n 和 M-p 来在补全列表里移动，改成 C-n 和 C-p
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
                                        ; 设置让 TAB 也具备相同的功能
(define-key company-active-map (kbd "TAB") 'company-complete-common) ; -or-cycle
(define-key company-active-map (kbd "<tab>") 'company-complete-common) ; -or-cycle
(define-key company-active-map (kbd "S-TAB") 'company-select-previous)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(global-set-key (kbd "<C-return>") 'company-complete) ; oir, kbd "<C-tab> ; (kbd "<C-return>") works


(add-hook 'after-init-hook 'global-company-mode)  

(dolist (hook (list ; 13 for specific modes company-mode on
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-common-hook
               'java-mode
               'python-mode-hook
               'csharp-mode
               'swift-mode
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook))
  (add-hook hook 'company-mode))

(defun sucha-install-company-completion-rules ()
  "gtags and dabbref completions for C and C++ mode"
  ;; (company-clear-completion-rules)
  (company-install-dabbrev-completions)
  (company-install-file-name-completions)
  (eval-after-load 'company-gtags-completions
    '(company-install-gtags-completions))
  )

(add-hook
 'c-mode-common-hook
 (lambda ()
   (company-mode 1)
   ;; (sucha-install-company-completion-rules) ; 这里面有很多的配置出不来，暂去掉
   )
 t)

(provide 'init-company)
