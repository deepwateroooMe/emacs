;;;;; for sys initializatiokon

;; (use-package sis
  ;; :hook
  ;; enable the /context/ and /inline region/ mode for specific buffers
  ;; (((text-mode prog-mode) . sis-context-mode)
  ;;  ((text-mode prog-mode) . sis-inline-mode))

;; (sis-ism-lazyman-config nil "rime" 'native)
;; (require 'sis)

;; :config
;; For MacOS
(sis-ism-lazyman-config
 ;; English input source may be: "ABC", "US" or another one.
 ;; "com.apple.keylayout.ABC"
 "com.apple.keylayout.US"
 ;; Other language input source: "rime", "sogou" or another one.
 ;; "im.rime.inputmethod.Squirrel.Rime") ;;;;; 这个与自己安装的好像还有点儿不一样
"im.rime.inputmethod.Squirrel.Hans")

;; ;; enable the /cursor color/ mode
;; (sis-global-cursor-color-mode t) ;; 我不想要这个，因为它所它变得在我的系统配色下变得狠难看
;; enable the /respect/ mode
(sis-global-respect-mode t)
;; enable the /context/ mode for all buffers
(sis-global-context-mode t)
;; enable the /inline english/ mode for all buffers
(sis-global-inline-mode t)


;;;;; TODO: 这里有很多需要做的地方


(provide 'init-sis)
