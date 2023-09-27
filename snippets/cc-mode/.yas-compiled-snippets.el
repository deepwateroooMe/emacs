;;; Compiled snippets and support files for `cc-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'cc-mode
                     '(("wio" "while ($1) $0" "wio" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/wio" nil nil)
                       ("wie" "while (!${1:q}.isEmpty()) {\n    $0\n}" "while (!s.isEmpty())" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/wie" nil nil)
                       ("wi" "while ($1) {\n    $0\n}" "wi" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/wi" nil nil)
                       ("while" "while (${1:condition}) {\n      $0\n}" "while" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/while" nil nil)
                       ("weo" "while (!${1:q}.isEmpty()) $0" "while (!q.isEmpty())" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/weo" nil nil)
                       ("wea" "while (!${1:q}.isEmpty() && $2) $0" "while (!q.isEmpty() && )" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/wea" nil nil)
                       ("uni" "#include <unistd.h>" "unistd" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/unistd" nil nil)
                       ("union" "typedef union {\n        $0\n} ${1:name};" "union" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/union" nil nil)
                       ("typedef" "typedef ${1:type} ${2:alias};" "typedef" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/typedef" nil nil)
                       ("?" "(${1:cond}) ? ${2:then} : ${3:else};" "ternary" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/ternary" nil nil)
                       ("switch" "switch (${1:expr}) {\ncase ${2:constexpr}:${3: \\{}\n    $0\n    break;\n${3:$(if (string-match \"\\{\" yas-text) \"\\}\\n\" \"\")}default:\n    break;\n}" "switch (...) { case : ... default: ...}" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/switch" nil nil)
                       ("struct" "struct ${1:name}\n{\n    $0\n};" "struct ... { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/struct" nil nil)
                       ("str" "#include <string.h>" "string" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/string" nil nil)
                       ("std" "#include <stdlib.h>\n" "stdlib" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/stdlib" nil nil)
                       ("io" "#include <stdio.h>" "stdio" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/stdio" nil nil)
                       ("rn" "return $0" "return" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/rn" nil nil)
                       ("pv" "uprintf(\"$1 = %${2:d}\\n\\r\", $1, \"\", '\\0');$0" "pv" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/pv" nil nil)
                       ("pr" "printf(\"${1:format string}\"${2: ,a0,a1});" "printf" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/printf" nil nil)
                       ("pf" "printf(\"$1\\n\"$2);$0" "pf" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/pf" nil nil)
                       ("packed" "__attribute__((__packed__))$0" "packed" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/packed" nil nil)
                       ("once" "#ifndef ${1:`(upcase (file-name-nondirectory (file-name-sans-extension (or (buffer-file-name) \"\"))))`_H}\n#define $1\n\n$0\n\n#endif /* $1 */" "#ifndef XXX; #define XXX; #endif" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/once" nil nil)
                       ("mmi" "Math.min(${1:a}, ${2:b})$0" "Math.min(" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/mmi" nil nil)
                       ("mma" "Math.max(${1:a}, ${2:b})$0" "Math.max(" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/mma" nil nil)
                       ("!<" "/*!< ${1:Detailed description after the member} */" "Member description" nil
                        ("doxygen")
                        nil "/Users/hhj/.emacs.d/snippets/cc-mode/member_description" nil nil)
                       ("math" "#include <math.h>\n$0" "math" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/math" nil nil)
                       ("malloc" "malloc(sizeof($1)${2: * ${3:3}});\n$0" "malloc" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/malloc" nil nil)
                       ("main" "int main(${1:int argc, char *argv[argc]})\n{\n    $0\n    return 0;\n}\n" "main" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/main" nil nil)
                       ("incl" "#include \"$1\"" "#include \"...\"" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/inc.1" nil nil)
                       ("incs" "#include <$1>" "#include <...>" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/inc" nil nil)
                       ("ifdef" "#ifdef ${1:MACRO}\n\n$0\n\n#endif // $1" "ifdef" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/ifdef" nil nil)
                       ("ifc" "if (${1:condition}) ${2:{\n    $0\n}}" "if (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/if" nil nil)
                       ("fz" "f[x][y][z]$0" "f[x][y][z]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fz" nil nil)
                       ("fy" "f[x][y]$0" "f[x][y]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fy" nil nil)
                       ("fx" "f[x]$0" "f[x]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fx" nil nil)
                       ("fvo" "for (${1:int} ${2:v} : ${3:a}) $0" "for values() one line" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fvo" nil nil)
                       ("fv" "for (${1:int} ${2:v} : ${3:a}) {\n    $0\n}" "for values()" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fv" nil nil)
                       ("\\brief" "/**\n *  \\brief ${1:function description}\n ${2:*\n *  ${3:Detailed description}\n *\n }*  \\param ${4:param}\n *  \\return ${5:return type}\n */" "Function description" nil
                        ("doxygen")
                        nil "/Users/hhj/.emacs.d/snippets/cc-mode/function_description" nil nil)
                       ("ftn" "for (TreeNode ${1:prev} = $2) {\n    $0\n}\n" "ftn (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/ftn" nil nil)
                       ("fsc" "for (String ${1:i} : ${2}) {\n    $0\n}\n" "for (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fsc" nil nil)
                       ("frc" "for (char ${1:i} = '${2:a}'; $1 <= '${3:z}'; $1++) {\n    $0\n}\n" "for (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/frc" nil nil)
                       ("fo" "for (int ${1:i} = ${2:0}; $1 < ${3:n}; $1++) {\n    $0\n}" "for" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fp" nil nil)
                       ("fit" "for (Iterator ${1:it} = $2.iterator(); $1.hasNext(); ) {\n    ${3:String} ${4:name} = ($3)$1.next();\n    $0\n}\n" "for (Iterator ...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/forit" nil nil)
                       ("fori" "for (${1:Object el} : ${2:iterator}) {\n    $0\n}\n" "fori" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fori" nil nil)
                       ("forn" "for (${1:auto }${2:i} = ${3:0}; $2 < ${4:MAXIMUM}; ++$2) {\n    $0\n}\n" "for_n" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/for_n" nil nil)
                       ("for" "for (${1:int i = 0}; ${2:i < N}; ${3:i++}) {\n    $0\n}" "for" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/for" nil nil)
                       ("fopen" "FILE *${fp} = fopen(${\"file\"}, \"${r}\");" "FILE *fp = fopen(..., ...);" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fopen" nil nil)
                       ("fooc" "for (char ${1:c} = '${2:a}'; $1 <'${3:z}'; $1++) $0" "for (char i = ''; i < ''; i++) single line" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fooc" nil nil)
                       ("foo" "for (int ${1:i} = ${2:0}; $1 < ${3:n}; $1++) $0" "forOneLine" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/foo" nil nil)
                       ("foc" "for (char ${1:c} = '${2:a}'; $1 < '${3:z}'; $1++) {\n    $0\n}" "for (char i = ''; i < ''; i++)" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/foc" nil nil)
                       ("fo" "for (int ${1:i} = ${2:0}; $1 < ${3:n}; $1++) {\n    $0\n}" "for" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fo" nil nil)
                       ("fmvk" "for (Map.Entry<${1:Integer, Integer}> en : ${2:m}.entrySet()) {\n    $3\n}$0" "for map ValueKey pair" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fmvk" nil nil)
                       ("fmv" "for (${1:int} ${2:val} : ${3:m}.values()) {\n    $3\n}$0" "for map values()" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fmv" nil nil)
                       ("fmkv" "for (Map.Entry<${1:Integer, Integer}> en : ${2:m}.entrySet()) {\n    $3\n}$0" "for map KeyValue pair" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fmkv" nil nil)
                       ("fmk" "for (${1:int} key : ${2:m}.keySet()) {\n    $3\n}$0" "for map keySet" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fmk" nil nil)
                       ("fme" "for (Map.Entry<${1:Integer, Integer}> en : ${2:m}.entrySet()) {\n    $0\n}" "forMayEntrySet" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fme" nil nil)
                       ("fln" "for (ListNode ${1:prev} = $2) {\n    $0\n}\n" "fln (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fln" nil nil)
                       ("fkd" "f[k-1]$0" "f[k-1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fkd" nil nil)
                       ("fka" "f[k+1]$0" "f[k+1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fka" nil nil)
                       ("fk" "f[i][j][k]$0" "f[i][j][k]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fk" nil nil)
                       ("fjd" "f[j-1]$0" "f[j-1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fjd" nil nil)
                       ("fja" "f[j+1]$0" "f[j+1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fja" nil nil)
                       ("fj" "f[i][j]$0" "f[i][j]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fj" nil nil)
                       ("\\file" "/**\n *   \\file ${1:`(file-name-nondirectory(buffer-file-name))`}\n *   \\brief ${2:A Documented file.}\n ${3:*\n *  ${4:Detailed description}\n *\n}*/\n" "File description" nil
                        ("doxygen")
                        nil "/Users/hhj/.emacs.d/snippets/cc-mode/file_description" nil nil)
                       ("file" "public class ${1:`(file-name-base\n                    (or (buffer-file-name)\n                        (buffer-name)))`} {\n  $0\n}\n" "file_class" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/file_class" nil nil)
                       ("fii" "f[i][i]$0" "f[i][i]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fii" nil nil)
                       ("fid" "f[i-1]$0" "f[i-1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fid" nil nil)
                       ("fic" "for (int ${1:i} : ${2}) {\n    $0\n}" "for (int i : some) {}" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fic" nil nil)
                       ("fib" "for (Integer ${1:i} : ${2}) {\n    $0\n}" "for (Integer i : some) {}" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fib" nil nil)
                       ("fia" "f[i+1]$0" "f[i+1]Add" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fia" nil nil)
                       ("fi" "f[i]$0" "f[i]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fi" nil nil)
                       ("fdo" "for (int ${1:i} = ${2:n-1}; $1 >= ${3:0}; $1--) \n    $0" "for (int i = n-1)" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fdo" nil nil)
                       ("fd" "for (int ${1:i} = ${2:n-1}; $1 >= ${3:0}; $1--) {\n    $0\n}" "for decreasing" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fd" nil nil)
                       ("fckat" "if (${1:map}.containsKey(${2:s}.charAt(${3}))) {\n    $0\n}" "if (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fckt" nil nil)
                       ("fck" "if (${1:map}.containsKey(${2})) {\n    $0\n}" "if (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fck" nil nil)
                       ("fcc" "for (Character ${1:i} : ${2}) {\n    $0\n}\n" "for (...) { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fcc" nil nil)
                       ("fa" "f[i+1]$0" "f[i+1]" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/fa" nil nil)
                       ("em" " // <<<<<<<<<< $0" "commenting emphasis" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/em" nil nil)
                       ("else" "else${1: {\n    $0\n}}" "else { ... }" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/else" nil nil)
                       ("el" " // <<<<<<<<<<<<<<<<<<<< $0" "commenting emphasis long" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/el" nil nil)
                       ("do" "do\n{\n    $0\n} while (${1:condition});" "do { ... } while (...)" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/do" nil nil)
                       ("d" "#define $0" "define" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/define" nil nil)
                       ("ctn" "continue;$0\n" "ctn" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/ctn" nil nil)
                       ("compile" "// -*- compile-command: \"${1:gcc -Wall -o ${2:dest} ${3:file}}\" -*-" "compile" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/compile" nil nil)
                       ("case" "case ${2:constexpr}:${3: \\{}\n    $0\n    break;\n${3:$(if (string-match \"\\{\" yas-text) \"\\}\" \"\")}" "case : {...}" nil nil
                        ((yas-also-auto-indent-first-line t))
                        "/Users/hhj/.emacs.d/snippets/cc-mode/case" nil nil)
                       ("ass" "#include <assert.h>\n$0" "assert" nil nil nil "/Users/hhj/.emacs.d/snippets/cc-mode/assert" nil nil)))


;;; Do not edit! File generated at Tue Sep 26 21:53:09 2023
