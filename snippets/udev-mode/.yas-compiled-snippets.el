;;; Compiled snippets and support files for `udev-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'udev-mode
                     '(("run" "RUN+=\"$0\"" "run" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/run" nil nil)
                       ("$" "$env{$1} $0" "env$" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/env$" nil nil)
                       ("add" "ACTION==\"add\", $0" "add" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/add" nil nil)
                       ("ker" "KERNEL!=\"$0\"" "KERNEL" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/KERNEL" nil nil)
                       ("goto" "GOTO=\"$1\"\n$0\n\nLABEL=\"$1\"" "GOTO" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/GOTO" nil nil)
                       ("env" "ENV{$1}$0" "ENV" nil nil nil "/Users/hhj/.emacs.d/snippets/udev-mode/ENV" nil nil)))


;;; Do not edit! File generated at Sat Oct 28 14:08:49 2023
