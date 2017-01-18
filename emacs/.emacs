; list the packages you want
(setq package-list '(evil
                     evil-magit
                     projectile
                     helm-projectile
                     magit
                     suscolors-theme
                     git-gutter
                     evil-mc
                     ggtags
                     company
                     go-mode
                     all-the-icons
                     neotree
                     smart-mode-line-powerline-theme
                     nyan-mode
                     ))

; list the repositories containing them
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; HOOK MODE ;;
;; git gutter
(add-hook 'ruby-mode-hook 'git-gutter-mode)
;;(add-hook 'after-init-hook 'global-company-mode)

;; CONFIG ;;
;; encryption
(require 'epa-file)
;(epa-file-enable)
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption
(setq org-crypt-key nil)

;; smart mode line
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'powerline)
(sml/setup)
(nyan-mode 1)
;(setq mode-line-format
;      (list
;       '(:eval (list (nyan-create)))
;       ))
;; evil 
(evil-mode t)
(require 'evil-magit)
(global-evil-mc-mode  1)
;; show line numbers
(global-linum-mode t)
(projectile-global-mode)
(helm-projectile-on)
;; load custom theme
(load-theme 'suscolors t)
;; git gutter
(global-git-gutter-mode +1)
;; org 
(require 'org-agenda)
(setq org-startup-indented t)
(setq org-columns t)
(setq org-columns-default-format "%25ITEM %SCHEDULED %DEADLINE %TODO %3PRIORITY %TAGS")
;; turn off welcome screen
(setq inhibit-startup-message t)
;; company
(global-company-mode)
(setq company-idle-delay 0.2)
(setq company-selection-wrap-around t)
;; wrap line
(global-visual-line-mode t)
;; keep file to stay sync
(global-auto-revert-mode t)
;; set path to ledger
(if (eq system-type 'darwin) ;; check for mac os
    (setq ledger-binary-path "/usr/local/bin/ledger")
)

(setq projectile-tags-command "ctags -Re %s %s .")
(setq-default indent-tabs-mode nil)
(setq standard-indent 4)
(add-to-list 'load-path "~/.emacs.d/includes/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\.\\.php\\'" . web-mode))

;; CUSTOM FUNC ;;
;; func: put file name to clipboard
(defun nikk-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(org-agenda-files
   (quote
    ("~/Dropbox/Org/Meetings.org" "~/Dropbox/Org/Tasks.org")))
 '(package-selected-packages
   (quote
    (neotree suscolors-theme ledger-mode helm-projectile go-mode git-gutter ggtags evil-mc evil-magit emmet-mode company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; func: switch to previous buffer
(defun switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))
;; func: complete or indent
(defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))

;; KEY ;;
;; emacs
(global-set-key (kbd "<C-tab>") 'switch-to-previous-buffer)
;; helm
(global-set-key (kbd "<S-iso-lefttab>") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x <C-tab>") 'helm-etags-select)
;; agenda
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c a") 'org-agenda)
(define-key org-agenda-mode-map "j" 'evil-next-line)
(define-key org-agenda-mode-map "k" 'evil-previous-line)
;; git gutter
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
(global-set-key (kbd "C-x v SPC") 'git-gutter:mark-hunk)
;; magit
(global-set-key (kbd "C-x g") 'magit-status)
;; neotree
(global-set-key [f8] 'neotree-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
;; company
(with-eval-after-load 'company
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous))
(define-key evil-insert-state-map (kbd "C-c C-c") 'company-complete)
(put 'dired-find-alternate-file 'disabled nil)
