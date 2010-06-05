;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/vendor")

;; GUI

(defun setup-gui ()
  ;; hide toolbar
  (tool-bar-mode 0)
  ;; transparent background
  (set-frame-parameter (selected-frame) 'alpha '(85 50))
  (add-to-list 'default-frame-alist '(alpha 85 50))
  ;; setup color theme
  (require 'color-theme)
  (color-theme-initialize)
  (load-file "~/.emacs.d/vendor/themes/color-theme-cobalt.el")
  (color-theme-cobalt))

(if window-system
    (setup-gui))

;; Package manager

(when (load (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; CEDET

(load-file "~/.emacs.d/vendor/cedet-1.0pre7/common/cedet.el")
;;(global-ede-mode 1)                 ; Enable the Project management system
;;(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
;;(global-srecode-minor-mode 1)       ; Enable template insertion menu

;; ECB

(add-to-list 'load-path "~/.emacs.d/vendor/ecb-2.40")
(require 'ecb)

(custom-set-variables
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-layout-window-sizes (quote (("custom1"
                                    (0.2345679012345679 . 0.7666666666666667)
                                    (0.2345679012345679 . 0.2)))))
 '(ecb-show-sources-in-directories-buffer (quote ("left7" "left13" "left14" "left15" "custom1")))
 '(ecb-source-path (quote (("~/" "Home"))))
 '(ecb-layout-name "custom1")
 '(ecb-tip-of-the-day nil))

;; nXHTML

(load "~/.emacs.d/vendor/nxhtml/autostart.el")

;; MuMaMo-Mode for rhtml files
(add-to-list 'load-path "~/.emacs.d/vendor/nxhtml/util")
(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;; (defun run-coding-hook ()
;;   "Enable things that are convenient across all coding buffers."
;;   nil)


;; YASnippets

(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-directory "~/Work")

;; Tab size
(setq nee-tab-size 2)

;; Code modes
(setq nee-code-modes
      '(emacs-lisp-mode lisp-mode
        clojure-mode    scheme-mode
        haskell-mode    ruby-mode
        rspec-mode      python-mode
        c-mode          c++-mode
        objc-mode       latex-mode
        plain-tex-mode  php-mode
        js2-mode        feature-mode
        css-mode))

;; Visual Line Mode
(when (> emacs-major-version 22)
  (visual-line-mode t))

;; Highlight current line
(global-hl-line-mode t)

;; ;; TextMate mode
(require 'textmate)
(textmate-mode)

;; Always show line numbers
(require 'linum)
;; (global-linum-mode 1)

;; Better scrolling?
(set-variable 'scroll-conservatively 0)

;; Show paren matches
(show-paren-mode t)

;; ;; Auto pairing
(require 'autopair)
(autopair-global-mode)

;; Whitespace options
(require 'whitespace)
(setq whitespace-style '(trailing tabs)
      whitespace-global-modes nee-code-modes)
(global-whitespace-mode)

;; Other settings

(defun range (start end)
  (loop for i from start below end collect i))

(setq-default
 c-basic-offset nee-tab-size
 c-default-style "k&r"
 indent-tabs-mode nil
 tab-width nee-tab-size
 tab-stop-list (mapcar '(lambda (x) (* x nee-tab-size)) (range 1 50)))

;; Setup Auto-indenting by default on return

(defun smart-indented-newline ()
  (interactive)
  (newline)
  (indent-according-to-mode))

(define-key global-map (kbd "RET") 'smart-indented-newline)

;; Paste with correct indention

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode nee-code-modes)
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

;; ido Settings

(when (> emacs-major-version 21)
  (ido-mode t)
  (ido-everywhere t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10))

;; Shell Stuff

(setenv "TERM" "ansi")
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))

(defun start-another-shell ()
  "start a new instance of shell;       ;
   if buffer \"*shell*\" already exists, rename it and start a new instance.
   The older shell will be marked \"\", counter-intuitively...."
  (interactive)
  (setq shell-name "*shell*")
  (if (get-buffer shell-name)
      (progn
        (switch-to-buffer shell-name)
        (rename-buffer (generate-new-buffer-name shell-name))))
  (shell))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode-Specific Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Erlang
;;;;;;;;;;;

(setq nee-erlang-install-root "/usr/local/lib/erlang"
      load-path (cons (concat nee-erlang-install-root "/lib/tools-2.6.4/emacs") load-path)
      erlang-root-dir nee-erlang-install-root
      exec-path (cons (concat nee-erlang-install-root "/bin") exec-path))
(require 'erlang-start)

(setq erlang-indent-level nee-tab-size)

;; Lisps
;;;;;;;;;;

(autoload 'highlight-parentheses-mode "highlight-parentheses" t)
(setq hl-paren-colors
      '("#FFFF00" "#FFCC00" "#FF9900" "#FF6600"
        "#FF0000" "#CC0099" "#660099"
        "#0033CC" "#009999" "#00CC00" "#99FF00"))

(defun lisp-general-settings ()
  (highlight-parentheses-mode))

(add-hook 'clojure-mode-hook #'lisp-general-settings)
(add-hook 'lisp-mode-hook #'lisp-general-settings)
(add-hook 'emacs-lisp-mode-hook #'lisp-general-settings)

(add-hook 'lisp-mode-hook
          (lambda () (setq inferior-lisp-program "lisp")))

(add-hook 'clojure-mode-hook
          (lambda () (setq inferior-lisp-program "~/bin/clj")))

;; Ruby
;;;;;;;;;

;; (require 'starter-kit-ruby)
;; (require 'ruby-electric)

;; Why this is needed, I do not know, but I believe it is...
(add-hook 'ruby-mode-hook '(lambda ()
                             (local-set-key (kbd "RET") 'smart-indented-newline)))

(setq nee-ruby-mode-files
      '("\\.rake$" "Rakefile$" "\\.gemspec$" "\\.ru$" "Gemfile$"
        "Capfile" "capfile"))

(loop for x in nee-ruby-mode-files do
      (add-to-list 'auto-mode-alist (cons x 'ruby-mode)))

;; Cucumber
;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/vendor/feature-mode")
;; optional configurations
(autoload 'feature-mode "feature-mode" t)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; YAML
;;;;;;;;;

(autoload 'yaml-mode "yaml-mode" t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; CSS
;;;;;;;;

(setq css-indent-offset nee-tab-size)

;; JavaScript
;;;;;;;;;;;;;;;

;; (setq js2-indent-on-enter-key t)
;; (autoload 'js2-mode "js2" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level nee-tab-size)

;; Text
;;;;;;;;;

(add-hook 'text-mode-hook 'flyspell-mode)

;; Latex
;;;;;;;;;;

(add-hook 'PDFLaTeX-mode-hook 'flyspell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-S-k") 'kill-whole-line)
