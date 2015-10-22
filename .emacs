;;;;***************************** common ****************************************

; hide menu bar
(menu-bar-mode -1)

; set tabs to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
; set tab width in text mode:
(setq indent-line-function 'insert-tab)

;;(desktop-save-mode 1)  ;; saving emacs sessions.

;; change all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;;don't make any backup files.
(setq make-backup-files  nil)

;; do not dispaly the *GNU Emacs* window when emacs startup
(setq inhibit-startup-message t)

(put 'dired-find-alternate-file 'disabled nil)

;; grep-find exclude .svn directories:
;; (global-set-key [f3] 'grep-find)
;; (setq grep-find-command
;;   "find . -path '*/.svn' -prune -o -type f -print0 | xargs -0 -e grep -I -n -e ")

;;auto reload file:
(global-auto-revert-mode t)

(iswitchb-mode 1)

;; untabify and delete-trailling-whitespaces on save in some mode:
(setq alexott/untabify-modes
      '(emacs-lisp-mode
        java-mode scala-mode c-mode go-mode web-mode nxml-mode
        sgml-mode groovy-mode javascript-mode thrift-mode
        js-mode coffee-mode))

(defun alexott/untabify-hook()
  (when (member major-mode alexott/untabify-modes)
    (delete-trailing-whitespace)
    (untabify (point-min) (point-max))))
(add-hook 'before-save-hook 'alexott/untabify-hook)

;;;;;;;;;;;;;;;;;;;;;; Common mode ;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;; Global setting key ;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-h j") 'javadoc-lookup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;-------------- tools -------------

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;;----------------------------------

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; ;; support gradle build file with groovy-mode.
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.jaap$" . java-mode))

(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/ac-dict")
(global-auto-complete-mode t)
(ac-config-default)
;; Distinguish case
(setq ac-ignore-case nil)

;;yasnippet:
(require 'yasnippet) ;; not yasnippet-bundle
;;(yas/initialize)
;;(setq yas/root-directory "~/.emacs.d/elpa/yasnippet-extra")
(setq yas/prompt-functions '( yas/dropdown-prompt yas/x-prompt yas/ido-prompt yas/completing-prompt))
;;(yas/load-directory yas/root-directory)
(yas/global-mode 1)
(yas/minor-mode-on)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; custom web-mode html-tag-bracket color.
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "tan3")
;;;;;;;;;;;;;;;;;;;;;; INDENT ;;;;;;;;;;;;;;;;;;;
;; indent 4 in groovy-mode.
;; (add-hook 'groovy-mode-hook
;;           (setq indent-tabs-mode nil
;;                 c-basic-offset 4))

;; indent 4 for js:
;;(setq js-indent-level 4)

;; indent 2 for web-mode:
(setq web-mode-markup-indent-offset 2)

;;use sgml-mode for xml-mode.
(defalias 'xml-mode 'sgml-mode
  "Use `sgml-mode' instead of nXML's `xml-mode'.")
;; Defines tab spacing in sgml mode (includes XML mode)
;; source: http://www.emacswiki.org/emacs/IndentingHtml
;;(setq sgml-basic-offset 2)  ;; default 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; javadoc-lookup config:
(require 'javadoc-lookup)
(javadoc-add-roots "/usr/local/klzhong/javadoc-repo/jdk-7u80-docs-all/docs/api"
                   "/usr/local/klzhong/javadoc-repo/spring-framework-4.1.7.RELEASE-docs/javadoc-api")


;; load packages load by Homebrew:
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
