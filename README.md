# emacs-sourcekit-lsp

emacs-sourcekit-lsp is a client for [sourcekit-lsp](https://github.com/apple/sourcekit-lsp), a Swift/C/C++/Objective-C language server created by Apple.

Uses [lsp-mode](https://github.com/emacs-lsp/lsp-mode), but it's also open to be extended with additions outside of the LSP protocol, like semantic highlighting, if the server supports that.

## Quickstart

```elisp
(require 'sourcekit-lsp)
(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a.xctoolchain")
(setq sourcekit-lsp-executable (expand-file-name "<path_to_sourcekit-lsp>/.build/x86_64-apple-macosx10.10/debug/sourcekit-lsp"))
```

## License

[MIT](http://opensource.org/licenses/MIT)