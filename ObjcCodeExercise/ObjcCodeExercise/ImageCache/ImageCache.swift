//
//  ImageCache.swift
//  ObjcCodeExercise
//


import Foundation
import UIKit

final class ImageCache: NSObject {

    private let fileManager = FileManager.default
    private let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    private let localCacheSize = 100
    private var localCache = [String: UIImage]()

    func imageName(for url: URL) -> String {

        var imageName = url.lastPathComponent
        if let size = url.query {
            imageName += size
        }
        return imageName
    }

    func destinationURL(for url: URL) -> URL {
        let imageName = self.imageName(for: url)
        return self.cachesPath.appendingPathComponent(imageName)
    }

    @objc func destinationURL(for imageName: String) -> URL {
        return self.cachesPath.appendingPathComponent(imageName)
    }

    @objc func cachedImage(for imageName: String) -> UIImage? {

        clearCacheIfNeeded()

        let imageKey = imageName
        if let localImage = localCache[imageKey] {
            return localImage
        }

        let imageLocation = destinationURL(for: imageKey).path
        if let imageFromDisk = UIImage(contentsOfFile: imageLocation) {
            storeImageLocally(image: imageFromDisk, key: imageKey)
            return imageFromDisk
        }
        return nil
    }

    func storeImageLocally(image: UIImage, key: String) {
        localCache[key] = image
    }

    func clearCacheIfNeeded() {
        if localCache.count > localCacheSize {
            localCache.removeAll()
        }
    }

    @objc func storeImageInCache(from location: URL, imageName: String) throws -> UIImage {

        let destination = destinationURL(for: imageName)
        guard let imagePath = try moveImage(from: location, to: destination), let image = UIImage(contentsOfFile: imagePath) else {
            throw NSError()
        }
        return image
    }

    @objc func storeImageInCache(image: UIImage, imageName: String) throws {

        let destination = destinationURL(for: imageName)
        try save(image: image, to: destination)
    }
    
    private func moveImage(from: URL, to destinationURL: URL) throws -> String? {

        do {
            try self.fileManager.moveItem(at: from, to: destinationURL)
        } catch {

            let nsError = error as NSError
            if nsError.code == NSFileWriteFileExistsError {
                return destinationURL.path
            }
            debugPrint("Moving image error \(error)")
            throw error
        }

        return destinationURL.path
    }

    private func save(image: UIImage, to destinationURL: URL) throws {

        do {

            let binaryData = image.pngData()
            try binaryData?.write(to: destinationURL, options: .atomicWrite)
        } catch {
            debugPrint("Writing image error \(error)")
            throw error
        }
    }
}
