# emacs-sourcekit-lsp

emacs-sourcekit-lsp is a client for [sourcekit-lsp](https://github.com/apple/sourcekit-lsp), a Swift/C/C++/Objective-C language server created by Apple.

Uses [lsp-mode](https://github.com/emacs-lsp/lsp-mode), but it's also open to be extended with additions outside of the LSP protocol, like semantic highlighting, if the server supports that.

## Quickstart

You need to download [sourcekit-lsp](https://github.com/apple/sourcekit-lsp) and follow their repo instructions to build it using Swift Package Manager, for example.

After that, you need to download and install [a custom development Swift toolchain from Swift.org website](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a-osx.pkg) (in the future, Apple plans to make sourcekit-lsp work with Swift release toolchains).

Finally, add the following code to your `init.el`:

```elisp
(require 'sourcekit-lsp)
(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a.xctoolchain")
(setq sourcekit-lsp-executable (expand-file-name "<path_to_sourcekit-lsp>/.build/x86_64-apple-macosx10.10/debug/sourcekit-lsp"))
```

You can add `sourcekit-lsp-swift-enable` to your `swift-mode` hook and it will load sourcekit-lsp whenever you visit a `.swift` file.

## MELPA

This package is not available on MELPA yet (but it's planned).

## License

[MIT](http://opensource.org/licenses/MIT)