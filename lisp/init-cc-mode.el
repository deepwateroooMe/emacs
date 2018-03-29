(defun c-wx-lineup-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
      'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))

;; avoid default "gnu" style, use more popular one
(setq c-default-style "linux")

(defun fix-c-indent-offset-according-to-syntax-context (key val)
  ;; remove the old element
  (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
  ;; new value
  (add-to-list 'c-offsets-alist '(key . val)))

(defun my-common-cc-mode-setup ()
  "setup shared by all languages (java/groovy/c++ ...)"
  (setq c-basic-offset 4)
  ;; give me NO newline automatically after electric expressions are entered
  (setq c-auto-newline nil)

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

  ;make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)

  ;; indent
  ;; google "C/C++/Java code indentation in Emacs" for more advanced skills
  ;; C code:
  ;;   if(1) // press ENTER here, zero means no indentation
  (fix-c-indent-offset-according-to-syntax-context 'substatement 0)
  ;;   void fn() // press ENTER here, zero means no indentation
  (fix-c-indent-offset-according-to-syntax-context 'func-decl-cont 0))

;;; some error here flymake 
(defun my-c-mode-setup ()
  "C/C++ only setup"
  (message "my-c-mode-setup called (buffer-file-name)=%s" (buffer-file-name))
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)

  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))

  ;; wxWidgets setup
  (c-set-offset 'topmost-intro-cont 'c-wx-lineup-topmost-intro-cont)

  ;; make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

  (when buffer-file-name
    ;; @see https://github.com/redguardtoo/cpputils-cmake
    ;; Make sure your project use cmake!
    ;; Or else, you need comment out below code:
    ;; {{
;    (flymake-mode 1)
;
;   (if (executable-find "cmake")
;   (if (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
;		 (string-match "^/usr/src/linux/include/.*" buffer-file-name)))
;	(cppcm-reload-all)))
    ;; }}

    ))

;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(defun c-mode-common-hook-setup ()
  (unless (is-buffer-file-temp)
    (my-common-cc-mode-setup)
    (unless (or (derived-mode-p 'java-mode) (derived-mode-p 'groovy-mode))
      (my-c-mode-setup))

    ;; gtags (GNU global) stuff
    (when (and (executable-find "global")
               ;; `man global' to figure out why
               (not (string-match-p "GTAGS not found"
                                    (shell-command-to-string "global -p"))))
      ;; emacs 24.4+ will set up eldoc automatically.
      ;; so below code is NOT needed.
      (eldoc-mode 1))
    ))
(add-hook 'c-mode-common-hook 'c-mode-common-hook-setup)


;;; cc-mode c++-mode macros

(fset 'cpp  ;;; C++ enter enter enter --> ""
;  [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return return])
   [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j return return])

;;; c++ macro
(fset 'ou ; cout << _  << endl; and mode cursor on place
   [?c ?o ?u ?t ?  ?< ?< ?  ?\" ?\C-f ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])
(fset 'ot ; cout << _ << endl; difference?
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?\" ?: ?  ?\C-f ?  ?< ?< ?  ?< ?< ?  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])
(fset 'out
   "cout <<  << endl;\C-p\C-f\C-f\C-f\C-f\C-f\C-f\C-f\C-f")

; c++-mode
(fset 'vi
   "typedef vector<int> vi;")
(fset 'vvi
   "typedef vector<vector<int> > vvi;")
(fset 'vc
   "typedef vector<char> vc;")
(fset 'vvc
   "typedef vector<vector<char> > vvc;")
(fset 'vs
   "typedef vector<string> vs;")
(fset 'vvs
   "typedef vector<vector<string> > vvs;")
;;; for c++/c
(fset 'el
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\;])


(provide 'init-cc-mode)