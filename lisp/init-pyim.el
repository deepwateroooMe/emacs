;;;;; 配置pyim emacs-rime 在emacs 中的前端

;; (require 'pyim)
;; (require 'posframe)
;; (require 'liberime) ;;; ?

;; ;; (require 'pyim-basedict)
;; ;; (pyim-basedict-enable)

;; (setq default-input-method "pyim")

;; ;; 如果使用 popup page tooltip, 就需要加载 popup 包。
;; ;; (require 'popup nil t)
;; ;; (setq pyim-page-tooltip 'popup)
;; (setq pyim-page-tooltip 'popup)

;; (setq pyim-page-length 7)

;; (require 'pyim-cregexp-utils)

;; ;; (setq pyim-default-scheme 'microsoft-shuangpin)
;; (pyim-default-scheme 'wubi)

;; ;; (setq rime-librime-root (expand-file-name "~/.emacs.d/librime/dist" user-emacs-directory))
;; ;; ;; (liberime-start (expand-file-name "~/Library/Rime") ;;;;; 这个目录不对，不存在
;; ;; ;;                 (expand-file-name "~/.emacs.d/pyim/rime/")) ;;;;; 这个也不对
;; ;; ;; (liberime-select-schema "terra_double_pinyin_mspy")
;; ;; (liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~/.emacs.d/librime/"))
;; ;; ;; (liberime-select-schema "luna_pinyin_simp")
;; ;; ;; (setq pyim-default-scheme 'rime-quanpin)
;; ;; (setq pyim-default-scheme 'rime)


(require 'pyim)

;; (require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
;; 加载 basedict 拼音词库。
;; (pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置

;; 将 Emacs 默认输入法设置为 pyim.
(setq default-input-method "pyim")
(require 'pyim-cregexp-utils)
;; 如果使用 popup page tooltip, 就需要加载 popup 包。
(require 'popup nil t)
(setq pyim-page-tooltip 'popup)

;; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
;; (require 'pyim-dregcache)
;; (setq pyim-dcache-backend 'pyim-dregcache)

;; 显示 5 个候选词。
(setq pyim-page-length 7)
;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)
;; 设置 pyim 默认使用的输入法策略，我使用全拼。
;; (pyim-default-scheme 'quanpin)
(pyim-default-scheme 'wubi)
;; (pyim-default-scheme 'cangjie)

;; 设置 pyim 是否使用云拼音
;; (setq pyim-cloudim 'baidu)

;; 设置 pyim 探针
;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; 我自己使用的中英文动态切换规则是：
;; 1. 光标只有在注释里面时，才可以输入中文。
;; 2. 光标前是汉字字符时，才能输入中文。
;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))
(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))

;; 开启代码搜索中文功能（比如拼音，五笔码等）
(pyim-isearch-mode 1)
;; 配置到上面，仍然是半点儿作用也不起


;;;; 下面这个最简的不work 
;; (use-package rime
;;   :custom
;;   (default-input-method "rime"))


;; (use-package pyim
;;   :demand t
;;   :diminish pyim-isearch-mode
;;   :init
;;   (setq default-input-method "pyim"
;;         pyim-title "ㄓ"
;;         pyim-default-scheme 'rime
;;         pyim-page-length 7
;;         pyim-page-tooltip 'proframe)
;;   :config
;;   (setq-default pyim-english-input-switch-functions
;;                 '(pyim-probe-dynamic-english
;;                   pyim-probe-evil-normal-mode
;;                   pyim-probe-program-mode
;;                   pyim-probe-org-structure-template))
;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))
;;   (pyim-isearch-mode t)
;;   :bind ("M-j" . pyim-convert-string-at-point))
;; (use-package liberime
;;   :load-path (lambda () (expand-file-name "rime" user-emacs-directory)) ;;;;; 这个可能自己没有加 elpa里面
;;   :custom
;;   (rime_share_data_dir "/Library/Input Methods/Squirrel.app/Contents/SharedSupport/") ;;; 检查一下
;;   (rime_user_data_dir (expand-file-name "rime" user-emacs-directory))
;;   :init
;;   (module-load (expand-file-name "liberime.so" user-emacs-directory)) ;;;;; 移进来
;;   :config
;;   ;; 配置同步文件夹
;;   (liberime-start rime_share_data_dir rime_user_data_dir) ;;;;; ？不知道说的是不是同一个 rime 呢？
;;   (liberime-select-schema "wubi86"))
;; (use-package posframe)


;; (provide 'modules-pyim)
(provide 'init-pyim)
