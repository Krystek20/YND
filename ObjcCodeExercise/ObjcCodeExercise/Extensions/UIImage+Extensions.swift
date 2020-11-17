import UIKit.UIImage

extension UIImage {
    func scaleImage(destinationSize: CGSize) -> UIImage {
        guard destinationSize != .zero else { return self }
        let widthRatio = destinationSize.width / size.width
        let heightRatio = destinationSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let rect = CGRect(origin: .zero, size: scaledImageSize)
        return renderer.image { [weak self] _ in
            self?.draw(in: rect)
        }
    }
}
