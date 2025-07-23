import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let sections = Section.allCases

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupDataSource()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = getLayout()
        collectionView.register(
            TodaySectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TodaySectionHeaderView.reuseIdentifier
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )
        collectionView.register(LargeCardCell.self, forCellWithReuseIdentifier: "LargeCardCell")
        collectionView.register(MediumCardCell.self, forCellWithReuseIdentifier: "MediumCardCell")
        collectionView.register(RecommendCell.self, forCellWithReuseIdentifier: "RecommendCell")
    }

    private func getLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.sections[sectionIndex]
            switch section {
                case .today: return self.getTodaySection()
                case .recommend: return self.getRecommentSection()
            }
        }
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: "section-background")
        return layout
    }

    private func getTodaySection() -> NSCollectionLayoutSection {
        let largeItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(440)
        )
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)

        let mediumItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(170)
        )
        let mediumItem = NSCollectionLayoutItem(layoutSize: mediumItemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(610)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [largeItem, mediumItem]
        )
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(60)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    private func getRecommentSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(72))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(72))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        let background = NSCollectionLayoutDecorationItem.background(elementKind: "section-background")
        background.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.decorationItems = [background]

        return section
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            collectionView, indexPath, item in
            switch item {
                case .largeCard(let largeCard):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCardCell", for: indexPath) as! LargeCardCell
                    cell.configure(with: largeCard)
                    return cell

                case .mediumCard(let mediumCard):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediumCardCell", for: indexPath) as! MediumCardCell
                    cell.configure(with: mediumCard)
                    return cell

                case .app(let app):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
                    cell.configure(with: app)
                    return cell
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let section = self.sections[indexPath.section]

            switch section {
                case .today:
                    let view = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: TodaySectionHeaderView.reuseIdentifier,
                        for: indexPath
                    ) as! TodaySectionHeaderView
                    return view
                default:
                    let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: "HeaderView",
                        for: indexPath
                    ) as! HeaderView
                    header.configure(for: section)
                    return header
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        snapshot.appendItems(todayItems, toSection: .today)
        snapshot.appendItems(recommendItems, toSection: .recommend)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
