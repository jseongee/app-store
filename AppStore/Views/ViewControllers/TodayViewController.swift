import UIKit

class TodayViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, Card>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupDataSource()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 16

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Card>(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
            cell.label.text = item.title
            return cell
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            ) as! HeaderView
            header.label.text = "투데이"
            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Card>()
        snapshot.appendSections([.today])
        snapshot.appendItems([
            Card(title: "카드 1"),
            Card(title: "카드 2"),
        ])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
