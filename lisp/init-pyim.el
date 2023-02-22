;;;;; 配置pyim emacs-rime 在emacs 中的前端

;; ;;; Require
;; (add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime")) ;拓展文件(插件)目录
;; (require 'rime)
;; (require 'pyim)
;; ;; (load-file "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime.el")


;; ;; (use-package! rime
;; ;;               :custom
;;               (setq default-input-method "rime")
;;               (setq rime-user-data-dir "c:/Users/blue_/AppData/Roaming/Rime")
;;               (setq rime-show-candidate 'posframe)
;;               (setq rime-posframe-style 'vertical)
;;               (setq rime-cursor "|")
;;               ;; (setq rime-share-data-dir "~/.emacs.d/emacs-rime/rime-data")
;; (setq rime-share-data-dir "C:/Program Files (x86)/Rime/weasel-0.14.3/data")
;; ;; )
;;               (setq rime-posframe-properties
;;                     (list :background-color "#333333"
;;                           :foreground-color "#dcdccc"
;;                           :font "华文楷体"
;;                           :internal-border-width 10)))

;; (setq default-input-method "rime"
;;       rime-show-candidate 'posframe))


;; Require
(add-to-list 'load-path (expand-file-name "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime")) ;拓展文件(插件)目录
;; (load-file "c:/Users/blue_/AppData/Roaming/.emacs.d/elpa/rime/rime.el")
(require 'rime)

(require 'pyim)
(require 'liberime nil t)
(setq default-input-method "pyim")
(with-eval-after-load "liberime"
  (liberime-try-select-schema "wubi86_jidian")
  ;; (setq pyim-default-scheme 'rime-quanpin)
  (setq pyim-default-scheme 'wubi)
  )

(defconst rime-usr-data-exists-p
  (file-exists-p "c:/Users/blue_/AppData/Roaming/Rime")
  "For checking if there is a rime user data.")

(when rime-usr-data-exists-p
  (require-package 'rime)

  (when (eq system-type 'windows-nt)
    (setq rime-share-data-dir "C:/Program Files (x86)/Rime/weasel-0.14.3/data")
    ;; (setq rime-share-data-dir
    ;;       "~/.emacs.d/elpa/rime/rime-data")
    )
  ;; (when (eq system-type 'darwin)
  ;;   (setq rime-librime-root  "~/emacs-data/librime/dist")
  )

(setq
 rime-inline-predicates '(rime-predicate-space-after-cc-p
                          rime-predicate-current-uppercase-letter-p)
 rime-translate-keybindings '("C-f" "C-b" "C-n" "C-p" "C-g")
 rime-inline-ascii-holder ?a
 default-input-method "rime"
 rime-cursor "|"
rime-show-candidate 'posframe
 ;; rime-show-candidate nil
 window-min-height 1
 rime-user-data-dir "c:/Users/blue_/AppData/Roaming/Rime"
 rime-title "")

(setq rime-inline-ascii-trigger 'shift-r)

(defun rime-toggle-show-candidate ()
  "Use minibuffer for candidate if current is nil."
  (interactive)
  (if (equal rime-show-candidate nil)
      (setq rime-show-candidate 'minibuffer)
    (setq rime-show-candidate nil)))

(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key (kbd "s-m") 'rime-force-enable)
(global-set-key (kbd "C-`") 'rime-send-keybinding)

;; 这里有错，暂放过
;; (with-eval-after-load 'rime
;;   (require 'im-cursor-chg)
;;   (cursor-chg-mode 1))


;; ;;; Code:
;; (when (eq system-type 'windows-nt)
;;   (setq rime-user-data-dir "~/.emacs.d/rime/Rime")
;;   (setq rime-share-data-dir "~/.emacs.d/rime/rime-data")
;;   (setq rime-posframe-properties
;;         (list :background-color "#333333"
;;               :foreground-color "#dcdccc"
;;               :font "华文楷体"
;;               :internal-border-width 10)))

;; (setq default-input-method "rime"
;;       rime-show-candidate 'posframe)



;; ;;;;; 配置五笔词库：这两个去掉，就可以实现完全使用用戶词库了，所以，去掉所有的繁体字
;; (require 'pyim-wbdict) ;; 那么，这个意思，就是，我不用装载的词典，全用个人用戶配置的两个词典，现是一个
;; (setq pyim-default-scheme 'wubi)
;; (pyim-wbdict-v86-enable) ;86版五笔用户使用这个命令
;; ;; (pyim-wbdict-v86-single-enable) ;86版五笔用户使用这个命令，该词库为 单字词库【不想用单字的】，以尽可能不重码减少选词需要为目的

;; (require 'pyim)
;; ;; (require 'posframe) ;; 使用 posframe 来绘制选词框，这里可以不要也能出来
;; ;; (require 'liberime) 

;; (setq default-input-method "pyim") ;; 设置为缺省输入法 
;; ;; (global-set-key (kbd "C-m") 'toggle-input-method) ;; 需要十字不动可以觙的好用的鍵组合:可是这仍然不起作用

;; ;; 如果使用 popup page tooltip, 就需要加载 popup 包。
;; ;; (require 'popup nil t)
;; ;; (setq pyim-page-tooltip 'popup) ;; 使用 popup 包来绘制选词框 （emacs overlay 机制）: 这个不知道是什么原理，配制不出来
;; (setq pyim-page-tooltip 'posframe);; 另一种运行不通，据说延迟严重，就用这个了，字号调大一点儿
;; (setq pyim-page-style 'one-line) ;; 默认是双行显示

;; ;; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
;; (require 'pyim-dregcache)
;; (setq pyim-dcache-backend 'pyim-dregcache)

;; ;; 根据环境自动切换到半角标点输入模式: 使用半角标点。比较多，所以尽可能多地使用半角
;; (setq-default pyim-punctuation-half-width-functions
;;               '(probe-function4 probe-function5 probe-function6))
;; ;;; 根据环境自动切换到英文输入模式: https://tumashu.github.io/pyim/
;; (setq-default pyim-english-input-switch-functions
;;               '(probe-function1 probe-function2 probe-function3))


;; ;; 显示 5 个候选词: 太多引起的问题就是，得选半天
;; (setq pyim-page-length 5)

;; (require 'pyim-cregexp-utils)

;; ;; ;; 我觉得liberime 这个模块，我还没有配置好，我现配置的提供的路径下可能都还没有
;; ;; (liberime-start "/usr/share/rime-data" "~/Library/Rime/") ;;; 这里公共的库里，我好像并没有任保的可用的数据

;; ;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
;; (global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
;; ;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
;; (define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)

;; ;; (liberime-select-schema "wubi86_jidian")
;; ;; 设置 pyim 默认使用的输入法策略，我使用全拼。
;; (setq pyim-default-scheme 'wubi)


;; ;; ;;; 个人词库：可以有两个词库文件: 先测试用个人字典，没问题；现在就是怎么移除安装的带繁体的，只用简体詞库
;; ;; (setq pyim-dicts '(
;; ;;                    ;; (:name "dict1" :file "/Users/hhj/.emacs.d/pyim/wubi86_jidian_selfbrew.pyim") ;; 路径为绝对路径【常用固定不变的词库： wubi86_jidian, 自己转换得来的，大约9 万词库量】 
;; ;;                    (:name "dict1" :file "/Users/hhj/.emacs.d/elpa/user_dict.pyim")));; 这是活宝妹，亲爱的表哥，个人用戶词库，可以魔改的
;; ;; ;; 让 Emacs 启动时自动加载 pyim 词库：得制造一个这样的词库文件 
;; ;; (add-hook 'emacs-startup-hook
;; ;;           #'(lambda () (pyim-restart-1 t)))


;; ;; TODO: 注意到，同样有候选唯一，但是不上屏的情况，如“杻”，想要设置型码候选唯一自动上屏，源码里有，pyim-autoselector.el 但是不知道它全自动设置了没有？


;; ;; 过灵：因为我使用半角标点,它就全把它转换成英语了,但凡有半角标点。不使用半角标点了，仍在某引起情况下会过灵，被廹使用英文，不得转换，所以得少用几个探针
;; ;; ;; 设置 pyim 探针： 我感觉他的这些探针更多的是对拼音畭法有效，想要更好的对五笔输入法的支持
;; ;; ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; ;; ;; 我自己使用的中英文动态切换规则是：
;; ;; ;; 1. 光标只有在注释里面时，才可以输入中文。
;; ;; ;; 2. 光标前是汉字字符时，才能输入中文。
;; ;; ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;; ;; (setq-default pyim-english-input-switch-functions;; 这几个可能是太灵了，以致于我无法输入中文，所以去掉，只用一个
;; ;;               '(pyim-probe-dynamic-english ;; 这个函数的标注見下面的说明 : 
;; ;;                         ;; "激活这个 pyim 探针函数后，使用下面的规则动态切换中英文输入：
;; ;;                         ;; 1. 从光标往前找第一个非数字的字符，为中文字符时，输入下一个字符时默认开启中文输入
;; ;;                         ;; 2. 从光标往前找第一个非数字的字符，为其他字符时，输入下一个字符时默认开启英文输入
;; ;;                         ;; 3. 使用 `pyim-convert-string-at-point' 可以将光标前的字符串转换为中文，
;; ;;                         ;;    所以用户需要给 `pyim-convert-string-at-point' 绑定一个快捷键，比如：
;; ;;                         ;;    (global-set-key (kbd \"M-i\") #\\='pyim-convert-string-at-point)
;; ;;                         ;; 这个函数用于：`pyim-english-input-switch-functions' 。"
;; ;;                 pyim-probe-isearch-mode ;; 激活这个 pyim 探针函数后，使用 isearch 搜索时，禁用中文输入，强制英文输入
;; ;;                 pyim-probe-program-mode
;; ;;                 pyim-probe-org-structure-template)) ;; 
;; ;; 上面太灵了，无法再输入中文了。我试别的: 它说这里也是自动中英文切换的
;; ;; (defun pyim-probe-auto-english ()
;; ;;   "激活这个 pyim 探针函数后，使用下面的规则自动切换中英文输入：
;; ;; 1. 当前字符为英文字符（不包括空格）时，输入下一个字符为英文字符
;; ;; 2. 当前字符为中文字符或输入字符为行首字符时，输入的字符为中文字符
;; ;; 3. 以单个空格为界，自动切换中文和英文字符
;; ;;    即，形如 `我使用 emacs 编辑此函数' 的句子全程自动切换中英输入法
;; (setq-default pyim-english-input-switch-functions ;; 止前仍然只使用一个，等适应了会用了，找到更好的使用方法，再用其它的。现在这个简单好用
;;               '(pyim-probe-auto-english)) ;;; 设置有用: 但前提是我不可以使用英语半角符号,但是我需要/*-.是半角。把下在的探针开启就基本满足 org-mode 下的使用需要，可以不用半角了
;; (setq-default pyim-punctuation-half-width-functions;; 用这个来试半角 org-mode 下是没有总是的，因为都在头，它已经帮自动检测配置到位了
;;               '(pyim-probe-punctuation-line-beginning
;;                 pyim-probe-punctuation-after-punctuation))
;; ;; 开启代码搜索中文功能（比如拼音，五笔码等）
;; (pyim-isearch-mode 1) 

;; ;; 用分号做次选按键；用 ' 用第三选择, 第四第五就倒着遍历就可以了
;; (defun pyim-select-second-word ()
;;   (interactive)
;;   (pyim-select-word-by-number 2))
;; (defun pyim-select-third-word ()
;;   (interactive)
;;   (pyim-select-word-by-number 3))
;; (define-key pyim-mode-map ";" 'pyim-select-second-word)
;; (define-key pyim-mode-map "'" 'pyim-select-third-word)

;; ;; 魔术转换盒: 真能魔术，就将活宝妹嫁给亲爱的“亲爱的表哥，活宝妹一定要嫁的亲爱的表哥！！！”吧
;; (defun my-converter (string)
;;   (if (equal string "表哥") "亲爱的表哥，活宝妹一定要嫁的亲爱的表哥！！！" string))
;; (setq pyim-magic-converter #'my-converter)

;; ;;; 向前向后移动一个词，设置为这个模式下使用的： 不想设置为全局，当前的 prev-next 前后一頁都可以自然工作，不设置
;; ;; (global-set-key (kbd "M-f") 'pyim-forward-word)
;; ;; (global-set-key (kbd "M-b") 'pyim-backward-word)


(provide 'init-pyim)