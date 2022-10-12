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



;; test
