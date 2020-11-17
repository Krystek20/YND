import Foundation
import UIKit.UIColor
import UIKit.UIImage

protocol ImageViewCellModelType: class {
    
    // MARK: - Properties
    
    var cellSize: CGSize { get set }
    
    // MARK: - Input
    
    func setupImageCache(_: ImageCache)
    func loadImage()
    func prepareForReuse()
    
    // MARK: - Outputs
    
    var color: ((UIColor?) -> Void)? { get set }
    var image: ((UIImage?) -> Void)? { get set }
}

final class ImageViewCellModel: ImageViewCellModelType {
    
    // MARK: - Properties
    
    var cellSize = CGSize.zero
    private var imageSize: CGSize { CGSize(width: cellSize.width * scale, height: cellSize.height * scale)}
    private let imageData: ImageViewCellData
    private let imageProvider: ImageProvider
    private var url: URL? { URL(string: imageData.path) }
    private let scale: CGFloat
    
    // MARK: - Initialization
    
    init(imageData: ImageViewCellData,
         imageProvider: ImageProvider = ImageProvider(),
         scale: CGFloat = UIScreen.main.scale) {
        self.imageData = imageData
        self.imageProvider = imageProvider
        self.scale = scale
    }
    
    // MARK: - Outputs
    
    var color: ((UIColor?) -> Void)? {
        didSet { color?(imageData.color) }
    }
    var image: ((UIImage?) -> Void)?
    
    // MARK: - Inputs
    
    func setupImageCache(_ imageCache: ImageCache) {
        imageProvider.imageCache = imageCache
    }
    
    func loadImage() {
        guard let imageUrl = url else { return }
        imageProvider.getImageFrom(imageUrl, useCache: false, completion: { [weak self] image, url in
            guard self?.url == url, let imageSize = self?.imageSize else { return }
            let scaledImage = image.scaleImage(destinationSize: imageSize)
            DispatchQueue.main.async { [weak self] in
                self?.image?(scaledImage)
            }
        })
    }
    
    func prepareForReuse() {
        image?(nil)
    }
}
