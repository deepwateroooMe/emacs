;;; Compiled snippets and support files for `terraform-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'terraform-mode
                     '(("var" "variable \"${1:name}\" {\n  ${2:default = \"$3\"}\n}" "variable" nil nil nil "/Users/hhj/.emacs.d/snippets/terraform-mode/variable" nil nil)
                       ("res" "resource \"${1:name}\" {\n         $0\n}" "resource" nil nil nil "/Users/hhj/.emacs.d/snippets/terraform-mode/resource" nil nil)))


;;; Do not edit! File generated at Thu Sep  7 20:51:32 2023