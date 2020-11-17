import UIKit

final class ImageCollectionViewController: UIViewController {
    
    // MARK: - View
    
    @IBOutlet var imageCollectionView: ImageCollectionView!
    
    // MARK: - Properties
    
    private var viewModel: ImageCollectionViewModelType?
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    private func setupSelf() {
        imageCollectionView.viewModel = viewModel
    }
}

extension ImageCollectionViewController {
    @objc func setupViewModel(_ viewModel: ImageCollectionViewModel) {
        self.viewModel = viewModel
    }
}
