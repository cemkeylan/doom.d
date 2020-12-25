;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! evil-snipe :disable t)

(package! doct)

(package! doas-edit
  :recipe (:host github :repo "cemkeylan/doas-edit"))

(package! redo-mode
  :recipe (:host github :repo "cemkeylan/redo-mode"))
