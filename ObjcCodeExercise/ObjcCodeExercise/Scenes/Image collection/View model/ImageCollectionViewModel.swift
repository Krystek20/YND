import Foundation

protocol ImageCollectionViewModelType: class {
    
    // MARK: - Input
    
    func setSelectedType(_ type: String)
    
    // MARK: - Outputs
    
    var title: ((String) -> Void)? { get set }
    var imageCachePrepared: ((ImageCache) -> Void)? { get set }
    var imageData: (([ImageViewCellData]) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
}

final class ImageCollectionViewModel: NSObject, ImageCollectionViewModelType {
    
    // MARK: - Properties
    
    private let query: String
    private let totalCount: UInt
    private let images: [ImageMetadata]
    private var selectedType = ImageThumbnailType.small
    private let imageCache: ImageCache
    
    // MARK: - Initialization
    
    init(query: String, totalCount: UInt, images: [ImageMetadata], imageCache: ImageCache = ImageCache()) {
        self.query = query
        self.totalCount = totalCount
        self.images = images
        self.imageCache = imageCache
    }
    
    // MARK: - Outputs
    
    var title: ((String) -> Void)? {
        didSet { title?(query + " (\(totalCount))") }
    }
    
    var imageData: (([ImageViewCellData]) -> Void)? {
        didSet { loadData() }
    }
    
    var imageCachePrepared: ((ImageCache) -> Void)? {
        didSet { imageCachePrepared?(imageCache) }
    }
    var reloadData: (() -> Void)?
    
    // MARK: - Inputs
    
    func setSelectedType(_ type: String) {
        if type == "Full" {
            selectedType = .full
        } else {
            selectedType = .small
        }
        loadData()
        reloadData?()
    }
    
    // MARK: - Managing
    
    private func loadData() {
        let data = images
            .map { ImageViewCellData(identifier: $0.identifier, path: $0.urls.path(for: selectedType), color: $0.color) }
        imageData?(data)
    }
}

extension ImageCollectionViewModel {
    @objc static func defaultViewModel(query: String, totalCount: UInt, images: [ImageMetadata]) -> ImageCollectionViewModel {
        ImageCollectionViewModel(query: query, totalCount: totalCount, images: images)
    }
}
