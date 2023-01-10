;;; ### Speedbar ###
(require 'sr-speedbar)

(setq speedbar-use-images nil)       ; Turn off the ugly icons
;; (setq sr-speedbar-right-side nil)    ; Left-side pane
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

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Fira Code Light-11") ;;; 一堆显示不出来的码
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-faces)))

;; (custom-set-variables '(speedbar-show-unknown-files t))
(speedbar-add-supported-extension ".h")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.h" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".cpp")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.cpp" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".c")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.c" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".cs")
 (add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.cs" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".xml")
(add-to-list 'speedbar-fetch-etags-parse-list
 	         '("\\.xml" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kt")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.kt" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kts")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.kts" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".gradle")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.gradle" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".properties")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.properties" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".txt")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.txt" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".mk")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.mk" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".shader")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.shader" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".glsl")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.glsl" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".org")
 (add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.org" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".md")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.md" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".kt")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.kt" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".aidl")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.aidl" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".yaml")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.yaml" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".sh")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.sh" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".json")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.json" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".cshtml")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.cshtml" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".csproj")
(add-to-list 'speedbar-fetch-etags-parse-list
 		     '("\\.csproj" . speedbar-parse-c-or-c++tag))

;; (add-to-list 'speedbar-frame-parameters '(left-fringe . 0)) ; doesn't seem to work
(setq sr-speedbar-width 35)
(setq window-size-fixed 'width)
(setq sr-speedbar-width 35)
(setq sr-speedbar-max-width 35)
(setq window-size-fixed 'width)
(setq sr-speedbar-right-side nil)    ; Left-side pane
(setq sr-speedbar-width-x 35)
(setq dframe-update-speed t)        ; prevent the speedbar to update the current state, since it is always changing  

(defun sb/expand-tags ()
  "Expand current `sr-speedbar' buffer file."
  (interactive)
  ;; We assume that the speedbar name is the same as the file of the buffer
  (let* ((current-buffer-name (file-name-nondirectory (buffer-file-name)))
         (file-point nil)
         (line-list '()))
    (with-current-buffer speedbar-buffer
      ;; Refresh the current speedbar buffer
      (speedbar-refresh)
      (goto-char (point-min))
      (re-search-forward current-buffer-name)
      (setq file-point (point))
      ;; This function make the point go backwards so we have to save the location
      (speedbar-flush-expand-line)
      (goto-char file-point)
      ;; We enter the "expanded" attributes
      (forward-line)
      (while 
          ;; Check if we reach another file, or the end of the buffer.
          (and (not (speedbar-line-file))
               (not (equal (point) (point-max))))
        (push (point) line-list)
        (forward-line))
      ;; Once we have the point of the main branches, we iterate
      ;; and expand his content
      (seq-map (lambda (line)
                 (goto-char line)
                 (speedbar-flush-expand-line))
               line-list))))
;; Add it to the save-hook
;;; 下面这行会制造很多问题
;; (add-hook 'after-save-hook 'sb/expand-tags)

(global-set-key (kbd "<f5>") (lambda()  
                               (interactive)
;;; 如果窗口存在,就切换过去;不存在则打开并切换到浏览窗口,坏处是窗口永远无法关闭                               
                               (if (sr-speedbar-exist-p)
                                   (select-window sr-speedbar-window)
                                 (sr-speedbar-toggle)
                                 (sr-speedbar-select-window)
                                 )))
;;; 设置为关闭窗口; 填加一个手误功能,当点了F4,但是窗口是关闭的,那么当F5来用,打开窗口并将光标切换到窗口
(global-set-key [(f4)] (lambda ()
                         (interactive)
                         (if (sr-speedbar-exist-p)
                             (sr-speedbar-close)
                           (sr-speedbar-open)
                           (sr-speedbar-select-window)
                           )))

;; (speedbar 1)
(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)))
;; (when window-system          ; start speedbar if we're using a window system
;;   (speedbar t))

(provide 'init-sr-speedbar)

