;;; ### Speedbar ###
(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/sr-speedbar-20141004.532") load-path))
(require 'sr-speedbar)

;(autoload 'sr-speedbar-toggle "sr-speedbar") ; avoid init until used
;; (setq speedbar-show-unknown-files t) ; 可以显示所有目录以及文件
(setq speedbar-use-images nil)       ; Turn off the ugly icons
(setq sr-speedbar-right-side nil)    ; Left-side pane
(setq sr-speedbar-auto-refresh nil) ; Don't refresh on buffer changes



;;; set faces speedbar-dirctory-face
(defface speedbar-symlink-directory-face
  '((((class color) (background light)) :foreground "red")
    (((class color) (background dark)) :foreground "green"))
  "Speedbar face for symlinked directory names."
  :group 'speedbar-faces)

(defface speedbar-symlink-filename-face
  '((((class color) (background light)) :foreground "purple")
    (((class color) (background dark)) :foreground "yellow"))
  "Speedbar face for symlinked filenames."
  :group 'speedbar-faces)

(defun speedbar-insert-files-at-point (files level)
  "Insert list of FILES starting at point, and indenting all files to LEVEL.
Tag expandable items with a +, otherwise a ?.  Don't highlight ? as we
don't know how to manage them.  The input parameter FILES is a cons
cell of the form (DIRLIST . FILELIST)."
  ;; Start inserting all the directories
  (let ((dirs (car files)))
    (while dirs
      (speedbar-make-tag-line 'angle
                              ?+
                              'speedbar-dired
                              (car dirs)
                              (car dirs)
                              'speedbar-dir-follow
                              nil
                              (if (file-symlink-p (car dirs))
                                  'speedbar-symlink-directory-face
                                'speedbar-directory-face)
                              level)
      (setq dirs (cdr dirs))))
  (let ((lst (car (cdr files)))
        (case-fold-search t))
    (while lst
      (let* ((known (string-match speedbar-file-regexp (car lst)))
             (expchar (if known ?+ ??))
             (fn (if known 'speedbar-tag-file nil)))
        (when (or speedbar-show-unknown-files (/= expchar ??))
          (speedbar-make-tag-line 'bracket
                                  expchar
                                  fn
                                  (car lst)
                                  (car lst)
                                  'speedbar-find-file
                                  nil
                                  (if (file-symlink-p (car lst))
                                      'speedbar-symlink-filename-face
                                    'speedbar-file-face)
                                  level)))
      (setq lst (cdr lst)))))



;; Nicer fonts for speedbar when in GUI
(when (window-system)
  ;; keep monospace buttons, but smaller height
  (set-face-attribute 'speedbar-button-face nil :height 100)

  ;; change to system default UI font for entries
  (dolist (face (list 'speedbar-file-face 'speedbar-directory-face
                      'speedbar-tag-face  'speedbar-selected-face
                      'speedbar-highlight-face))
    (if (eq system-type 'darwin) ;; Lucida Grande on OS X
        (set-face-attribute face nil :family "Lucida Grande" :height 110)
      (set-face-attribute face nil :family "Droid Sans" :height 100))))

;; No left fringe and half-size right fringe. TODO: Doesn't work
(add-hook 'speedbar-mode-hook (lambda()
                                (message "FROM SPEEDBAR HOOK")
                                (message "window-fringes %S" (window-fringes))
                                (set-window-fringes nil 0)))

;(custom-set-variables '(speedbar-show-unknown-files t))
 (speedbar-add-supported-extension ".cs")
 (add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.cs" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".xml")
(add-to-list 'speedbar-fetch-etags-parse-list
 	     '("\\.xml" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kt")
(add-to-list 'speedbar-fetch-etags-parse-list
       '("\\.kt" . speedbar-parse-c-or-c++tag))
 (speedbar-add-supported-extension ".shader")
 (add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.shader" . speedbar-parse-c-or-c++tag))
 (speedbar-add-supported-extension ".org")
 (add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.org" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kt")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.kt" . speedbar-parse-c-or-c++tag))

;(add-to-list 'speedbar-frame-parameters '(left-fringe . 0)) ; doesn't seem to work
(setq sr-speedbar-width 35)
(setq window-size-fixed 'width)

;(setq dframe-update-speed t)        ; prevent the speedbar to update the current state, since it is always changing  
(global-set-key (kbd "<f5>") (lambda()  
                               (interactive)  
                               (sr-speedbar-toggle)))  
;(global-set-key [(f5)] 'speedbar-get-focus) ;; 不及上面的效果好，容易自动往右缩进

;(speedbar 1)


(provide 'init-sr-speedbar)
