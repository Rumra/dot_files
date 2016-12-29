;;; init-flyspell.el --- Flyspell settings
;;; Commentary:
;;
;; Required system package:
;; * aspell, aspell-en
;;
;; TODO:
;; * Setup auto enabling flyspell-mode
;;
;;; Code:

(use-package flyspell
  ;; Can't enable flyspell mode where it is needed
  ;; :init
  ;; (progn
    ;; (add-hook 'evil-mode-hook 'flyspell-mode)
    ;; (add-hook 'text-mode-hook 'flyspell-mode)
    ;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    ;; )
  :config
  (progn
    (setq ispell-program-name "aspell")
    (add-to-list 'ispell-extra-args "--sug-mode=ultra")
    (add-to-list 'ispell-extra-args "--run-together")
    (add-to-list 'ispell-extra-args "--run-together-limit=5")
    ;; Disable cause: detect "Varible" as correct. (with --run-together-min option)
    ;; (add-to-list 'ispell-extra-args "--run-together-min=2")

    (setq ispell-local-dictionary "en_US")

    (use-package flyspell-correct-helm)
    (use-package flyspell-correct
      :config
      (progn
        (setq flyspell-correct-interface 'flyspell-correct-helm)
        )
      )

    ))

;;
;; Copied from http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;;

;; if (aspell installed) { use aspell}
;; else if (hunspell installed) { use hunspell }
;; whatever spell checker I use, I always use English dictionary
;; I prefer use aspell because:
;; 1. aspell is older
;; 2. looks Kevin Atkinson still get some road map for aspell:
;; @see http://lists.gnu.org/archive/html/aspell-announce/2011-09/msg00000.html
;; (defun flyspell-detect-ispell-args (&optional run-together)
;;   "if RUN-TOGETHER is true, spell check the CamelCase words."
;;   (let (args)
;;     (cond
;;      ((string-match  "aspell$" ispell-program-name)
;;       ;; Force the English dictionary for aspell
;;       ;; Support Camel Case spelling check (tested with aspell 0.6)
;;       (setq args (list "--sug-mode=ultra" "--lang=en_US"))
;;       (if run-together
;;           (setq args (append args '("--run-together" "--run-together-limit=5" "--run-together-min=2")))))
;;      ((string-match "hunspell$" ispell-program-name)
;;       ;; Force the English dictionary for hunspell
;;       (setq args "-d en_US")))
;;     args))

;; (cond
;;  ((executable-find "aspell")
;;   ;; you may also need `ispell-extra-args'
;;   (setq ispell-program-name "aspell"))
;;  ((executable-find "hunspell")
;;   (setq ispell-program-name "hunspell")

;;   ;; Please note that `ispell-local-dictionary` itself will be passed to hunspell cli with "-d"
;;   ;; it's also used as the key to lookup ispell-local-dictionary-alist
;;   ;; if we use different dictionary
;;   (setq ispell-local-dictionary "en_US")
;;   (setq ispell-local-dictionary-alist
;;         '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))
;;  (t (setq ispell-program-name nil)))

;; ;; ispell-cmd-args is useless, it's the list of *extra* arguments we will append to the ispell process when "ispell-word" is called.
;; ;; ispell-extra-args is the command arguments which will *always* be used when start ispell process
;; ;; Please note when you use hunspell, ispell-extra-args will NOT be used.
;; ;; Hack ispell-local-dictionary-alist instead.
;; (setq-default ispell-extra-args (flyspell-detect-ispell-args t))
;; ;; (setq ispell-cmd-args (flyspell-detect-ispell-args))
;; (defadvice ispell-word (around my-ispell-word activate)
;;   (let ((old-ispell-extra-args ispell-extra-args))
;;     (ispell-kill-ispell t)
;;     (setq ispell-extra-args (flyspell-detect-ispell-args))
;;     ad-do-it
;;     (setq ispell-extra-args old-ispell-extra-args)
;;     (ispell-kill-ispell t)
;;     ))

;; (defadvice flyspell-auto-correct-word (around my-flyspell-auto-correct-word activate)
;;   (let ((old-ispell-extra-args ispell-extra-args))
;;     (ispell-kill-ispell t)
;;     ;; use emacs original arguments
;;     (setq ispell-extra-args (flyspell-detect-ispell-args))
;;     ad-do-it
;;     ;; restore our own ispell arguments
;;     (setq ispell-extra-args old-ispell-extra-args)
;;     (ispell-kill-ispell t)
;;     ))

;; (defun text-mode-hook-setup ()
;;   ;; Turn off RUN-TOGETHER option when spell check text-mode
;;   (setq-local ispell-extra-args (flyspell-detect-ispell-args)))
;; (add-hook 'text-mode-hook 'text-mode-hook-setup)

(provide 'init-flyspell)
;;; init-flyspell.el ends here