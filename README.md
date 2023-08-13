# UIImageImageNamedBug

This project demistrastes a bug in iOS 10 and below where calling UIImage.imageNamed() on an image asset that is not in an asset bundle can cause a crash when run from a background thread.

## Background

UIKit is not thread safe and must only be accessed on the main thread. But since the very first version of iOS, in practice, loading a UIImage in the background will not crash.

this changed in iOS 7 which did crash. Apple found that this broke a lot of app and offically fixed it make it UIImage.imageNamed offically thread-safe.

## The reality

unfortually testing proves that UIImage is only thread safe when the image is stored in an asset bundle
