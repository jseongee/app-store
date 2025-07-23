import UIKit

class RecommendCell: UICollectionViewCell {
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    private static let fixedButtonWidth: CGFloat = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "업데이트"
        label.sizeToFit()
        return label.intrinsicContentSize.width + 32
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.layer.cornerRadius = 12
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = .systemFont(ofSize: 13)
        descLabel.textColor = .secondaryLabel
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byCharWrapping

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitleColor(.systemBlue, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        actionButton.backgroundColor = .systemGray6
        actionButton.layer.cornerRadius = 12
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)

        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, descLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(iconImageView)
        contentView.addSubview(labelsStack)
        contentView.addSubview(actionButton)

        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 56),
            iconImageView.heightAnchor.constraint(equalToConstant: 56),

            labelsStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            labelsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelsStack.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -12),

            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: Self.fixedButtonWidth)
        ])
    }

    func configure(with app: AppInfo) {
        iconImageView.image = app.icon
        nameLabel.text = app.name
        descLabel.text = app.desc
        actionButton.setTitle(app.actionLabel, for: .normal)
    }
}
