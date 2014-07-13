; evil keymap
(define-key evil-motion-state-map (kbd ";") #'evil-ex)
(define-key evil-normal-state-map (kbd "C-a") #'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "SPC SPC") 'eval-buffer)
(define-key evil-normal-state-map (kbd "SPC u") 'helm-M-x)

(provide 'keymap)
