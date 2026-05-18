(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu")
			 ("org" . "https://orgmode.org/elpa")
			 ))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;(setq create-lockfiles nil)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'buffer-to-pdf)
(setq buffer-to-pdf-directory (expand-file-name "~/Pictures/Emacs_buffer-to-pdf/"))

(tab-bar-mode 1)
(tab-bar-history-mode 1)
(setq desktop-restore-frames t)
(setq desktop-restore-forces-onscreen nil)
(require 'savehist)
(savehist-mode 1)
(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)
(setq desktop-path '("~/.emacs.d/"))
(save-place-mode 1)

(add-to-list 'desktop-locals-to-save 'evil-markers-alist)

(require 'compat)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; === ISEARCH custom behaviors START
(setq isearch-allow-scroll t
      isearch-lazy-count t)
(defun c-isearch-with-region ()                         ;; === INSTANT mark-all all after isearch
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))
(add-hook 'isearch-mode-hook #'c-isearch-with-region)

(defun sexp-about-to-isearch ()                         ;; === +/ mark-sexp at cursor about to isearch
   ;; === REFER TO <C-M-SPC then M-B> then <C-M-u>
      (progn (mark-sexp))))                             ;; === I NEED <C-s quick-search in --normal mode
(add-hook 'isearch-mode-hook #'sexp-about-to-isearch)   ;; === potential to be disabled if 1st mark-sexp isn't holistic across file-types
  "Use region as the isearch text."
  (if isearch-success
      (progn (mark-sexp))))
(add-hook 'isearch-mode-hook #'sexp-about-to-isearch)

(defun yankword-after-isearch ()                       ;; === ++/ just yank word, not from where isearch started
  "Copy the current isearch match to the kill ring."
  (interactive)
  (kill-ring-save isearch-other-end (point)))
  ;;(isearch-exit))                                      ;; == ++// if we rather stay in isearch after yank word
(define-key isearch-mode-map (kbd "M-w") #'yankword-after-isearch)

(defun my/isearch-extend-right ()
  "Extend isearch match one char to the right."
  (interactive)
  (isearch-yank-char 1))
(defun my/isearch-shrink-left ()
  "Shrink isearch match one char from the right."
  (interactive)
  (isearch-del-char 1))
(define-key isearch-mode-map (kbd "<left>")  #'my/isearch-shrink-left)
(define-key isearch-mode-map (kbd "<right>") #'my/isearch-extend-right)
;; === ISEACH custom behaviors DONE

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq dumb-jump-force-searcher 'rg)                   ;; == LATEST config for dumb-jump_issue, slowness, FIX-restart_emacs

(setq xref-show-definitions-function #'xref-show-definitions-completing-read)      ;; === NOT SURE YET WHICH TO HOLD ON TO
(add-to-list 'xref-backend-functions 'dumb-jump-xref-activate t)
(beacon-mode 1)
(counsel-mode 1)
(add-to-list 'load-path "/home/bryllepadilla/emacs-libvterm")
(require 'vterm)

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(with-eval-after-load 'rg
  (dolist (key '("C-o"))          ;; describe-function | rg-mode | <M-RET >> compilation-display-error
    (define-key rg-mode-map (kbd key) nil))
  )

(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "C-c h") 'windmove-swap-states-left)
(global-set-key (kbd "C-c j") 'windmove-swap-states-down)
(global-set-key (kbd "C-c k") 'windmove-swap-states-up)
(global-set-key (kbd "C-c l") 'windmove-swap-states-right)

(defun copy-rectangle-to-system-clipboard (start end)
  "Like `copy-rectangle-as-kill', but also copy to system clipboard."
  (interactive "r")
  (call-interactively #'copy-rectangle-as-kill)
  (with-temp-buffer
    (yank-rectangle)
    (delete-trailing-whitespace)
    (kill-new (buffer-string)))
  )

(tool-bar-mode -1)
(setq next-line-add-newlines t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(hl-line-mode 1)
(global-superword-mode t)
(global-display-line-numbers-mode t)
;;(global-hi-lock-mode 1)               ;;(add-hook 'org-mode-hook 'hi-lock-mode)

(load-theme 'base16-black-metal-immortal t)
(set-frame-font "Iosevka Nerd Font 12" nil t)
;;(set-face-attribute 'line-number nil :background "black")  ;;for emacsclient issues
(setq ring-bell-function 'ignore)

(global-set-key (kbd "C-x C-b") #'ibuffer-list-buffers)
(global-set-key (kbd "C-x C-d") #'dired-other-window)

(setq display-buffer-alist nil)
(add-to-list 'display-buffer-alist
	     '("\\(info\\|Help\\|TUTORIAL\\|Org Agenda\\|Agenda Commands\\|Occur\\)"
	       (display-buffer-in-side-window)
	       (side . left)
	       (window-width . 0.35))
	     )
(add-to-list 'display-buffer-alist
	     '((major-mode . dired-mode)
	       (display-buffer-same-window))
	     )
(add-to-list 'display-buffer-alist
	     '("\\rg*"
	       (display-buffer-same-window))
	     )
(add-to-list 'display-buffer-alist
	     '("\\Ibuffer*"
	       (display-buffer-below-selected))
	     )
(add-to-list 'display-buffer-alist
	     '((major-mode . evil-list-view-mode)
	       (display-buffer-in-side-window)
	       (side . bottom)
	       (window-height . 0.3))
	     )
(setq vterm-toggle-fullscreen-p nil)
(add-to-list 'display-buffer-alist
             '((lambda (buffer-or-name *vterm*)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
               (display-buffer-reuse-window display-buffer-in-side-window)
               (side . left)
               (reusable-frames . visible)
               (window-width . 0.35)))

(setq evil-want-keybinding nil)
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(evil-mode t)
(require 'evil-collection)
(evil-collection-init)

(evil-global-set-key 'normal (kbd "C-'") 'evil-show-marks)

(defun dg-mark-paragraph ()
  (interactive)
  (mark-paragraph)
  (goto-char (region-beginning))
  (when (= (string-match paragraph-separate (thing-at-point 'line)) 0)
    (forward-line)))
(evil-define-key 'normal 'global (kbd "Y") #'dg-mark-paragraph)

(evil-set-initial-state 'org-mode 'insert)
(with-eval-after-load 'evil
  (evil-set-initial-state 'Info-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'Custom-mode 'emacs)
  (evil-set-initial-state 'rg-mode 'normal)
  )
(define-key evil-normal-state-map (kbd "`") #'window-toggle-side-windows)
(define-key evil-normal-state-map (kbd "!") #'vterm-toggle-cd)
(evil-global-set-key 'normal (kbd "C-t") #'tab-new)

(global-set-key (kbd "C-S-t") #'make-frame)
(global-set-key (kbd "M-1") #'tab-previous)
(global-set-key (kbd "M-2") #'tab-next)
(global-set-key (kbd "M-3")
		(lambda () (interactive) (tab-move -1)))
(global-set-key (kbd "M-4") 'tab-move)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "C-M-c") 'evil-scroll-up)

(with-eval-after-load 'evil
  (dolist (key '("M-." "M-?" "C-f" "C-b" "C-r" "C-p" "C-n"))
    (define-key evil-normal-state-map (kbd key) nil))
  (dolist (key '("C-f" "C-b" "C-M-d"))
    (define-key evil-motion-state-map (kbd key) nil))
  )

(setq skippable-buffers '("*Messages*" "*scratch*" "*Help*"))
(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (or (member (buffer-name) skippable-buffers)
	     (eq major-mode 'dired-mode))
    (next-buffer)))
(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (or (member (buffer-name) skippable-buffers)
	     (eq major-mode 'dired-mode))
    (previous-buffer)))
(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

(with-eval-after-load 'dired
  (evil-set-initial-state 'dired-mode 'normal)
  (evil-define-key 'normal dired-mode-map
    "w" (lambda () (interactive) (dired-copy-filename-as-kill 0)))
  (evil-define-key 'normal dired-mode-map
    "y" (lambda () (interactive) (dired-copy-filename-as-kill)))
  (evil-define-key 'normal dired-mode-map
    "h" (lambda () (interactive) (dired-up-directory)))
  (evil-define-key 'normal dired-mode-map
    "l" (lambda () (interactive) (dired-find-file)))
  )

(setq org-hide-emphasis-markers t)
(require 'org-ac)
(add-hook 'org-mode-hook #'org-ac/setup-current-buffer)
(require 'org-tempo)
(add-to-list 'org-modules 'org-tempo)

(with-eval-after-load 'org
  (dolist (key '("M-h" "M-j" "M-k" "M-l"))
    (define-key org-mode-map (kbd key) nil))
  )
(with-eval-after-load 'vterm
  (dolist (key '("M-h" "M-j" "M-k" "M-l"))
    (define-key vterm-mode-map (kbd key) nil))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("94ac10e5261b9a32c9f1a7ef88f3fb89bfcbad843436aaaedc97c7975d8e6ab2" default))
 '(package-selected-packages
   '(rg lua-mode counsel org-ac beacon compat multiple-cursors base16-theme use-package evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-current-match ((t (:extend t :background "gray18" :foreground "#aaaaaa"))))
 '(tab-bar-tab-inactive ((t (:background "gray16" :foreground "#999999")))))



