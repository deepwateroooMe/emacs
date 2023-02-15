;;;;; 配置pyim emacs-rime 在emacs 中的前端

;;;;; 配置五笔词库
(require 'pyim-wbdict)
(setq pyim-default-scheme 'wubi)
(pyim-wbdict-v86-enable) ;86版五笔用户使用这个命令
;; (pyim-wbdict-v86-single-enable) ;86版五笔用户使用这个命令，该词库为单字词库，以尽可能不重码减少选词需要为目的


(require 'pyim)
(require 'posframe) ;; 使用 posframe 来绘制选词框
(require 'liberime) 

(setq default-input-method "pyim")

;; 如果使用 popup page tooltip, 就需要加载 popup 包。
(require 'popup nil t)
;; (setq pyim-page-tooltip 'popup) ;; 使用 popup 包来绘制选词框 （emacs overlay 机制）
(setq pyim-page-tooltip 'posframe) 
;; (setq pyim-page-style 'one-line) ;; 默认是双行显示

;; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
(require 'pyim-dregcache)
(setq pyim-dcache-backend 'pyim-dregcache)

;; 显示 7 个候选词。
(setq pyim-page-length 7)

(require 'pyim-cregexp-utils)


;; ;; 我觉得liberime 这个模块，我还没有配置好，我现配置的提供的路径下可能都还没有
(liberime-start "/usr/share/rime-data" "~/.emacs.d/Rime/") 

;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)


(liberime-select-schema "wubi86_jidian")
;; 设置 pyim 默认使用的输入法策略，我使用全拼。
(setq pyim-default-scheme 'wubi)

;; ;; 设置 pyim 是否使用云拼音
;; (setq pyim-cloudim 'baidu)

;; ;; 设置 pyim 探针
;; ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; ;; 我自己使用的中英文动态切换规则是：
;; ;; 1. 光标只有在注释里面时，才可以输入中文。
;; ;; 2. 光标前是汉字字符时，才能输入中文。
;; ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;; (setq-default pyim-english-input-switch-functions
;;               '(pyim-probe-dynamic-english
;;                 pyim-probe-isearch-mode
;;                 pyim-probe-program-mode
;;                 pyim-probe-org-structure-template))
;; (setq-default pyim-punctuation-half-width-functions
;;               '(pyim-probe-punctuation-line-beginning
;;                 pyim-probe-punctuation-after-punctuation))

;; 开启代码搜索中文功能（比如拼音，五笔码等）
(pyim-isearch-mode 1)


;; 魔术转换盒
(defun my-converter (string)
  (if (equal string "表哥") ;; 好像这里不起作用呀
      "“亲爱的表哥，活宝妹一定要嫁的亲爱的表哥！！！”"
    string))
(setq pyim-magic-converter #'my-converter)


;; 标点符号全半角
;; (setq pyim-punctuation-translate-p '(yes no auto))   ;使用全角标点。
(setq pyim-punctuation-translate-p '(no yes auto))   ;使用半角标点。
;; (setq pyim-punctuation-translate-p '(auto yes no))   ;中文使用全角标点，英文使用半角标点。


(provide 'init-pyim)
