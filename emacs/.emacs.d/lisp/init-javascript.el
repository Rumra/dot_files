;; init-javascript -----------------------------------------------------------------

(use-package tern
  :diminish tern-mode
  :mode ("\\.js\\'" . js-mode)
  :interpreter ("javascript" . js-mode))

(use-package company-tern
  :ensure tern
  :mode ("\\.js\\'" . js-mode)
  :interpreter ("javascript" . js-mode)
  :config
  ;; Add this to your .emacs to initialize tern and tern-auto-complete
  (add-hook 'js-mode-hook (lambda () (tern-mode t))))


(use-package js2-mode
  :diminish js2-minor-mode)

(add-hook 'js-mode-hook 'js2-minor-mode)

(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2)
  (setq tab-width 2)
  )

(require 'jquery-doc)
(add-hook 'js2-mode-hook 'jquery-doc-setup)

(add-hook 'js-mode-hook 'js-custom)

(setq js2-highlight-level 3)

;; jshint does not warn about this now for some reason
;; (setq-default js2-strict-trailing-comma-warning nil)
;; '(js2-strict-trailing-comma-warning nil)
(setq js2-strict-trailing-comma-warning nil)

(provide 'init-javascript)
