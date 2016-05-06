;; check if vedet-version is correct
(when (or (not (boundp 'cedet-version))
	  (ecb-package-version-list<
	   (ecb-package-version-str2list cedet-version)
	   ecb-required-cedet-version-min)
	  (ecb-package-version-list<
	   ecb-required-cedet-version-max
	   (ecb-package-version-str2list cedet-version))) (setq version-error (concat "cedet ["  cedet-required-version-str-min
										      ", "  cedet-required-version-str-max "]")))
