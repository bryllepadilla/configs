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

(setq inhibit-startup-screen t)
(defun my/truncated-buffer-name ()
  (truncate-string-to-width (buffer-name) 32 nil nil "..."))
(setq-default mode-line-format
	      '("%e" mode-line-modified
		" "
		(:eval (my/truncated-buffer-name))
		" "
		mode-line-position
		mode-line-modes))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-superword-mode t)
(global-set-key (kbd "C-a") 'back-to-indentation)
(desktop-save-mode 1)
(require 'savehist)
(savehist-mode 1)                                        ;; EITHER desktop-save or dashboard startup hook | speed > storage-history
(tab-bar-mode 1)
(tab-bar-history-mode 1)
(save-place-mode 1)

(setq ring-bell-function 'ignore)
(add-to-list 'desktop-globals-to-save 'register-alist)
;;(add-to-list 'desktop-globals-to-save 'pdf-view-register-alist)

(add-to-list 'desktop-locals-to-save 'pdf-view-register-alist)
(add-to-list 'savehist-additional-variables 'pdf-view-register-alist)
(add-to-list 'savehist-additional-variables 'register-alist)
;;;;     (setq pdf-view-use-dedicated-register t)   ;set via can customize variable ;if the variable exists in your version
;;;;(add-to-list 'savehist-additional-variables 'pdf-view-with-register-alist)

(setq default-directory "c:/Users/Brylle Padilla/Documents/emacs_windows/")
(setq desktop-path '("~/.emacs.d/"))
;;(dired-copy-filename-as-kill 0)


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


;;(defalias 'dired #'dired-other-window)
(global-set-key (kbd "C-x d") 'dired-other-window)

(require 'marginalia)
(marginalia-mode t)

;;-------------------- STARTUP ----------------------
;;(require 'dashboard)
;;(setq dashboard-startup-banner 'logo
;;      dashboard-center-content t
;;      dashboard-set-file-icons t
;;      dashboard-set-heading-icons t
;;      dashboard-set-navigator t
;;      dashboard-projects-backend 'projectile)   ;; or 'project (buil


(setq display-buffer-alist nil)
(add-to-list 'display-buffer-alist            ;;in-side-window >> side . top << CANNOT BE a single window buffer
	     '("\\.pdf\\'"                    ;;in-direction >> direction . up || in-side-window >> side . top
	       (display-buffer-reuse-mode-window display-buffer-in-direction)
	       (mode . pdf-view-mode)
	       (direction . left)              ;;top
	       (window-width . 0.5))
	     )
(add-to-list 'display-buffer-alist
	     '("\\(info\\|Help\\|TUTORIAL\\|Org Agenda\\|Agenda Commands\\)"
	       (display-buffer-in-side-window)
	       (side . left)
	       (window-width . 0.3))
	     )
(add-to-list 'display-buffer-alist
	     '("\\Outline*"
	       (display-buffer-below-selected)
	       (window-height . 0.3))
	     )

(require 'nov)
(setq nov-mode t)
(setq nov-unzip-program "C:\\Program Files (x86)\\GnuWin32\\bin\\unzip.exe")
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))        ;; to avoid going to folders, upon clicking a .epub file
(add-hook 'nov-mode-hook 'visual-line-mode)

;;(setq pdf-view-themed-minor-mode t)

(setq evil-want-keybinding nil)
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(evil-mode t)
(require 'evil-collection)
(evil-collection-init)

(with-eval-after-load 'evil
  ;;(evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'nov-mode 'emacs)
  ;;(evil-set-initial-state 'pdf-view-mode 'normal)                ;; SIOYEK simulator
  (evil-set-initial-state 'pdf-annot-list-mode 'emacs)
  ;;(define-key evil-normal-state-map (kbd "q") #'quit-window)   ;; define-key are enclosed under with-eval-after-load
  ;;(define-key evil-normal-state-map (kbd "q") #'delete-window)   ;; to avoid clashing  ;;samsung-tablet #'kill-buffer-and-window
  (evil-set-initial-state 'Info-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'fundamental-mode 'emacs)
  )

(evil-global-set-key 'normal (kbd "C-t") #'tab-new)
(global-set-key (kbd "C-S-t") #'make-frame)
;;(global-set-key (kbd "M-1") #'tab-previous)
;;(global-set-key (kbd "M-2") #'tab-next)
(global-set-key (kbd "C-<prior>") #'tab-previous)
(global-set-key (kbd "C-<next>") #'tab-next)
(global-set-key (kbd "M-1") #'previous-buffer)  ;tab-previous
(global-set-key (kbd "M-2") #'next-buffer)      ;tab-next
(global-set-key (kbd "C-1") #'tab-previous)  ;tab-previous
(global-set-key (kbd "C-2") #'tab-next)      ;tab-next
(evil-global-set-key 'normal (kbd "C->") #'dashboard-open)
(evil-global-set-key 'normal (kbd "C-R") #'recentf-open-files)
(evil-global-set-key 'normal (kbd "C-.")
		     (lambda () (interactive)
		       (find-file "c:/Users/Brylle Padilla/Documents/emacs_windows/")))         ;;c:/emacs/.emacs.d/init.el
(evil-global-set-key 'normal (kbd "C-0")
		     (lambda () (interactive)
		       (dired "g:/My Drive/Books_1/1_Books_04/")))

(require 'multiple-cursors)
(use-package surround
  :ensure t
  :bind-keymap ("M-'" . surround-keymap))
(setq org-hide-emphasis-markers t)
(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

(require 'org-ac)
(add-hook 'org-mode-hook #'org-ac/setup-current-buffer)
(require 'org-tempo)
(add-to-list 'org-modules 'org-tempo)

(setq org-cycle-include-plain-lists t)

(load-library "find-lisp")
(setq org-agenda-files
      (find-lisp-find-files "c:/Users/Brylle Padilla/Documents/emacs_windows/" "\.org$"))
;;(setq org-agenda-files (directory-files-recursively) "c:/Users/Brylle Padilla/Documents/emacs_windows/" ".org$")
;;(setq org-agenda-files '("c:/Users/Brylle Padilla/Documents/emacs_windows/"))

(org-babel-do-load-languages
    'org-babel-load-languages
        '(
            (shell . t)
	    (C . t)
	    (emacs-lisp . t)
            ;;(bash . t)
            ;; Other languages...
        )
   ) 


;; Make sure that the bash executable can be found
(setq explicit-shell-file-name "c:/msys64/usr/bin/bash.exe")
(setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "c:/msys64/usr/bin")
(setq explicit-bash-args '("-l" "-i"))
(setq ansi-term-program explicit-shell-file-name)


;; msys, pdf-tools, M-x pdf-tools-install, conflict with display-line-numbers, internal link pdf: recognize org-to-pdfOutline
;;(pdf-tools-install)
(pdf-loader-install)
(setq-default pdf-view-display-size 'fit-width)
(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))
(add-hook 'pdf-view-mode-hook (lambda () (blink-cursor-mode -1)))

(defun my-display-numbers-hook ()                                ;; much granular acccess to line numbers >> global-display or display-line
  (display-line-numbers-mode 1))
(add-hook 'prog-mode-hook 'my-display-numbers-hook)
(add-hook 'org-mode-hook 'visual-line-mode)
(global-set-key [f9] 'visual-line-mode)

(require 'pulsar)
(pulsar-global-mode t)



;;(require 'kaganawa-theme)
;;(load-theme 'kaganawa-dragon t)
(load-theme 'nord t)
(add-to-list 'custom-theme-load-path (expand-file-name "c:/emacs/.emacs.d/themes"))
;;(load-theme 'modus-vivendi)
;;(require 'nordic-night-theme)
(set-frame-parameter nil 'alpha 94) ; 94% opacity
(add-to-list 'default-frame-alist '(alpha 94)) ; Or add to default list:

;;(save-place-mode 1) ;;DUPLICATE, use for pdf tools
(setq doc-view-resolution 150)
(setq large-file-warning-threshold nil)


(with-eval-after-load 'org
  (dolist (key '("M-h" "M-j" "M-k" "M-l"))
    (define-key org-mode-map (kbd key) nil))
  ;; Bold C-'
  (define-key org-mode-map (kbd "C-'") (lambda () (interactive) (org-emphasize ?*)))
  ;; Underline C-u
  (define-key org-mode-map (kbd "C-u") (lambda () (interactive) (org-emphasize ?_)))
  ;; Strikethrough C-t
  (define-key org-mode-map (kbd "C-t") (lambda () (interactive) (org-emphasize ?+)))
  ;; Highlight C-=
  (define-key org-mode-map (kbd "C-=") (lambda () (interactive) (org-emphasize ?=)))
  ;; Italics C-;
  (define-key org-mode-map (kbd "C-;") (lambda () (interactive) (org-emphasize ?/)))
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

;;(windmove-default-keybindings)               ;; IN CONFLICT with org-tables move cell
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)

(global-set-key (kbd "C-c <left>") 'windmove-swap-states-left)
(global-set-key (kbd "C-c <down>") 'windmove-swap-states-down)
(global-set-key (kbd "C-c <up>") 'windmove-swap-states-up)
(global-set-key (kbd "C-c <right>") 'windmove-swap-states-right)

(goto-address-mode 1) ;;replace internal header link in org rather to interacting with obsidian uri with mouse click 

;;(add-to-list 'load-path "~/.emacs.d/packages")
;;(require 'better-registers)
;;(better-registers-install-save-registers-hook)
;;(load better-registers-save-file)

(add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode)
(require 'saveplace-pdf-view)
(save-place-local-mode 1)
(with-eval-after-load 'pdf-view
  (setq-default pdf-view-display-size 'fit-page)   ;;pdf-view-fit-page-to-window 
  (evil-define-key 'normal pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation
    (kbd "u") 'pdf-annot-add-underline-markup-annotation
    (kbd "s") 'pdf-annot-add-squiggly-markup-annotation
    (kbd "t") 'pdf-annot-add-strikeout-markup-annotation
    (kbd "S-<backspace>") 'pdf-history-forward
    [backspace] #'pdf-history-backward
    [tab] #'pdf-outline)
    ;;add-to-list 'savehist-additional-variables 'pdf-view-register-alist   ;; ????
  ;;(define-key pdf-view-mode-map (kbd "u") 'pdf-annot-add-underline-markup-annotation)
  ;;(define-key pdf-view-mode-map (kbd "s") 'pdf-annot-add-squiggly-markup-annotation)
  ;;(define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-strikeout-markup-annotation)
  ;;  (kbd "m") #'bookmark-set     ; or your own wrapper
  ;;  (kbd "'") #'bookmark-jump)
  )

(require 'workgroups2)
(workgroups-mode 1)
(global-set-key (kbd "C-x 4") #'wg-create-workgroup)   ;; C-c w s  Save
(global-set-key (kbd "C-x 5") #'wg-open-workgroup)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5a4cdc4365122d1a17a7ad93b6e3370ffe95db87ed17a38a94713f6ffe0d8ceb"
     "96f69937feec9ec89b879f19ea38c65ee0f85f418b41212bf8e5c75f9ca82bb6"
     "7c7026a406042e060bce2b56c77d715c3a4e608c31579d336cb825b09e60e827"
     "daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077"
     "d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     default))
 '(obsidian-directory "C:/Users/Brylle Padilla/Documents/Obsidian2025/" nil nil "Customized with use-package obsidian")
 '(org-agenda-files
   '("c:/Users/Brylle Padilla/Documents/emacs_windows/03_PRIORITY-tester.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/z_requisite-WhileReading.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/x_linux-01-workingfile.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/w_checklist-WORKOUT.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/v_VOCABulary.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/s_testing-FUNDAMENTALS.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/s_linux-FUNDAMENTALS.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/s_emacs-FUNDAMENTALS.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/s_emacs-ESSAY.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/salesforce-01/setup-salesforce-vscode.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/salesforce-01/maintenance-admin.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/r_WISHLIST_tester.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/r_READINGLIST_testing-approach01.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/r_READINGLIST_selfhelp-potential.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/r_READINGLIST_priming-images.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/r_READINGLIST_linuxVimEmacs-supplemental01.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/p_practiceFolder/z_PARENT-org.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/p_practiceFolder/x_org-subfolders/z_CHILD-org-a.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/music-playlist-01/metal_tables.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/music-playlist-01/evolving-task_forMusic.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/l_Learning-emacs.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/l_Learning-emacs-DUMP.org"
     "c:/Users/Brylle Padilla/Documents/emacs_windows/linux-01/print.org"))
 '(package-selected-packages
   '(burly dashboard djvu emms evil evil-collection marginalia
	   multiple-cursors nordic-night-theme nov obsidian openwith
	   org org-ac org-emms org-pdftools pdf-tools pdf-view-restore
	   projectile pulsar rg saveplace-pdf-view surround vertico
	   workgroups2))
 '(pdf-annot-default-annotation-properties
   '((t (label . "")) (text (color . "#ff0000") (icon . "Note"))
     (highlight (color . "gray")) (underline (color . "black"))
     (squiggly (color . "gray")) (strike-out (color . "black"))))
 '(pdf-annot-list-format '((page . 3) (type . 10) (date . 24) (contents . 256)))
 '(pdf-view-use-dedicated-register t)
 '(pulsar-pulse-functions
   '(ace-window backward-page bookmark-jump delete-other-windows
		delete-window dired-maybe-insert-subdir
		dired-up-directory dired-goto-file dired-next-dirline
		dired-prev-dirline evil-goto-first-line evil-goto-line
		evil-scroll-down evil-scroll-line-to-bottom
		evil-scroll-line-to-center evil-scroll-line-to-top
		evil-scroll-page-down evil-scroll-page-up
		evil-scroll-up forward-page goto-line
		handle-switch-frame imenu logos-backward-page-dwim
		logos-forward-page-dwim handle-select-window
		move-to-window-line-top-bottom narrow-to-defun
		narrow-to-page narrow-to-region next-buffer next-error
		next-error-recenter next-multiframe-window
		occur-mode-goto-occurrence
		org-backward-heading-same-level
		org-forward-heading-same-level
		org-next-visible-heading org-previous-visible-heading
		other-window outline-backward-same-level
		outline-forward-same-level
		outline-next-visible-heading
		outline-previous-visible-heading outline-up-heading
		previous-buffer previous-error quit-window
		recenter-top-bottom reposition-window
		scroll-down-command scroll-up-command tab-close
		tab-new tab-next tab-previous widen windmove-down
		windmove-left windmove-right windmove-swap-states-down
		windmove-swap-states-left windmove-swap-states-right
		windmove-swap-states-up windmove-up
		occur-mode-mouse-goto goto-next-locus next-match
		Info-exit next-window-any-frame tab-bar-close-tab
		tab-bar-new-tab tab-bar-switch-to-next-tab
		tab-bar-switch-to-prev-tab org-open-at-mouse))
 '(warning-suppress-log-types '((org-element org-element-parser) (pdf-view))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
