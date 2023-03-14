;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("verse_" "#+begin_verse\n$0#+end_verse" "verse" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/verse" nil nil)
                       ("uml" "#+BEGIN_UML\n$1#+END_UML\n" "uml" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/uml" nil nil)
                       ("tj" "The Judge$0" "The Judge" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/tj" nil nil)
                       ("st" "#+BEGIN_SRC text\n$0#+END_SRC\n" "st" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/st" nil nil)
                       ("ssh" "#+BEGIN_SRC shell\n#+END_SRC\n$0" "s-shell" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/ssh" nil nil)
                       ("ss" "#+BEGIN_SRC csharp\n$0#+END_SRC\n<<<<<<< HEAD\n\n=======\n>>>>>>> d1b6518fdc5141d410372dca490fb0c5bab2a2c8\n" "csharp-mode" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/ss" nil nil)
                       ("sl" "#+begin_SRC xml\n$0#+END_SRC" "sl" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/sl" nil nil)
                       ("sk" "#+BEGIN_SRC kotlin\n$0#+END_SRC" "sk" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/sk" nil nil)
                       ("sj" "#+BEGIN_SRC java\n$0#+END_SRC" "sj" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/sj" nil nil)
                       ("sg" "#+BEGIN_SRC groovy\n#+END_SRC\n$0" "sg" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/sg" nil nil)
                       ("sc" "#+BEGIN_SRC cpp\n$0#+END_SRC" "sc" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/sc" nil nil)
                       ("pic" "\n[[./pic/${1:i}.png]]\n$0\n" "pic" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/pic" nil nil)
                       ("matrix_" "\\left \\(\n\\begin{array}{${1:ccc}}\n${2:v1 & v2} \\\\\n$0\n\\end{array}\n\\right \\)" "matrix" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/matrix" nil nil)
                       ("latex_" "#+BEGIN_LaTeX\n$0\n#+END_LaTeX" "latex" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/latex" nil nil)
                       ("img_" "<img src=\"$1\"\n alt=\"$2\" align=\"${3:left}\"\n title=\"${4:image title}\"\n class=\"img\"\n</img>\n$0" "img_" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/img_" nil nil)
                       ("id" "**** 解题思路与分析\n#+BEGIN_SRC java\n$0#+END_SRC" "id" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/id" nil nil)
                       ("hh" "Heyan Jenny Huang$0" "Heyan Jenny Huang" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/hh" nil nil)
                       ("fig_" "#+CAPTION: ${1:caption}\n#+ATTR_LaTeX: ${2:scale=0.75}\n#+LABEL: fig:${3:label}\n" "figure" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/figure" nil nil)
                       ("entry_" "#+begin_html\n---\nlayout: ${1:default}\ntitle: ${2:title}\n---\n#+end_html\n$0" "entry" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/entry" nil nil)
                       ("emb_" "src_${1:lang}${2:[${3:where}]}{${4:code}}" "embedded" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/embedded" nil nil)
                       ("em" " // <<<<<<<<<< $0" "commenting emphasis" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/em" nil nil)
                       ("elisp_" "#+begin_src emacs-lisp :tangle yes\n$0\n#+end_src" "elisp" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/elisp" nil nil)
                       ("el" " // <<<<<<<<<<<<<<<<<<<< $0" "commenting emphasis long" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/el" nil nil)
                       ("dot_" "#+begin_src dot :file ${1:file} :cmdline -T${2:pdf} :exports none :results silent\n            $0\n#+end_src\n\n[[file:$1]]" "dot" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/dot" nil nil)
                       ("dc" "Eric Shing-suan Wang$0" "Dear Cousin" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/org-mode/dc" nil nil)))


;;; Do not edit! File generated at Sat Mar 11 10:29:37 2023
