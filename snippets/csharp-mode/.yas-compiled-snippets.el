;;; Compiled snippets and support files for `csharp-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'csharp-mode
                     '(("xy" "x][y][z$0" "x][y][z" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/xy" nil nil)
                       ("xx" "$1][$2][$3$0" "[][][]" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/xx" nil nil)
                       ("vrc" "ViewManager.rotateCanvas$0" "ViewManager.rotateCanvas" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vrc" nil nil)
                       ("vr" "ViewManager.$0" "ViewManager." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vr" nil nil)
                       ("vn" "ViewManager.nextTetromino$0" "ViewManager.nextTetromino" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vn" nil nil)
                       ("vmp" "((MenuViewModel)ViewModel.ParentViewModel).$0" "ViewModel..ParentViewModel" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vmp" nil nil)
                       ("vmc" "ViewManager.moveCanvas$0" "ViewManager.moveCanvas" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vmc" nil nil)
                       ("vm" "ViewModel.$0" "ViewModel." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vm" nil nil)
                       ("vi" "VolumeManager.Instance.$0" "VolumeManager.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vi" nil nil)
                       ("vg" "ViewManager.ghostTetromino$0" "ViewManager.ghostTetromino" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vg" nil nil)
                       ("vcv" "ViewManager.ChallLevelsView.$0" "ViewManager.ChallLevelsView." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/vcv" nil nil)
                       ("va" "Value$0" "Value" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/va" nil nil)
                       ("tsv" "this.$1 = $1;$0" "this" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/tsv" nil nil)
                       ("ts" "ToString()$0" "toString()" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ts" nil nil)
                       ("tg" "private const string TAG = \"$1\";\n$0" "TAGforCsharp" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/tg" nil nil)
                       ("td" "TODO:$0" "TODO" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/td" nil nil)
                       ("sv" "self.$1 = $2.$1;\n$0" "self.var" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/sv" nil nil)
                       ("st" "$1.SetActive(true);\n$0" "(go).SetActive(true);" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/st" nil nil)
                       ("sp" "SetParent($1)$0" "SetParent()" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/sp" nil nil)
                       ("sf" "$1.SetActive(false);\n$0" "(go).SetActive(false);" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/sf" nil nil)
                       ("se" "String.Equals($1);$0\n" "String.Equals" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/se" nil nil)
                       ("rt" "return true$0" "rt" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/rt" nil nil)
                       ("rn" "return $0" "return" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/rn" nil nil)
                       ("ris" "Root.Instance.Scene.$0" "ris" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ris" nil nil)
                       ("rin" "Root.Instance$0" "Root.instanONEce" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/rin" nil nil)
                       ("rf" "return false$0" "rf" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/rf" nil nil)
                       ("pvc" "System.out.println(\"${1:i}: \" + $1); \n$0" "printlVariables" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pvc" nil nil)
                       ("pv" "MathUtil.print($1);\n$0" "printlVariables" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pv" nil nil)
                       ("psc" "public static class $0" "public static class" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/psc" nil nil)
                       ("pn" "MathUtil.print(ViewManager.nextTetromino.transform.position);$0" "print(nextTetromino.transform.position)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pn" nil nil)
                       ("pm" "$0【$1】" "【】 for 中文小括号" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pm" nil nil)
                       ("pi" "PoolManager.Instance.$0" "PoolManager.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pi" nil nil)
                       ("ph" "PoolHelper.$0" "PoolHelper." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ph" nil nil)
                       ("pc" "public class $0" "public class" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pc" nil nil)
                       ("pas" "Debug.Log(string.Join(\", \", $1));$0\n" "Debug.Log(StringArray)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/pas" nil nil)
                       ("mp" "MathUtilP.print($1);\n$0" "mp" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mp" nil nil)
                       ("mo" "Model.gridOcc$0" "Model.gridOcc" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mo" nil nil)
                       ("mgxy" "Model.grid[x][y][z]$0" "Model.grid[x][y][z]" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mgxy" nil nil)
                       ("mgxx" "Model.grid[$1][$2][$3]$0" "Model.grid[$1][$2][$3]" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mgxx" nil nil)
                       ("mgoxy" "Model.gridOcc[x][y][z]$0" "Model.gridOcc[x][y][z]" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mgoxy" nil nil)
                       ("mgoxx" "Model.gridOcc[$1][$2][$3]$0" "Model.gridOcc[$1][$2][$3]" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mgoxx" nil nil)
                       ("mg" "Model.grid$0" "Model.grid" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mg" nil nil)
                       ("mc" "Model.gridClr$0" "Model.gridClr" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/mc" nil nil)
                       ("lv" "Log.ILog.Debug(TAG + \": ${1:v}: \" + $1);\n$0" "Log.ILog.Debug($\"v: {v}\")" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/lv" nil nil)
                       ("lst" "tac log1.log | awk '!flag; /$1:00.00/{flag = 1};' | tac > cur.log$0\n" "lastOccuranceToEndOfFileContents" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/lst" nil nil)
                       ("le" "Log.Error($1)$0" "Log.Error()" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/le" nil nil)
                       ("ins" "Instance.$0" "Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ins" nil nil)
                       ("in" "Manager.Instance.$0" "Manager.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/in" nil nil)
                       ("imi" "int.MinValue$0" "imi" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/imi" nil nil)
                       ("ima" "int.MaxValue$0" "ima" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ima" nil nil)
                       ("gvm" "((GameViewModel)ViewManager.GameView.ViewModel)$0" "ViewManager.GameView.ViewModel" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gvm" nil nil)
                       ("gv" "ViewManager.GameView.$0" "ViewManager.GameView." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gv" nil nil)
                       ("gt" "gameObject.transform$0" "gameObject.transform" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gt" nil nil)
                       ("gs" "{ get; set; }\n$0" "get;set;1 line" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gs" nil nil)
                       ("go" "gameObject$0" "gameObject" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/go" nil nil)
                       ("gii" "GloData.Instance.hasInitCubes$0" "GloData.Instance.hasInitCubes" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gii" nil nil)
                       ("gi" "GloData.Instance.$0" "GloData.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gi" nil nil)
                       ("gh" "GameObjectHelper$0" "GameObjectHelper" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gh" nil nil)
                       ("gc" "GetComponent<$1>()$0" "GetComponent<>" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/gc" nil nil)
                       ("fst" "tac log1.log | awk '!flag; /$1:00.00/{flag = 1};' | tac > cur.log$0\n" "firstOccuranceToEndofFileContents" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/fst" nil nil)
                       ("foo" "for (int ${1:i} = ${2:0}; $1 < ${3:n}; $1++) \n    $0\n    " "forOneLine" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/foo" nil nil)
                       ("fo" "for (int ${1:i} = ${2:0}; $1 < ${3:n}; $1++) {\n    $0\n}" "for" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/fo" nil nil)
                       ("fj" "btnState.Value[$1] = true;\n$0" "ForTmpUseOnly" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/fj" nil nil)
                       ("ff" "btnState.Value[$1] = false;\n$0" "ForTmpUseOnlyFalse" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ff" nil nil)
                       ("eq" "Equals(${1:s})$0" "Equals" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/eq" nil nil)
                       ("em" " // <<<<<<<<<< $0" "commenting emphasis" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/em" nil nil)
                       ("el" " // <<<<<<<<<<<<<<<<<<<< $0" "commenting emphasis long" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/el" nil nil)
                       ("eif" "EventManager.Instance.FireEvent(\"$1\"$2);$0" "EventManager.Instance.FireEvent(\"type\")" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/eif" nil nil)
                       ("ei" "EventManager.Instance.$0" "EventManager.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ei" nil nil)
                       ("dvvv" "Debug.Log(TAG + \" ${1:func}() ${2:v1}: \" + $2 + \" ${3:v2}: \" + $3 + \" ${4:v3}: \" + $4);\n$0" "Debug.LogVariableVariableVar" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/dvvv" nil nil)
                       ("dv" "Debug.Log(TAG + \" $1: \" + $1);\n$0" "Debug.LogVariableNoFunc" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/dv" nil nil)
                       ("dl" "Debug.Log(TAG + \" $1()\");$0\n" "Debug.Log" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/dl" nil nil)
                       ("dfvv" "Debug.Log(TAG + \" ${1:func}() ${2:v1}: \" + $2 + \" ${3:v2}\" + $3);\n$0" "Debug.LogVariableVariable" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/dfvv" nil nil)
                       ("dfv" "Debug.Log(TAG + \" ${1:func}() ${2:var}: \" + $2);\n$0" "Debug.LogVariable" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/dfv" nil nil)
                       ("cv" "Console.WriteLine(TAG + \" $1 = \" + $1);\n$0" "Console.WriteLine(v + v)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/cv" nil nil)
                       ("ct" "Console.WriteLine(\" $1 = \" + $1);\n$0" "Console.WriteLineNoTag(v + v)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ct" nil nil)
                       ("cp" "Console.WriteLine(\"$1\");\n$0" "Console.WriteLine()" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/cp" nil nil)
                       ("cot" "[ComponentOf(typeof($1))]$0" "cot" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/cot" nil nil)
                       ("cl" "Console.WriteLine(TAG + \" $1\");\n$0" "Console.WriteLine(msg)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/cl" nil nil)
                       ("ck" "ContainsKey(${1:k})$0" "ContainsKey()" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ck" nil nil)
                       ("vr" "ViewManager.$0" "ViewManager." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ch" nil nil)
                       ("cfv" "Console.WriteLine(TAG + \"${1:f} ${2:v} = \" + $2);\n$0" "Console.WriteLine(msg + v + v)" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/cfv" nil nil)
                       ("ai" "AudioManager.Instance.$0" "Manager.Instance." nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ai" nil nil)
                       ("aet" "await ETTask.CompletedTask;$0" "aet" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/aet" nil nil)
                       ("ac" "AddComponent<$1>()$0" "AddComponent<>" nil nil nil "/Users/hhj/.emacs.d/snippets/csharp-mode/ac" nil nil)))


;;; Do not edit! File generated at Sat Oct 28 14:08:48 2023
