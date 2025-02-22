;;; Compiled snippets and support files for `nsis-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'nsis-mode
                     '(("sec" "Section \"${1:Program}\"\n        $0\nSectionEnd" "section" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/section" nil nil)
                       ("out" "outFile \"${1:setup}.exe\"" "outfile" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/outfile" nil nil)
                       ("$" "$OUTDIR" "outdir" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/outdir" nil nil)
                       ("msg" "MessageBox MB_OK \"${1:hello}\"" "message" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/message" nil nil)
                       ("macro" "!macro ${1:Name} UN\n$0\n\n!macroend" "macro" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/macro" nil nil)
                       ("$" "$INSTDIR" "instdir" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/instdir" nil nil)
                       ("im" "!insermacro ${1:Name} ${2:\"args\"}" "insert_macro" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/insert_macro" nil nil)
                       ("inc" "!include \"${Library.nsh}\"" "include" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/include" nil nil)
                       ("if" "${IF} ${1:cond}\n      $0\n${ElseIf} ${2:else_cond}\n\n${EndIf}" "if" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/if" nil nil)
                       ("fun" "Function ${1:Name}\n         $0\nFunctionEnd" "function" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/function" nil nil)
                       ("def" "!define ${1:CONSTANT} ${2:value}" "define" nil nil nil "/Users/hhj/.emacs.d/snippets/nsis-mode/define" nil nil)))


;;; Do not edit! File generated at Sat Oct 28 14:08:48 2023
