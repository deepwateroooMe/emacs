;;;;;;; init-autopair.el

(require 'autopair)
(defun turn-on-autopair-mode () (autopair-mode 1))
(setq autopair-global-modes
      '(not
        swift-mode))

;; ;; 下面这行，可以帮助 org-mode 下匹配 ()[]{} 这三个，但是它狠鬼怪地让 csharp-mode 下C-c f 不能运行了！！！只能先把它去掉了
;; (autopair-global-mode) ;; don't know why org-mode is not working

;; change package from autopair to elec-pair.el for Chinese pair marks including （）【】《》 etc
;; (require 'elec-pair)
;; ;; make electric-pair-mode work on more brackets
;; (setq electric-pair-pairs
;;       '((?\' . ?\')
;;         (?\" . ?\")
;;         (?\( . ?\))
;;         (?\[ . ?\])
;;         (?\{ . ?\})))
;; ;;; Chinese matching characters 【爱表哥，爱生活！！！活宝妹就是一定要嫁给亲爱的表哥！！！】
;;         (?\（ . ?\）);; 从这行开始会报错，不能用 unicode ，所以只能想 snippets 的办法了
;;         (?\【 . ?\】)
;;         (?\《 . ?\》)
;;         (?\『 . ?\』)
(provide 'init-autopair)
