;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; This is my private configuration file, generated from the README.org file.

(setq user-full-name    "Cem Keylan"
      user-mail-address "cem@ckyln.com")

(setq doom-leader-alt-key "C-SPC"
      doom-localleader-key ","
      doom-localleader-alt-key "C-,")

(setq-hook! prog-mode tab-always-indent t)
(map! :mode prog-mode
      :nvmi [tab] #'indent-for-tab-command)

(setq org-directory "~/org/")

(after! org
  (setq-default
  org-adapt-indentation nil
  org-agenda-span 'week
  org-todo-keywords `((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                       (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|"
                                 "CANCELLED(c@/!)" "PHONE" "MEETING"))
  org-use-fast-todo-selection t
  org-refile-targets '((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9))
  org-refile-use-outline-path t
  org-outline-path-complete-in-steps nil
  org-todo-keyword-faces
  '(("TODO" :foreground "orange red" :weight bold)
    ("NEXT" :foreground "cyan" :weight bold)
    ("DONE" :foreground "spring green" :weight bold)
    ("WAITING" :foreground "orange" :weight bold)
    ("HOLD" :foreground "hot pink" :weight bold)
    ("CANCELLED" :foreground "spring green" :weight bold)
    ("MEETING" :foreground "spring green" :weight bold)
    ("PHONE" :foreground "spring green" :weight bold))
  org-export-backends '(ascii beamer html latex man md groff
                              texinfo koma-letter)))

(use-package! doct
  :after org
  :config
  (setq org-capture-templates
        (doct '(("todo"
                 :keys "t"
                 :file "~/org/refile.org"
                 :clock-in t
                 :template ("* %{todo-state} %^{Description}"
                            ":PROPERTIES:"
                            ":Created: %U"
                            ":END:" "%?")
                 :children (("todo"
                             :keys "t"
                             :todo-state "TODO")
                            ("next"
                             :keys "n"
                             :todo-state "NEXT")))
                ("note"
                 :keys "n"
                 :file "~/org/refile.org"
                 :clock-in t
                 :template ("* %? :NOTE:"
                            "%U"
                            "%a"))
                ("email"
                 :keys "e"
                 :file "~/org/refile.org"
                 :clock-in t
                 :template ("* %? :EMAIL:" "%U" "%a"))
                ("phone"
                 :keys "p"
                 :file "~/org/refile.org"
                 :clock-in t
                 :template ("* PHONE %? :PHONE:" "%U" "%a"))
                ("journal"
                 :keys "j"
                 :file "~/org/diary.org"
                 :datetree t
                 :template ("* %?" "%U"))
                ("recipe"
                 :keys "r"
                 :file "~/org/recipe.org"
                 :template ("* %^{Recipe}"
                            ":PROPERTIES:"
                            ":Created: %U"
                            ":END:" "%?"
                            "** Ingredients"
                            "** Instructions"))))))

(define-key!
  :definer 'minor-mode
  :states  'normal
  :keymaps 'org-src-mode
  "RET" #'org-edit-src-exit)

(use-package mu4e
  :if (executable-find "mu")
  :commands mu4e mu4e-compose-new
  :init
  (map!
   :leader
   :desc "Open mu4e" "m u" #'mu4e
   :desc "Compose mail" "m c" #'mu4e-compose-new))

(add-to-list 'load-path "~/conf/mu4e/")
(use-package mu4e-config
  :if (executable-find "mu")
  :after mu4e)

(setq doom-theme 'doom-dracula)

(setq display-line-numbers-type 'relative)
(setq-hook! text-mode display-line-numbers-type nil)

(add-load-path! "lisp/")

(use-package! doas-edit
  :if (executable-find "doas")
  :commands doas-edit-find-file doas-edit
  :init
  (map!
    [remap doom/sudo-find-file] #'doas-edit-find-file
    [remap doom/sudo-this-file] #'doas-edit))

(use-package! redo-mode
  :mode "\\.do\\'")

(use-package! cpt
  :commands cpt-find-file
  :init
  (map!
   :leader
   (:prefix ("c p" . "Package manager")
    :desc "Find package file" "f" #'cpt-find-file)))

(setq-default fill-column 80)
(add-hook! text-mode 'auto-fill-mode)

;; I don't want to enforce visual-lines on prog-mode
(add-hook! text-mode 'visual-line-mode)

(map! [remap evil-next-line]     #'evil-next-visual-line
      [remap evil-previous-line] #'evil-previous-visual-line)

(map! :nmi  "C-n" #'next-line
      :nmi  "C-p" #'previous-line
      :i    "C-a" #'move-beginning-of-line
      :i    "C-e" #'move-end-of-line)

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq dired-use-ls-dired nil)

(add-hook! after-save
  (defun tangle-doom-conf ()
    "Tangle the private doom configuration."
    (when (equal buffer-file-name (concat doom-private-dir "README.org"))
      (org-babel-tangle))))
