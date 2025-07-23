import UIKit

final class LargeCardCell: UICollectionViewCell {

    static let reuseIdentifier = "LargeCardCell"

    private let topInfoView = UIView()
    private let subCommentLabel = UILabel()
    private let mainCommentLabel = UILabel()

    private let bottomInfoView = UIView()
    private let appIconView = UIImageView()
    private let appTextsStackView = UIStackView()
    private let appCategoryLabel = UILabel()
    private let appNameLabel = UILabel()
    private let appDescLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // contentView 자체에 배경색과 radius 적용
        contentView.backgroundColor = UIColor(red: 53/255, green: 64/255, blue: 58/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        // 상단 영역
        topInfoView.translatesAutoresizingMaskIntoConstraints = false
        subCommentLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        subCommentLabel.textColor = .white.withAlphaComponent(0.9)
        mainCommentLabel.font = .systemFont(ofSize: 22, weight: .bold)
        mainCommentLabel.textColor = .white
        mainCommentLabel.numberOfLines = 2

        for label in [subCommentLabel, mainCommentLabel] {
            label.translatesAutoresizingMaskIntoConstraints = false
            topInfoView.addSubview(label)
        }

        contentView.addSubview(topInfoView)

        // 하단 영역
        bottomInfoView.translatesAutoresizingMaskIntoConstraints = false
        bottomInfoView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bottomInfoView.layer.cornerRadius = 16
        bottomInfoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomInfoView.clipsToBounds = true

        appIconView.translatesAutoresizingMaskIntoConstraints = false
        appIconView.layer.cornerRadius = 12
        appIconView.clipsToBounds = true
        appIconView.contentMode = .scaleAspectFill

        appCategoryLabel.font = .systemFont(ofSize: 12, weight: .regular)
        appCategoryLabel.textColor = .white.withAlphaComponent(0.9)

        appNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        appNameLabel.textColor = .white

        appDescLabel.font = .systemFont(ofSize: 13)
        appDescLabel.textColor = .white.withAlphaComponent(0.9)
        appDescLabel.numberOfLines = 1
        appDescLabel.lineBreakMode = .byTruncatingTail

        appTextsStackView.axis = .vertical
        appTextsStackView.spacing = 2
        appTextsStackView.translatesAutoresizingMaskIntoConstraints = false
        appTextsStackView.addArrangedSubview(appCategoryLabel)
        appTextsStackView.addArrangedSubview(appNameLabel)
        appTextsStackView.addArrangedSubview(appDescLabel)

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitleColor(.label, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        actionButton.backgroundColor = .systemGray6
        actionButton.layer.cornerRadius = 14
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        actionButton.setContentHuggingPriority(.required, for: .horizontal)

        contentView.addSubview(bottomInfoView)
        bottomInfoView.addSubview(appIconView)
        bottomInfoView.addSubview(appTextsStackView)
        bottomInfoView.addSubview(actionButton)

        // 제약
        NSLayoutConstraint.activate([
            // Top Info
            topInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topInfoView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            topInfoView.bottomAnchor.constraint(equalTo: bottomInfoView.topAnchor, constant: -16),

            subCommentLabel.topAnchor.constraint(equalTo: topInfoView.topAnchor),
            subCommentLabel.leadingAnchor.constraint(equalTo: topInfoView.leadingAnchor),

            mainCommentLabel.topAnchor.constraint(equalTo: subCommentLabel.bottomAnchor, constant: 4),
            mainCommentLabel.leadingAnchor.constraint(equalTo: subCommentLabel.leadingAnchor),
            mainCommentLabel.bottomAnchor.constraint(equalTo: topInfoView.bottomAnchor),

            // Bottom Info
            bottomInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomInfoView.heightAnchor.constraint(equalToConstant: 84),

            appIconView.leadingAnchor.constraint(equalTo: bottomInfoView.leadingAnchor, constant: 16),
            appIconView.centerYAnchor.constraint(equalTo: bottomInfoView.centerYAnchor),
            appIconView.widthAnchor.constraint(equalToConstant: 48),
            appIconView.heightAnchor.constraint(equalToConstant: 48),

            appTextsStackView.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor, constant: 12),
            appTextsStackView.centerYAnchor.constraint(equalTo: bottomInfoView.centerYAnchor),
            appTextsStackView.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -12),

            actionButton.centerYAnchor.constraint(equalTo: bottomInfoView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: bottomInfoView.trailingAnchor, constant: -16),
            actionButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configure(with card: LargeCard) {
        subCommentLabel.text = card.subComment
        mainCommentLabel.text = card.mainComment
        appIconView.image = card.appIcon
        appCategoryLabel.text = card.appCategory
        appNameLabel.text = card.appName
        appDescLabel.text = card.appDesc
        actionButton.setTitle("받기", for: .normal)
    }
}
