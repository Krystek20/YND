import UIKit.UICollectionView

final class ImageCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var imageCache: ImageCache?
    var data = [ImageViewCellData]()
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath)
        guard let imageCellView = cell as? ImageViewCell, data.indices.contains(indexPath.row) else { return cell }
        setupImageCellView(imageCellView: imageCellView, imageCellData: data[indexPath.row])
        return imageCellView
    }
    
    // MARK: - Managing
    
    private func setupImageCellView(imageCellView: ImageViewCell, imageCellData: ImageViewCellData) {
        let viewModel = ImageViewCellModel(imageData: imageCellData)
        imageCellView.viewModel = viewModel
        if let imageCache = imageCache {
            viewModel.setupImageCache(imageCache)
        }
        viewModel.loadImage()
    }
}
