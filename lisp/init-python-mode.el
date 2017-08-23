(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

;; run command `pip install jedi flake8 importmagic` in shell,
;; or just check https://github.com/jorgenschaefer/elpy
(elpy-enable)

(defun python-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    ;; http://emacs.stackexchange.com/questions/3322/python-auto-indent-problem/3338#3338
    ;; emacs 24.4 only
    (setq electric-indent-chars (delq ?: electric-indent-chars))))

(add-hook 'python-mode-hook 'python-mode-hook-setup)


;;; for python-mode comment (cpy) and decommment (dcp)
(fset 'cpy
   "\C-a#\C-n\C-a")
(fset 'dcp
   "\C-a\C-d\C-n\C-a")
;;; for python-mode comment and decomment
(global-set-key (kbd "C-c c") 'cpy)
(put 'cpy 'kmacro t)
(global-set-key (kbd "C-c d") 'dcp)
(put 'dcp 'kmacro t)


;;; for python
(fset 'mpy    ;  #!/usr/local/bin/python3
   [?# ?! ?/ ?u ?s ?r ?/ ?l ?o ?c ?a ?l ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n ?3 return return])
(fset 'apt
   "print \C-n\C-a")
(fset 'dpt
   "\C-d\C-d\C-d\C-d\C-d\C-d\C-n")



(provide 'init-python-mode)
