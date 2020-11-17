import UIKit

final class ImageViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: ImageViewCellModelType? {
        didSet {
            setupViewModel()
            setupBindgins()
        }
    }
    
    // MARK: - Setup
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.prepareForReuse()
    }
    
    private func setupViewModel() {
        viewModel?.cellSize = bounds.size
    }
    
    private func setupBindgins() {
        
        viewModel?.color = { [weak self] color in
            self?.contentView.backgroundColor = color
        }
        
        viewModel?.image = { [weak self] image in
            self?.imageView.image = image
        }
    }
}
