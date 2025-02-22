;; loading yasnippet will slow the startup
;; but it's necessary cost
(require 'yasnippet)

;; my private snippets, should be placed before enabling yasnippet
(setq my-yasnippets (expand-file-name "~/my-yasnippets"))
(if (and  (file-exists-p my-yasnippets) (not (member my-yasnippets yas-snippet-dirs)))
    (add-to-list 'yas-snippet-dirs my-yasnippets))

(yas-reload-all)
(defun yasnippet-generic-setup-for-mode-hook ()
  (unless (is-buffer-file-temp)
    (yas-minor-mode 1)))

(add-hook 'prog-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'text-mode-hook 'yasnippet-generic-setup-for-mode-hook)  
;; below modes does NOT inherit from prog-mode
(add-hook 'cmake-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'web-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'scss-mode-hook 'yasnippet-generic-setup-for-mode-hook)

(add-hook 'kotlin-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'java-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'csharp-mode-hook 'yasnippet-generic-setup-for-mode-hook)
(add-hook 'python-mode-hook 'yasnippet-generic-setup-for-mode-hook)


;;; 添加了如下三行，不知道，会有什么效果
;; (setq yas-indent-line 'auto);; comment so java-mode snippets {}  indent properly
(setq yas-also-auto-indent-first-line t)
(setq yas-also-indent-empty-lines t)


(defun my-yas-reload-all () ;; 可能还是分 mode 加载的，这个要再 debug 一下
  (interactive)
  (yas-compile-directory (file-truename "~/.emacs.d/snippets"))
  ;; (yas-reload-all) ;;;  我觉得是这里把所有的都加了一遍，这是不对的
  (unless (or yas/dont-activate ;;; I think it may temporatorially solved the problem, will look back later
              (null (gethash major-mode
                             yas/snippet-tables)))
  (yas-minor-mode 1)))
(global-set-key [(F6)]  'my-yas-reload-all) ;;; 用个键方便一点儿 F8: 拼写检查相关的
;; (global-set-key (kbd "<f6>")  'yas-reload-all) ;;; 用个键方便一点儿 F8: 拼写检查相关的


(defun my-yas-field-to-statement(str sep)
  "If STR=='a.b.c' and SEP=' && ',
'a.b.c' => 'a && a.b && a.b.c'"
  (let ((a (split-string str "\\.")) rlt)
    (mapconcat 'identity
               (mapcar (lambda (elem)
                         (cond
                          (rlt
                           (setq rlt (concat rlt "." elem)))
                          (t
                           (setq rlt elem)))) a)
               sep)))

(defun my-yas-get-first-name-from-to-field ()
  (let ((rlt "AGENT_NAME") str)
    (save-excursion
      (goto-char (point-min))
      ;; first line in email could be some hidden line containing NO to field
      (setq str (my-buffer-str)))
    ;; (message "str=%s" str)
    (if (string-match "^To: \"?\\([a-zA-Z]+\\)" str)
        (setq rlt (capitalize (match-string 1 str))))
    ;; (message "rlt=%s" rlt)
    rlt))

(defun my-yas-camelcase-to-string-list (str)
  "Convert camelcase string into string list"
  (let ((old-case case-fold-search)
        rlt)
    (setq case-fold-search nil)
    (setq rlt (replace-regexp-in-string "\\([A-Z]+\\)" " \\1" str t))
    (setq rlt (replace-regexp-in-string "\\([A-Z]+\\)\\([A-Z][a-z]+\\)" "\\1 \\2" rlt t))
    ;; restore case-fold-search
    (setq case-fold-search old-case)
    (split-string rlt " ")))

(defun my-yas-camelcase-to-downcase (str)
  (let ((l (my-yas-camelcase-to-string-list str))
        (old-case case-fold-search)
        rlt)
    (setq case-fold-search nil)
    (setq rlt (mapcar (lambda (elem)
                        (if (string-match "^[A-Z]+$" elem)
                            elem
                          (downcase elem))
                        ) l))
    (setq case-fold-search old-case)
    (mapconcat 'identity rlt " ")))

(defun my-yas-escape-string (s)
  (let* ((rlt (replace-regexp-in-string "'" "\\\\'" s)))
    (setq rlt (replace-regexp-in-string "\"" "\\\\\"" rlt))
    rlt))

(defun my-yas-get-var-list-from-kill-ring ()
  "Variable name is among the `kill-ring'.  Multiple major modes supported."
  (let* ((top-kill-ring (subseq kill-ring 0 (min (read-number "fetch N `kill-ring'?" 1) (length kill-ring))) )
         rlt)
    (cond
     ((memq major-mode '(js-mode javascript-mode js2-mode js3-mode))
      (setq rlt (mapconcat (lambda (i) (format "'%s=', %s" (my-yas-escape-string i) i)) top-kill-ring ", ")))
     ((memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
      (setq rlt (concat (mapconcat (lambda (i) (format "%s=%%s" i)) top-kill-ring ", ")
                        "\" "
                        (mapconcat (lambda (i) (format "%s" i)) top-kill-ring " ")
                        )))
     ((memq major-mode '(c-mode c++-mode java-mode python-mode csharp-mode swift-mode)) ;; I modifed here
      (setq rlt (concat (mapconcat (lambda (i) (format "%s=%%s" i)) top-kill-ring ", ")
                        "\\n\", "
                        (mapconcat (lambda (i) (format "%s" i)) top-kill-ring ", ")
                        )))
     (t (setq rlt "")))
    rlt))

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))
(defun disable-final-newline () (interactive) (set (make-local-variable 'require-final-newline) nil))

;; Bind `SPC' to `yas-expand' when snippet expansion available (it
;; will still call `self-insert-command' otherwise).
;; (define-key yas-minor-mode-map (kbd "C-c j") yas-maybe-expand)
(define-key yas-minor-mode-map (kbd "M-j") yas-maybe-expand)
;; Bind `C-c y' to `yas-expand' ONLY.
;; (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
 

(eval-after-load 'yasnippet
  '(progn
     ;; http://stackoverflow.com/questions/7619640/emacs-latex-yasnippet-why-are-newlines-inserted-after-a-snippet
     (setq-default mode-require-final-newline nil)
     ;; (message "yas-snippet-dirs=%s" (mapconcat 'identity yas-snippet-dirs ":"))

     ;; default hotkey `C-c C-s` is still valid
     ;; give yas-dropdown-prompt in yas/prompt-functions a chance
     (require 'dropdown-list)
     (setq yas-prompt-functions '(yas-dropdown-prompt
                                  yas-ido-prompt
                                  yas-completing-prompt))

     ;; use yas-completing-prompt when ONLY when `M-x yas-insert-snippet'
     ;; thanks to capitaomorte for providing the trick.
     (defadvice yas-insert-snippet (around use-completing-prompt activate)
       "Use `yas-completing-prompt' for `yas-prompt-functions' but only here..."
       (let ((yas-prompt-functions '(yas-completing-prompt)))
         ad-do-it))))

(provide 'init-yasnippet)
