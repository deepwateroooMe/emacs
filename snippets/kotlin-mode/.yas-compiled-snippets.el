;;; Compiled snippets and support files for `kotlin-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'kotlin-mode
                     '(("uc" "uppercase()$0" "uppercase()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/uc" nil nil)
                       ("tv" "$1=$$1$0" "val=$val" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/tv" nil nil)
                       ("ts" "toString()$0" "toString()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ts" nil nil)
                       ("tg" "const val TAG = \"$1\"\n$0" "TAG" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/tg" nil nil)
                       ("sti" "String.toInt(${1:s})$0" "String.toInt()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/sti" nil nil)
                       ("sa" "var ${1:a}: Array<String> = arrayOf($2)\n$0\n" "val a: Array<String> = arrayOf()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/sa" nil nil)
                       ("rn" "return $0" "return" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/rn" nil nil)
                       ("pv" "println(\"${1:v}: \" + $1)\n$0\n" "println(var)" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/pv" nil nil)
                       ("prm" "println(\"$1\")\n$0" "println(\"string\")" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/prm" nil nil)
                       ("lv" "Log.d(TAG, \"${1:v}: \" + $1)\n$0\n" "Log.dvar:)" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/lv" nil nil)
                       ("li" "private lateinit var $0" "private lateinit va" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/li" nil nil)
                       ("lf" "Log.d(TAG, \"${1: }()\")\n$0" "Log.d for fun" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/lf" nil nil)
                       ("ld" "Log.d(TAG, \"$1\")\n$0" "Log.d" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ld" nil nil)
                       ("lc" "lowercase()$0" "lowercase()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/lc" nil nil)
                       ("ifo" "if (${1:condition}) \n    $0" "ifOneLine" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ifo" nil nil)
                       ("ifee" "if (${1:condition}) {\n    $2\n} else if (${3:condition}) {\n    $4\n} else {\n    $5\n}\n" "if, else if, else" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ifee" nil nil)
                       ("ife" "if (${1:condition}) {\n    $2\n} else {\n    $3\n}" "if, else" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ife" nil nil)
                       ("if" "if (${1:condition}) {\n    $0\n}" "if" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/if" nil nil)
                       ("ia" "var ${1:a}: Array<Int> = arrayOf($2)\n$0\n" "val a: Array<Int> = arrayOf()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/ia" nil nil)
                       ("fvo" "for (${1:i} in $2) $0" "for value in values one line" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fvo" nil nil)
                       ("fv" "for (${1:i} in $2) {\n    $0\n}" "for value in values" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fv" nil nil)
                       ("fuo" "for (${1:i} in $2 until $3) \n    $0" "for (i in 0 until ) one line" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fuo" nil nil)
                       ("fpr" "for ($1 in $2) \n    println($1)\n$0" "for-println()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fpr" nil nil)
                       ("fou" "for (${1:i} in $2 until $3) {\n    $0\n}" "for (i in 0 until )" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fou" nil nil)
                       ("foo" "for (${1:i} in ${2:0}..$3) $0" "for loop one line" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/foo" nil nil)
                       ("fv" "for (${1:i} in $2) {\n    $0\n}" "for value in values" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/fo" nil nil)
                       ("em" "// <<<<<<<<<< $0" "commenting emphasis" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/em" nil nil)
                       ("el" "// <<<<<<<<<<<<<<<<<<<< $0" "commenting emphasis Long" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/el" nil nil)
                       ("cts" "${1:a}.contentToString()$0" ".contentToString()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/cts" nil nil)
                       ("co" "companion object {\n    $0\n}" "companion object" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/co" nil nil)
                       ("cmp" "@Composable$0" "@Composable" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/cmp" nil nil)
                       ("cdts" "${1:a}.contentDeepToString()$0" ".contentDeepToString()" nil nil nil "c:/Users/blue_/AppData/Roaming/.emacs.d/snippets/kotlin-mode/cdts" nil nil)))


;;; Do not edit! File generated at Fri Feb  3 22:10:07 2023
