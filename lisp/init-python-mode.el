(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

;; run command `pip install jedi flake8 importmagic` in shell,
;; or just check https://github.com/jorgenschaefer/elpy
(elpy-enable)

(defun my-python-mode-config ()
  (setq python-indent-offset 4
        python-indent 4
        indent-tabs-mode nil
        default-tab-width 4

        ;; 设置 run-python 的参数
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i"
        python-shell-prompt-regexp "In \\[[0-9]+\\]: "
        python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
        python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
        python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
        python-shell-completion-string-code  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (hs-minor-mode t)                     ;开启 hs-minor-mode 以支持代码折叠
  (auto-fill-mode 0)                    ;关闭 auto-fill-mode，拒绝自动折行
  (whitespace-mode t)                   ;开启 whitespace-mode 对制表符和行为空格高亮
  (hl-line-mode t)                      ;开启 hl-line-mode 对当前行进行高亮
  (pretty-symbols-mode t)               ;开启 pretty-symbols-mode 将 lambda 显示成希腊字符 λ
  (set (make-local-variable 'electric-indent-mode) nil)) ;关闭自动缩进

(add-hook 'python-mode-hook 'my-python-mode-config)

(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

(setq jedi:environment-root "jedi")
;(setq jedi:server-command (jedi:-env-server-commmand)) ;; void-function jedi:-env-server-command


(defun config/enable-jedi ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'config/enable-jedi)


;; 还有一些补全的细节可以设置
;; 输入句点符号 "." 的时候自动弹出补全列表，这个主要是方便用来选择 Python package 的子模块或者方法
(setq jedi:complete-on-dot t)

;; 补全时能识别简写，这个是说如果我写了 "import tensorflow as tf" ，那么我再输入 "tf." 的时候能自动补全
(setq jedi:use-shortcuts t)

;; 设置补全时需要的最小字数(默认就是 3)
(setq compandy-minimum-prefix-length 3)

;; 设置弹出的补全列表的外观
;; 让补全列表里的各项左右对齐
(setq company-tooltip-align-annotations t)

;; 补全列表里的项按照使用的频次排序，这样经常使用到的会放在前面，减少按键次数
(setq company-transformers '(company-sort-by-occurrence))

;; 在弹出的补全列表里移动时可以前后循环，默认如果移动到了最后一个是没有办法再往下移动的
(setq company-selection-wrap-around t)


;; flycheck-mode
(defun config/enable-flycheck ()
  (flycheck-mode t))
(add-hook 'python-mode-hook 'config/enable-flycheck)

(push "~/.emacs.d/.python-environments/jedi/bin/" exec-path)

(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; 默认的一个标准是每行最大字符数为 80，如果超过了，格式化的时候会将该行折行。下面的配置可以设置为 200
(setq py-autopep8-options '("--max-line-length=200"))


;(defun python-mode-hook-setup ()
                                        ;  (unless (is-buffer-file-temp)
                                        ;    ;; http://emacs.stackexchange.com/questions/3322/python-auto-indent-problem/3338#3338
                                        ;    ;; emacs 24.4 only
                                        ;    (setq electric-indent-chars (delq ?: electric-indent-chars))))
                                        ;(add-hook 'python-mode-hook 'python-mode-hook-setup)


;;; for python-mode comment (cpy) and decommment (dcp)
(fset 'cpy
   "\C-a#\C-n\C-a")
(fset 'dcp
   "\C-a\C-d\C-n\C-a")
;;; for python-mode comment and decomment
(global-set-key (kbd "C-c c") 'cpy)
(put 'cpy 'kmacro t)
(global-set-key (kbd "C-c d") 'dcp)
(put 'dcp 'kmacro t)


;;; for python
(fset 'mpy    ;  #!/usr/local/bin/python3
   [?# ?! ?/ ?u ?s ?r ?/ ?l ?o ?c ?a ?l ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n ?3 return return])
(fset 'apt
   "print \C-n\C-a")
(fset 'dpt
   "\C-d\C-d\C-d\C-d\C-d\C-d\C-n")



(provide 'init-python-mode)
