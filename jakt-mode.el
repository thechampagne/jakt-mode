;;; jakt-mode.el --- A major mode for the Jakt programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, jakt
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/jakt-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Jakt programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET jakt-mode RET` to install the mode.
;; Use `M-x jakt-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/jakt-mode.git

;; Then add path to jakt-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/jakt-mode/")
;; (require 'jakt-mode)

;; Use `M-x jakt-mode` to change your current mode.

;;; Code:

(defconst jakt-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 12b" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    table))


(defconst jakt-keywords
  '("anon" "as" "boxed" "break"
    "catch" "class" "continue"
    "cpp" "defer" "else" "enum"
    "extern" "for" "function"
    "comptime" "if" "import"
    "in" "is" "let" "loop"
    "match" "mut" "namespace"
    "not" "or" "override"
    "private" "public" "raw"
    "return" "restricted"
    "struct" "this" "throw"
    "throws" "try" "unsafe"
    "virtual" "weak" "while"
    "yield" "guard" ;; "true" "false"
    "requires" "implements" "trait"))


(defconst jakt-data-types
  '("i8" "i16" "i32" "i16"
    "i32" "i64" "u8" "u16"
    "u32" "u64" "f32" "f64"
    "bool" "c_int" "c_char"
    "usize" "String" "void"))


(defconst jakt-builtins
  '("print" "println"))


(defconst jakt-operators
  '("<" ">" "~" "?" "+"
    "-" "*" "/" "^" "|"
    "%" "!" "&" "$" "="))


(defconst jakt-constants
  '("true" "false"))


(defconst jakt-font-lock-keywords
  (list
   `(,(regexp-opt jakt-constants 'words) . font-lock-constant-face)
   `(,(regexp-opt jakt-data-types 'words) . font-lock-type-face)
   `(,(regexp-opt jakt-keywords 'symbols) . font-lock-keyword-face)
   `("namespace[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `("struct[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `("class[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `("enum[[:space:]]*\\<\\([a-zA-Z0-9_]*\\)\\>" . (1 font-lock-type-face))
   `(,(concat (regexp-opt jakt-builtins 'words)  "[[:space:]]*(") . (1 font-lock-builtin-face ))
   `("\\<\\([a-zA-Z0-9_]*\\)\\>[[:space:]]*(" . (1 font-lock-function-name-face))
   `(,(regexp-opt jakt-operators) . font-lock-builtin-face)))

;;;###autoload
(define-derived-mode jakt-mode prog-mode "Jakt"
  "A major mode for the Jakt programming language."
  :syntax-table jakt-mode-syntax-table
  (setq-local font-lock-defaults '(jakt-font-lock-keywords))
  (setq-local comment-start "// ")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.jakt\\'" . jakt-mode))

(provide 'jakt-mode)

;;; jakt-mode.el ends here
