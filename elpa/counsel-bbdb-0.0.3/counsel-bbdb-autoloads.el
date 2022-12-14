;;; counsel-bbdb-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "counsel-bbdb" "counsel-bbdb.el" (23228 13661
;;;;;;  0 0))
;;; Generated autoloads from counsel-bbdb.el

(autoload 'counsel-bbdb-insert-string "counsel-bbdb" "\
Insert STR into current buffer.

\(fn STR)" nil nil)

(autoload 'counsel-bbdb-reload "counsel-bbdb" "\
Load contacts from `bbdb-file'.

\(fn)" t nil)

(autoload 'counsel-bbdb-complete-mail "counsel-bbdb" "\
In a mail buffer, complete email before point.
Extra argument APPEND-COMMA will append comma after email.

\(fn &optional APPEND-COMMA)" t nil)

(autoload 'counsel-bbdb-expand-mail-alias "counsel-bbdb" "\
Insert multiple mail address in alias/group.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; counsel-bbdb-autoloads.el ends here
