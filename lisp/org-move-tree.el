;;;
;;; org-move-tree
;;; originally from: https://emacs.stackexchange.com/questions/22078/how-to-split-a-long-org-file-into-separate-org-files
;;; so far the easist way to manipulate multiple org-files, and followed by exporting into one pdf

(defun org-move-tree (filename)
  "move the sub-tree which contains the point to a file,
and replace it with a link to the newly created file"
  (interactive "F")
  (org-mark-subtree)
  (let
      ((name (buffer-substring (region-beginning) (save-excursion (end-of-line) (point))))
       (xxx (buffer-substring (region-beginning) (region-end))))
    (setq name (replace-regexp-in-string "^[*]+ *" "" name))
    
;;; don't want to delete yet, for easier manipulation, don't need link neither
;    (delete-region (region-beginning) (region-end))      
;    (insert (format "[[file:%s][%s]]\n" filename name))

    (find-file-other-window filename)
    (insert xxx)
    (save-buffer)))


(provide 'org-move-tree)
