;;; sourcekit-lsp.el --- sourcekit-lsp client for lsp-mode     -*- lexical-binding: t; -*-

;; Copyright (C) 2018 Daniel Martín

;; Author: Daniel Martín
;; Version: 0.1
;; Homepage: https://github.com/danielmartin/emacs-sourcekit-lsp
;; Package-Requires: ((emacs "25.1") (lsp-mode "4.2"))
;; Keywords: languages, lsp, swift, objective-c, c++

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and-or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.
;;
;;; Commentary:

;;
;; Call (sourcekit-lsp-enable) in your swift-mode hook.
;;
;; TODO: Configure the Objective-C/C++ LSP client (requires clangd).

;;; Code:

(require 'lsp-mode)
(require 'lsp-methods)

;; ---------------------------------------------------------------------
;;   Customization
;; ---------------------------------------------------------------------

(defcustom sourcekit-lsp-executable
  "ccls"
  "Path of the sourcekit-lsp executable."
  :type 'file
  :group 'sourcekit)

(defcustom sourcekit-lsp-extra-args
  nil
  "Additional command line options passed to the sourcekit-lsp executable."
  :type '(repeat string)
  :group 'sourcekit)

;; ---------------------------------------------------------------------
;;   Notification handlers
;; ---------------------------------------------------------------------

(defvar sourcekit-lsp--handlers nil
  "List of cons-cells of (METHOD . HANDLER) pairs, where METHOD is the lsp method to handle,
and handler is a function invoked as (handler WORKSPACE PARAMS), where WORKSPACE is the current
lsp-workspace, and PARAMS is a hashmap of the params received with the notification.")

;; ---------------------------------------------------------------------
;;  Register lsp client
;; ---------------------------------------------------------------------

(defun sourcekit-lsp--make-renderer (mode)
  `(lambda (str)
     (with-temp-buffer
       (delay-mode-hooks (,(intern (format "%s-mode" mode))))
       (insert str)
       (font-lock-ensure)
       (buffer-string))))

(defun sourcekit--initialize-client (client)
  (dolist (p sourcekit-lsp--handlers)
    (lsp-client-on-notification client (car p) (cdr p)))
  (lsp-provide-marked-string-renderer client "swift" (sourcekit-lsp--make-renderer "swift")))

;;;###autoload (autoload 'lsp-sourcekit-enable "sourcekit-lsp")
(lsp-define-stdio-client
 sourcekit-lsp-swift "swift" (lambda () default-directory)
 `(,sourcekit-lsp-executable ,@sourcekit-lsp-extra-args)
 :initialize #'sourcekit--initialize-client)

(provide 'sourcekit-lsp)
;;; sourcekit-lsp.el ends here
