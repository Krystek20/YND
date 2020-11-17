import UIKit

final class ImageCollectionView: UIView {

    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: ImageCollectionViewModelType? {
        didSet { setupBindings() }
    }
    private var dataSource: ImageCollectionDataSource = ImageCollectionDataSource()
    
    // MARK: - Setup
    
    private func setupBindings() {
        
        viewModel?.title = { [weak self] title in
            self?.titleLabel.text = title
        }
        
        viewModel?.imageData = { [weak self] imageData in
            self?.dataSource.data = imageData
        }
        
        viewModel?.imageCachePrepared = { [weak self] imageCache in
            self?.dataSource.imageCache = imageCache
        }
        
        viewModel?.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelf()
    }
    
    private func setupSelf() {
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = prepareLayout()
    }
    
    // MARK: - Managing
    
    @IBAction private func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let type = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        viewModel?.setSelectedType(type)
    }
    
    private func prepareLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let tripletItem = NSCollectionLayoutItem(layoutSize: layoutSize)

        let inset = CGFloat(3.0)
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let tripletGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.5 / 6.0))
        let tripletGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripletGroupSize, subitems: [tripletItem, tripletItem, tripletItem])

        let smallerTripletGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0 / 6.0))
        let smallerTripletGroup = NSCollectionLayoutGroup.horizontal(layoutSize: smallerTripletGroupSize, subitems: [tripletItem, tripletItem, tripletItem])

        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2.5 / 6.0))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [tripletGroup, smallerTripletGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
