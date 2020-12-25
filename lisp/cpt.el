;;; lisp/cpt.el -*- lexical-binding: t; -*-

;; Some cpt functions to use inside Emacs

;;;###autoload
(defun cpt-pkg-directory (pkg)
  "Return the location of PKG."
  (interactive "sEnter package name: ")
  (let (pkg-dir)
    (if (string= "" pkg) (user-error "No package specified")
      (setq pkg-dir
            (shell-command-to-string
             (format "cpt s -s \"%s\" 2>/dev/null | tr '\n' /" pkg)))
      (if (called-interactively-p 'interactive)
          (message "%s" pkg-dir)
        pkg-dir))))

;;;###autoload
(defun cpt-find-file (pkg)
  "Find file in PKG directory."
  (interactive "sEnter package name: ")
  (unless (string= "" pkg)
    (find-file (read-file-name "Package file: " (cpt-pkg-directory pkg)))))

(provide 'cpt)
;;; lisp/cpt.el ends here
