;;; Compiled snippets and support files for `rst-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'rst-mode
                     '(("warn" ".. warning:\n   $0" "warning" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/warning" nil nil)
                       ("|" "| $0\n|" "verbatim" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/verbatim" nil nil)
                       ("url" ".. _${1:description}: $0" "url" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/url" nil nil)
                       ("tit" "${1:$(make-string (string-width yas-text) ?\\=)}\n${1:Title}\n${1:$(make-string (string-width yas-text) ?\\=)}\n\n$0\n" "Document title" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/title" nil nil)
                       ("term" ":term:\\`$0\\`" "term" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/term" nil nil)
                       ("sec" "${1:Section}\n${1:$(make-string (string-width yas-text) ?\\-)}\n\n$0\n" "Section title" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/section" nil nil)
                       ("pause" ".. rst-class:: build" "pause" nil
                        ("hieroglyph")
                        nil "/Users/hhj/.emacs.d/snippets/rst-mode/pause" nil nil)
                       ("src" ".. parsed-literal::\n   $0" "parsed_literal" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/parsed_literal" nil nil)
                       ("mod" ":mod: \\`$0\\`" "module" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/module" nil nil)
                       (":" ":${1:var}: $0" "meta" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/meta" nil nil)
                       ("inc" ".. literalinclude:: ${1:path}" "literatal include" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/literal_include" nil nil)
                       ("inh" ".. inheritance-diagram:: $0" "inheritance" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/inheritance" nil nil)
                       ("img" ".. image:: ${1:path}\n   :height: ${2:100}\n   :width: ${3:200}\n   :alt: ${4:description}\n\n$0" "image" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/image" nil nil)
                       ("graph" ".. graphviz::\n\n   $0" "graphviz" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/graphviz" nil nil)
                       ("graph" ".. graph:: $1\n\n   $0" "graph" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/graph" nil nil)
                       ("fun" ":function:\\`$0\\`" "function" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/function" nil nil)
                       ("graph" ".. digraph:: $1\n\n   $0" "digraph" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/digraph" nil nil)
                       ("code" ".. code:: ${1:python}" "code" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/code" nil nil)
                       ("cls" ":class:\\`$0\\`" "class" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/class" nil nil)
                       ("chap" "${1:Chapter}\n${1:$(make-string (string-width yas-text) ?\\=)}\n\n$0\n" "Chapter title" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/chapter" nil nil)
                       ("auto" ".. automodule:: ${1:module_name}" "automodule" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/automodule" nil nil)
                       ("auto" ".. autofunction:: $0" "autofunction" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/autofunction" nil nil)
                       ("auto" ".. autoclass:: $0\n   ${1::members: ${2:members}}" "autoclass" nil nil nil "/Users/hhj/.emacs.d/snippets/rst-mode/autoclass" nil nil)))


;;; Do not edit! File generated at Sat Oct 28 14:08:49 2023
