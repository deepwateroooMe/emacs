;;; Compiled snippets and support files for `markdown-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'markdown-mode
                     '(("utf8" "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n$0\n" "utf-8 encoding" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/utf8" nil nil)
                       ("rlink" "[${1:Link Text}][$2] $0\n" "Reference Link" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/rlink" nil nil)
                       ("rlb" "[${1:Reference}]: ${2:URL} $3\n$0\n" "Reference Label" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/rlb" nil nil)
                       ("rimg" "![${1:Alt Text}][$2] $0\n" "Referenced Image" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/rimg" nil nil)
                       ("ol" "${1:1}. ${2:Text}\n${1:$(number-to-string (1+ (string-to-number yas-text)))}. $0\n" "Ordered List" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/ol" nil nil)
                       ("link" "[${1:Link Text}](${2:URL} $3) $0\n" "Link" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/link" nil nil)
                       ("img" "![${1:Alt Text}](${2:URL} $3) $0\n" "Image" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/img" nil nil)
                       ("hr.2" "\n*******\n\n$0\n" "Horizontal Rule (*)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/hr.2" nil nil)
                       ("hr.1" "\n----------\n\n$0\n" "Horizontal Rule (-)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/hr.1" nil nil)
                       ("highlight" "{% highlight ${1:language} %}\n${0:content}\n{% endhighlight %}" "Highlight" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/highlight" nil nil)
                       ("h6" "###### ${1:Header 6} ######\n\n$0\n" "Header 6" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h6" nil nil)
                       ("h5" "##### ${1:Header 5} #####\n\n$0\n" "Header 5" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h5" nil nil)
                       ("h4" "#### ${1:Header 4} ####\n\n$0\n" "Header 4" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h4" nil nil)
                       ("h3" "### ${1:Header 3} ###\n\n$0\n" "Header 3" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h3" nil nil)
                       ("h2.2" "${1:Header 2}\n${1:$(make-string (string-width yas-text) ?\\-)}\n\n$0\n" "Header 2 (-)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h2.2" nil nil)
                       ("h2.1" "## ${1:Header 1} ##\n\n$0\n" "Header 2 (##)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h2.1" nil nil)
                       ("h1.2" "${1:Header 1}\n${1:$(make-string (string-width yas-text) ?\\=)}\n\n$0\n" "Header 1 (=)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h1.2" nil nil)
                       ("h1.1" "# ${1:Header 1} #\n\n$0\n" "Header 1 (#)" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/h1.1" nil nil)
                       ("`" "\\`${1:Code}\\` $0\n" "Inline Code" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/`" nil nil)
                       ("__" "**${1:Text}** $0\n" "Strong" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/__" nil nil)
                       ("_" "_${1:Text}_ $0\n" "Emphasis" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/_" nil nil)
                       ("-" "- ${1:Text}\n-$0\n" "Unordered List" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/-" nil nil)
                       ("+" "+ ${1:Text}\n+$0\n" "Unordered List" nil nil nil "/Users/hhj/.emacs.d/snippets/markdown-mode/+" nil nil)))


;;; Do not edit! File generated at Sat Oct 28 14:08:48 2023
