;;; init-vcs.el --- vcs settings
;;; Commentary:
;;; Code:


(use-package git-timemachine)

;; https://github.com/syohex/emacs-git-gutter
(use-package git-gutter
  :demand
  :config
  ;; (global-git-gutter-mode t)

  (custom-set-variables
   '(git-gutter:hide-gutter t))

  ;; If you would like to use git-gutter.el and linum-mode
  ;; (git-gutter:linum-setup)
  )

;; If you enable global minor mode
(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read))


;; Hydras
(defhydra hydra-git-toggle (:color pink)
  "
    _g_ git-gutter:       %`git-gutter-mode
    _t_ time-machine
    "
  ("g" git-gutter-mode nil)
  ("r" git-gutter:revert-hunk "revert hunk")
  ("p" git-gutter:popup-hunk "popup hunk")
  ("N" git-gutter:next-hunk "next hunk")
  ("P" git-gutter:previous-hunk "prev hunk")
  ("t" hydra-git-timemachine/body :exit t)
  ("q" nil "quit"))

(defhydra hydra-git-timemachine (:color pink
                                        :body-pre (git-timemachine)
                                        :before-exit (git-timemachine-quit))
  "Time machine"
  ("P" git-timemachine-show-previous-revision "prev")
  ("N" git-timemachine-show-next-revision "next")
  ("q" nil "quit"))


;; Keybindings
(my-space-leader
 "m" 'magit-status
 "g" 'hydra-git-toggle/body)


(provide 'init-vcs)
;;; init-vcs.el ends here
