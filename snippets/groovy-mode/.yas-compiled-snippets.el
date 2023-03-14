;;; Compiled snippets and support files for `groovy-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'groovy-mode
                     '(("times" "${1:10}.times {\n              $0\n}                ." "times" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/times" nil nil)
                       ("pr" "println ${1:\"string\"}\n$0" "println" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/println" nil nil)
                       ("ifd" "implementation fileTree(dir:'libs', include: ['*.jar'])$0" "implementation fileTree" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/ifd" nil nil)
                       ("for" "for (${1:var} in ${2:iter}) {\n    $0\n}\n" "for" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/for" nil nil)
                       ("dict" "${1:dict} = [${2:key} : ${3:value}$0]" "dict" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/dict" nil nil)
                       ("def" "def ${1:method}(${2:args}) {\n    $0\n}" "def" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/def" nil nil)
                       ("class" "class ${1:Class} {\n      $0\n}" "class" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/groovy-mode/class" nil nil)))


;;; Do not edit! File generated at Sat Mar 11 10:29:35 2023
