;; start server
;; This allows the current instance of emacs to be used
;; by the `runemacs.exe` command.
(server-start)

;; Windows integration
;; Command to maximize the current frame:
;; (w32-send-sys-command #xf030)

;;Window navigation
;; Map window switching to a shortcut requiring a single movement
(global-set-key (kbd "M-o") 'other-window)

;; dired use external ls program. On my setup this command is in a directory that is
;; part of the PATH env variable. The ls command used is the one provided by git-bash.
(setq ls-lisp-use-insert-directory-program t)



;; emacs config management
(define-derived-mode vibailly-config-mode special-mode "vibailly config"
  "Documentation for vibailly's config mode goes here."
  :interactive nil
  (define-key vibailly-config-mode-map "g" 'vibailly-config--refresh)
  (define-key vibailly-config-mode-map "c" 'vibailly-config--commit)
  (define-key vibailly-config-mode-map "p" 'vibailly-config--push)
  (set (make-local-variable 'vibailly-config--command) (format "git --git-dir %s/emacsConfig --work-tree %s/.emacs.d" (getenv "HOME") (getenv "HOME")))
  (vibailly-config--refresh))

(defun vibailly-config ()
  "Display the status of vibailly's config"
  (interactive)
  (let ((buff (get-buffer-create "*vibailly-config*")))
    (switch-to-buffer buff)
    (vibailly-config-mode)))

(defun vibailly-config--refresh ()
  "Refresh config buffer content"
  (interactive)
  (read-only-mode 0)
  (erase-buffer)
  (shell-command (format "%s status -v -v --no-ahead-behind" vibailly-config--command) (current-buffer))
  (goto-char (point-max))
  (insert "\n\nPress \"g\" to refresh, \"c\" to commit, \"p\" to push\n")
  (read-only-mode 1))

(defun vibailly-config--commit ()
  "Commit latest changes"
  (interactive)
  (shell-command (format "%s add ." vibailly-config--command))
  (shell-command (format "%s commit -m \"automated commit\"" vibailly-config--command))
  (vibailly-config--refresh))

(defun vibailly-config--push ()
  "Push latest changes"
  (interactive)
  (shell-command (format "%s push" vibailly-config--command))
  (vibailly-config--refresh))
