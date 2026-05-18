(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu")
                         ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(tab-bar-mode 1)
(tab-bar-history-mode 1)
(setq desktop-restore-frames t)          ; Explicitly restore frames
(setq desktop-restore-forces-onscreen nil) ; Helpful on some setups
(require 'savehist)
(savehist-mode 1)
(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)
(setq desktop-path '("~/.emacs.d/"))
(save-place-mode 1)

(add-to-list 'savehist-additional-variables 'reader2itemtable)

(require 'burly)
(add-to-list 'desktop-locals-to-save 'evil-markers-alist)

(counsel-mode 1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(hl-line-mode 1)

(global-superword-mode t)
;;(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-x C-b") #'ibuffer-list-buffers)
(global-set-key (kbd "C-x C-d") #'dired-other-window)      ; default is list-directory

(setq ring-bell-function 'ignore)

(load-theme 'base16-black-metal-immortal t)
(set-frame-font "Iosevka Nerd Font 12" nil t)
(set-face-attribute 'line-number nil :background "black")

(setq skippable-buffers '("*Messages*" "*scratch*" "*Help*")) ;;"\\*Dired\\*" ==WRONG== refer to major-mode
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

;; === DISPLAY BUFFER ALIST ===
(setq display-buffer-alist nil)
(add-to-list 'display-buffer-alist
	     '("\\(info\\|Help\\|TUTORIAL\\|Org Agenda\\|Agenda Commands\\)"
	       (display-buffer-in-side-window)
	       (side . left)
	       (window-width . 0.3))
	     )
(add-to-list 'display-buffer-alist
             '((major-mode . dired-mode)                    ;;"\\*dired\\*"
	       (display-buffer-same-window)
	     ))
(add-to-list 'display-buffer-alist
	     '("\\rg*"
	       (display-buffer-same-window)
               ))
(add-to-list 'display-buffer-alist
	     '("\\Ibuffer*"
	       (display-buffer-below-selected)       ;;display-buffer-full-frame   <-- GOOD FOR testing if regex IS WORKING
               ))


;; === DO NOT PUT ANY evil-bindings ABOVE THIS LINE !! ===

(setq evil-want-keybinding nil)
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(evil-mode t)
(require 'evil-collection)
(evil-collection-init)

(evil-set-initial-state 'org-mode 'insert)
(with-eval-after-load 'evil
  (evil-set-initial-state 'Info-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'Custom-mode 'emacs)
  )
(define-key evil-normal-state-map (kbd "`") #'window-toggle-side-windows)   ;;kill-buffer-and-window          ;;delete-window;; to avoid clashing  ;;samsung-tablet #'kill-buffer-and-window
(define-key evil-normal-state-map (kbd "C-h <left>") #'kill-buffer-and-window)
(global-set-key (kbd "C-v") nil)
(global-set-key (kbd "C-S-v") nil)
(evil-global-set-key 'normal (kbd "C-t") #'tab-new)
(evil-global-set-key 'normal (kbd "C-S-r") #'recentf-open-files)
(global-set-key (kbd "C-S-t") #'make-frame)
(global-set-key (kbd "M-1") #'tab-previous)  ;tab-previous, previous-buffer
(global-set-key (kbd "M-2") #'tab-next)      ;tab-nexT next-buffer


(defun dg-mark-paragraph ()
  (interactive)
  (mark-paragraph)
  (goto-char (region-beginning))
  (when (= (string-match paragraph-separate (thing-at-point 'line)) 0)
    (forward-line)))
(evil-define-key 'normal 'global (kbd "Y") #'dg-mark-paragraph) ;; M-# <- inspired from M-@, since not yet set

(global-set-key (kbd "M-<f1>") 
                (lambda () (interactive) (tab-move -1)))
(global-set-key (kbd "M-<f2>") 'tab-move)
(defun c-isearch-with-region ()                                    ;;searching-for-marked-selected-text-in-emacs, 
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))
(add-hook 'isearch-mode-hook #'c-isearch-with-region)



(evil-global-set-key 'normal (kbd "C-,")
		     (lambda () (interactive)
		       ;;(find-file "~/.emacs.d/init.el")))
		       (scratch-buffer)))
(evil-global-set-key 'normal (kbd "C-.")
		     (lambda () (interactive)
		       ;;(find-file "~/.emacs.d/init.el")))
		       (embark-act)))
(evil-global-set-key 'normal (kbd "C-'") 'evil-show-marks)
(setq default-directory "/home/brylle_padilla/")

(add-to-list 'display-buffer-alist
	     '((major-mode . evil-list-view-mode)
	       (display-buffer-below-selected)
	       (window-height . 0.3))
	     )

(setq org-hide-emphasis-markers t)
(require 'org-ac)
(add-hook 'org-mode-hook #'org-ac/setup-current-buffer)
(require 'org-tempo)
(add-to-list 'org-modules 'org-tempo)

    (setq org-cycle-include-plain-lists t)

    ;;(load-library "find-lisp")
;;(setq org-agenda-files
    ;;      (find-lisp-find-files "c:/Users/Brylle Padilla/Documents/emacs_windows/" "\.org$"))

    (org-babel-do-load-languages
    'org-babel-load-languages
	    '(
            (shell . t)
		(C . t)
	    (emacs-lisp . t)
            )
	)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(global-set-key [f9] 'visual-line-mode)

(beacon-mode 1)


(with-eval-after-load 'org
  (dolist (key '("M-h" "M-j" "M-k" "M-l"))
    (define-key org-mode-map (kbd key) nil))
  ;; Bold C-'
  (define-key org-mode-map (kbd "C-'") (lambda () (interactive) (org-emphasize ?*)))
  ;;;; Underline C-u
  ;;(define-key org-mode-map (kbd "C-u") (lambda () (interactive) (org-emphasize ?_)))
  ;;;; Strikethrough C-t
  ;;(define-key org-mode-map (kbd "C-t") (lambda () (interactive) (org-emphasize ?+)))
  ;; Highlight C-=
  (define-key org-mode-map (kbd "C-=") (lambda () (interactive) (org-emphasize ?=)))
  ;; Italics C-;
  (define-key org-mode-map (kbd "C-;") (lambda () (interactive) (org-emphasize ?/)))
  (evil-define-key 'normal org-mode-map (kbd "Y") #'dg-mark-paragraph)
  )

(defun copy-rectangle-to-system-clipboard (start end)
  "Like `copy-rectangle-as-kill', but also copy to system clipboard."
  (interactive "r")
  (call-interactively #'copy-rectangle-as-kill)
  (with-temp-buffer
    (yank-rectangle)
    (delete-trailing-whitespace)
    (kill-new (buffer-string)))
  )

;; === WINDMOVE BINDINGS ;; IN CONFLICT with org-tables move cell ===
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "C-c h") 'windmove-swap-states-left)
(global-set-key (kbd "C-c j") 'windmove-swap-states-down)
(global-set-key (kbd "C-c k") 'windmove-swap-states-up)
(global-set-key (kbd "C-c l") 'windmove-swap-states-right)

(global-set-key (kbd "C-c <left>") 'windmove-swap-states-left)
(global-set-key (kbd "C-c <down>") 'windmove-swap-states-down)
(global-set-key (kbd "C-c <up>") 'windmove-swap-states-up)
(global-set-key (kbd "C-c <right>") 'windmove-swap-states-right)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b2a3b2bbe9aea795fd23ecb46ba1fbd28988b7d528b6a1f6e7f8a1122a9025aa" "54c3b844fe0e3076c4a20cde82d9e4890efff9831c7e88cd55f89c2b565cf2e2" "1fc299974daa270e19d1b206ec40aab3a0ce35e7c6a7d389b156bcd411e41a3c" "5d67552ed2e841039034dc8245ee1746ab4f00614366ca7018386041f9b0a96f" "9a06ccf9adfe489bda1ba63c7e622c0f31e2b22f6b4a27118dcd4e8fbad6a282" "e57ad9eb8465dcb6b85eeb2f1be11a37aee7b1f24e5f99155b39ff0679e664d5" "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d" "19d62171e83f2d4d6f7c31fc0a6f437e8cec4543234f0548bad5d49be8e344cd" "e14289199861a5db890065fdc5f3d3c22c5bac607e0dbce7f35ce60e6b55fc52" "22a0d47fe2e6159e2f15449fcb90bbf2fe1940b185ff143995cc604ead1ea171" "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93" "fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a" "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425" "7771c8496c10162220af0ca7b7e61459cb42d18c35ce272a63461c0fc1336015" "4b88b7ca61eb48bb22e2a4b589be66ba31ba805860db9ed51b4c484f3ef612a7" "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9" "2f7fa7a92119d9ed63703d12723937e8ba87b6f3876c33d237619ccbd60c96b9" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0" "921f165deb8030167d44eaa82e85fcef0254b212439b550a9b6c924f281b5695" "d481904809c509641a1a1f1b1eb80b94c58c210145effc2631c1a7f2e4a2fdf4" default))
 '(global-auto-revert-mode nil)
 '(global-auto-revert-non-file-buffers nil)
 '(hi-lock-face-defaults
   '("hi-blue" "hi-pink" "hi-green" "hi-yellow" "hi-salmon" "hi-aquamarine" "hi-black-b" "hi-blue-b" "hi-red-b" "hi-green-b" "hi-black-hb"))
 '(package-selected-packages
   '(base16-theme embark ## multiple-cursors rg org-ac nord-theme lua-mode evil-collection beacon))
 '(warning-suppress-log-types '((frameset) (frameset))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hi-yellow ((t (:background "LightSkyBlue1" :foreground "black"))))
 '(tab-bar-tab-inactive ((t (:background "gray16" :foreground "#999999")))))
(put 'dired-find-alternate-file 'disabled nil)
