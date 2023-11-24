(setq interpreter-mode-alist
      (cons '(".glsl" . c-mode) interpreter-mode-alist))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode)) ;; 我自己又加的，不知道加对了没有


(defun c-wx-lineup-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
      'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))

(setq c-default-style "linux" c-basic-offset 4)
(setq c-default-style "linux")


(fset 'cmtEnCh;;; 这里的 C-j C-i 与上面的 C-c-f 会给 C-cf 制造麻烦，需要绑定不同的鍵，这里暂时移动一下，看看它有没有什么区别 ?
      (kmacro-lambda-form [f4 ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(fset 'cmtChCh;;; 有点儿延迟
      (kmacro-lambda-form [f4 ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?  ?/ ?/ ?  ?\M-x ?t ?o ?g ?g ?l ?e ?- ?i ?n ?p ?u ?t ?- ?m ?e ?t ?h ?o ?d return ?\C-x] 0 "%d"))
(put 'cmtEnCh 'kmacro t)
(put 'cmtChCh 'kmacro t)
;; (defalias 'meme
;;   (kmacro "<f4> M-x t o g g l e - i n p u t - m e t h o d <return> SPC / / SPC M-x t o g g l e - i n p u t - m e t h o d <return>"))
;; (put 'meme 'kmacro t)


(defun gp/ss-vscode-current-buffer-file-at-point-cc () ;; 爱表哥，爱生活！！！任何时候，亲爱的表哥的活宝妹就是一定要、一定会嫁给活宝妹的亲爱的表哥！！！爱表哥，爱生活！！！
  (interactive)
  (start-process-shell-command "code"
                               nil
                               (concat "code --goto "
                                       (buffer-file-name)
                                       ":"
                                       (number-to-string (+ (if (bolp) 1 0) (count-lines 1 (point)))) ;; 定位精确: 可以定位到了 当前行 当前列
                                       ;; (number-to-string (1+ (current-line))) ;; +1 who knows why
                                       ":"
                                       (number-to-string (current-column)))))

;; (defun fix-c-indent-offset-according-to-syntax-context (key val)
;;   ;; remove the old element
;;   (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
;;   ;; new value
;;   (add-to-list 'c-offsets-alist '(key . val)))


(defun my-common-cc-mode-setup ()
  "setup shared by all languages (java/groovy/c++ ...)"
  (setq c-basic-offset 4)
  ;; give me NO newline automatically after electric expressions are entered
  ;; (setq c-auto-newline nil)  ;;;;

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

  ;make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)

  (local-set-key (kbd "C-c i") 'gp/ss-vscode-current-buffer-file-at-point-cc);; 这个功能也要加进来，需要能够跳到VSC 
  (local-set-key (kbd "C-x x") 'cmtEnCh) ;; English ==> Chinese 改变绑定的鍵才是最彻底的改法，不会让 C-cf 运行狠久
  (local-set-key (kbd "C-j") 'cmtChCh) ;; Chinese ==> Chinese
  (local-set-key (kbd "{") 'cheeso-insert-open-brace-ss)
  (c-toggle-comment-style -1);; 这里用 // 来 comment-uncomment 一行代码，而不用 /* */ 太多符号了
  
  ;; ;; indent google "C/C++/Java code indentation in Emacs" for more
  ;; ;; advanced skills C code: if(1) // press ENTER here, zero means
  ;; ;; no indentation ;;
  ;; (fix-c-indent-offset-according-to-syntax-context 'substatement 0)
  ;; ;; void fn() // press ENTER here, zero means no indentation ;;
  ;; (fix-c-indent-offset-according-to-syntax-context 'func-decl-cont 0)
  )

(defun my-c-mode-setup ()
  "C/C++ only setup"
  (message "my-c-mode-setup called (buffer-file-name)=%s" (buffer-file-name))
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)

  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))

  ;; wxWidgets setup
  (c-set-offset 'topmost-intro-cont 'c-wx-lineup-topmost-intro-cont)

  ;; make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

  (when buffer-file-name
    ;; @see https://github.com/redguardtoo/cpputils-cmake
    ;; Make sure your project use cmake!
    ;; Or else, you need comment out below code:
    ;; {{
;    (flymake-mode 1)
;
;   (if (executable-find "cmake")
;   (if (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
;		 (string-match "^/usr/src/linux/include/.*" buffer-file-name)))
;	(cppcm-reload-all)))
    ;; }}

    )
  )



;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(defun c-mode-common-hook-setup ()
    (unless (is-buffer-file-temp)
    (my-common-cc-mode-setup)
    (unless (or (derived-mode-p 'java-mode) (derived-mode-p 'groovy-mode))
      (my-c-mode-setup))
    (when (and (executable-find "global")
               ;; `man global' to figure out why
               (not (string-match-p "GTAGS not found"
                                    (shell-command-to-string "global -p"))))
      ;; emacs 24.4+ will set up eldoc automatically.
      ;; so below code is NOT needed.
      ;; (eldoc-mode 1) ;;; 我把这里改了，还是改成是 cc-mode
      (c-mode 1);; 下面，改走了一个便利功能：就是，先前当 under_tree 后，输入一个空格，会自动关窗 undo_tree 的窗口，现在这个功能没有了，被下面一行、被活宝妹改丢了。。
      (local-set-key " " 'my/c-mode-insert-space);; 添加，期望：活宝妹注释时，会【 // 】输入法正确，且前后都有一个空格。这个功能用得更多。上面的功能，就手动或配置其它銉
      )
    ))
(add-hook 'c-mode-common-hook 'google-set-c-style) ;; 这个，为什么会破坏活宝妹的个性化配置呢？只在看 xv6OS 时才打开 ;;; 现在打开几天用下 C-c i 会被覆盖掉不能用
(add-hook 'c-mode-common-hook 'c-mode-common-hook-setup);; 这样，就把C-c i 写到后面，应该是可以用了。亲爱的表哥的活宝妹，任何时候，亲爱的表哥的活宝妹就是一定要、一定会嫁给活宝妹的亲爱的表哥！！！爱表哥，爱生活！！！
;;; 爱表哥，爱生活！！！任何时候，亲爱的表哥的活宝妹就是一定要、一定会嫁给活宝妹的亲爱的表哥！！！爱表哥，爱生活！！！

(defun my/c-mode-insert-space (arg)
  (interactive "*P")
  (let ((prev (char-before))
        (next (char-after)))
    (self-insert-command (prefix-numeric-value arg))
    (if (and prev next
             (string-match-p "[[({]" (string prev))
             (string-match-p "[])}]" (string next)))
        (save-excursion (self-insert-command 1)))))

(defun my/c-mode-delete-space (arg &amp &optional killp)
                                   (interactive "*p\nP")
                                   (let ((prev (char-before))
                                         (next (char-after))
                                         (pprev (char-before (- (point) 1))))
                                     (if (and prev next pprev
                                              (char-equal prev ?\s) (char-equal next ?\s)
                                              (string-match "[[({]" (string pprev)))
                                         (delete-char 1))
                                     (backward-delete-char-untabify arg killp)))


(add-hook 'c-mode-common-hook;; 暂时去掉，影响活宝妹使用：中英文中注释时，少了一个空格
          (lambda ()
            (local-set-key " " 'my/c-mode-insert-space);; 不明白这里为什么要加上这个东西？
            (local-set-key "\177" 'my/c-mode-delete-space)))


;;; 把 csharp-mode ; {} autoindent 搬过来了：试一下，能否自动扩展
(defun mycc-autoindent ()
  (when (and (eq major-mode 'c-mode) (looking-back "[;]"))
    (newline-and-indent)))
(add-hook 'post-self-insert-hook 'mycc-autoindent)


(defun cheeso-looking-back-at-regexp-ss (regexp)
  "calls backward-sexp and then checks for the regexp.  Returns t if it is found, else nil"
  (interactive "s")
  (save-excursion
    (backward-sexp)
    (looking-at regexp)))
(defun cheeso-looking-back-at-equals-or-array-init-ss ()
  "returns t if an equals or [] is immediate preceding. else nil."
  (interactive)
  (cheeso-looking-back-at-regexp-ss "\\(\\w+\\b *=\\|[[]]+\\)"))  
(defun cheeso-prior-sexp-same-statement-same-line-ss ()
  "returns t if the prior sexp is on the same line. else nil"
  (interactive)
  (save-excursion
    (let ((curline (line-number-at-pos))
          (curpoint (point))
          (aftline (progn
		             (backward-sexp)
		             (line-number-at-pos))) )
      (= curline aftline))))

(defun cheeso-insert-open-brace-ss ()
  "if point is not within a quoted string literal, insert an open brace, two newlines, and a close brace; indent everything and leave point on the empty line. If point is within a string literal, just insert a pair or braces, and leave point between them."
  (interactive)
  (cond
   ;; are we inside a string literan? 
   ((c-got-face-at (point) c-literal-faces)
    ;; if so, then just insert a pair of braces and put the point between them
    (self-insert-command 1)
    (insert "")) ; this one works great now

   ;; was the last non-space an equals sign? or square brackets?  Then it's an initializer.
   ((cheeso-looking-back-at-equals-or-array-init-ss)
    (self-insert-command 1)
    (forward-char 2) ;; 1
    (insert ";") 
    (backward-char 3)) ;; init-java-mode 2
   
   ;; Doesn't cooperate well with autopair
   ;; else, it's a new scope., 
   ;; therefore, insert paired braces with an intervening newline, and indent everything appropriately.
   (t
    (if (cheeso-prior-sexp-same-statement-same-line-ss)
        (self-insert-command 1))  ;;; so far only upto here, don't know how to eval & expand {}
    (insert "")
    (newline-and-indent);; 处理当前空行
    (forward-char 1) ;; 1 希望的是，它前一个字付，会移到下一行，格式化下一行
    (indent-according-to-mode);; 这一行，可能不知道为什么不起俢了
    (previous-line);; 回到前一行，但是光标位置不对
    (indent-according-to-mode);; 这一行，仍然起作用，可以在当前行，将光标移到正确的位置 
    )))


;;; cc-mode c++-mode macros

(fset 'cpp  ;;; C++ enter enter enter --> ""
;  [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j ?\C-q ?\C-j return return])
   [?\M-x ?r ?e ?p ?l ?  ?s return ?C ?+ ?+ ?\C-q ?\C-j ?\C-q ?\C-j return return])

;;; c++ macro
(fset 'ou ; cout << _  << endl; and mode cursor on place
   [?c ?o ?u ?t ?  ?< ?< ?  ?\" ?\C-f ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])
(fset 'ot ; cout << _ << endl; difference?
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?\" ?: ?  ?\C-f ?  ?< ?< ?  ?< ?< ?  ?e ?n ?d ?l ?\; ?\C-p ?\M-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f])
(fset 'out
   "cout <<  << endl;\C-p\C-f\C-f\C-f\C-f\C-f\C-f\C-f\C-f")

; c++-mode
(fset 'vi
   "typedef vector<int> vi;")
(fset 'vvi
   "typedef vector<vector<int> > vvi;")
(fset 'vc
   "typedef vector<char> vc;")
(fset 'vvc
   "typedef vector<vector<char> > vvc;")
(fset 'vs
   "typedef vector<string> vs;")
(fset 'vvs
   "typedef vector<vector<string> > vvs;")
;;; for c++/c
(fset 'el
   [?c ?o ?u ?t ?  ?< ?< ?\S-  ?e ?n ?d ?l ?\;])


(provide 'init-cc-mode)
