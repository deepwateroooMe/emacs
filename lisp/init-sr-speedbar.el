;;;;;; ### Speedbar ###
(require 'sr-speedbar)

(setq speedbar-use-images nil)       ; Turn off the ugly icons
(setq sr-speedbar-auto-refresh nil) ; Don't refresh on buffer changes
(setq speedbar-use-images t)
(setq speedbar-update-flag t)
(setq sr-speedbar-refresh-turn-off nil)


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


(setq speedbar-show-unknown-files t)
(setq sr-speedbar-width 35)
(setq window-size-fixed 'width)
(setq sr-speedbar-width 35)
(setq sr-speedbar-max-width 35)
(setq window-size-fixed 'width)
(setq sr-speedbar-right-side nil)    ; Left-side pane
(setq sr-speedbar-width-x 35)
(setq dframe-update-speed nil)        ; prevent the speedbar to update the current state, since it is always changing  

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
                                 (sr-speedbar-open)
                                 (sr-speedbar-select-window) ;;; 暂时去掉这个，可能还会有残存问题，因为自己当初加了这个的
                                 )))

;;; 设置为关闭窗口; 填加一个手误功能,当点了F4,
;;; 把这个功能失活，C－j好用的键，只在窗口关键下才起作用。但是窗口是关闭的,那么当F5来用,打开窗口并将光标切换到窗口
(global-set-key [(f4)] (lambda ()
                         (interactive)
                         (when (sr-speedbar-exist-p)
                           (sr-speedbar-close)
                           ;; (sr-speedbar-open)
                           ;; (sr-speedbar-select-window)
                           )
                         ))


;;;;; 放在这里的目的：是为了把它统一到一个里面来写，可能才起作用
(make-face 'speedbar-face)
;; (set-face-font 'speedbar-face "Fira Code Light-13") ;;; 一堆显示不出来的码
(set-face-font 'speedbar-face "Inconsolata-14");; 想字号再大一点儿
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))


;;; 添加一个功能键 h 快速到 base-directory
(setq var_start-path default-directory)
(define-key speedbar-file-key-map (kbd "h")
            (lambda() (interactive)
              (when (and (not (equal var_start-path
                                     sr-speedbar-last-refresh-dictionary))
                         (not (sr-speedbar-window-p)))
                (setq sr-speedbar-last-refresh-dictionary var_start-path))
              (setq default-directory var_start-path)
              (speedbar-refresh))
            )


;; (speedbar 1)
(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)
                            (buffer-face-set 'speedbar-face)
;;; 试着将它设置为常驻，不停不关掉【可是这个功能不便利】，只实现两个不同窗口的跳转：需要，每选择一个文件，导航窗口自动关闭，才方便：改天再弄这个                          
                            (sr-speedbar-open)
                            (sr-speedbar-select-window) ;;; 暂时去掉这个，可能还会有残存问题，因为自己当初加了这个的
                            ))
;; (when window-system          ; start speedbar if we're using a window system
;;   (speedbar t))


;; Add new extensions for speedbar tagging (allow to expand/collapse
;; sections, etc.) -- do this BEFORE firing up speedbar?
(speedbar-add-supported-extension
 '(".org" ".c" ".s" ".txt" ".ld" "mk" "mkk" "mku" "Makefile" "makefile" ".java" ".cs" ".out" ".log" ".cfg" "map" ".S" ".kt" ".gradle" ".properties" ".xml"))
;; (custom-set-variables ;;; temporary-do-NOT show .tex etc hate...
;;  '(speedbar-show-unknown-files t)
;;  )


(provide 'init-sr-speedbar)
