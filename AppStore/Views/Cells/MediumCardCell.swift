import UIKit

final class MediumCardCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MediumCardCell"

    private let appIconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let badge: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("광고", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        button.isUserInteractionEnabled = false // 버튼처럼 보이지만 동작은 라벨
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.backgroundColor = .systemGray6
        btn.layer.cornerRadius = 14
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setContentHuggingPriority(.required, for: .horizontal)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.backgroundColor = UIColor(red: 180/255, green: 105/255, blue: 43/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        let textStack = UIStackView(arrangedSubviews: [appNameLabel, {
            let hStack = UIStackView(arrangedSubviews: [badge, descLabel])
            hStack.axis = .horizontal
            hStack.spacing = 6
            return hStack
        }()])
        textStack.axis = .vertical
        textStack.spacing = 6
        textStack.translatesAutoresizingMaskIntoConstraints = false

        let bottomStack = UIStackView(arrangedSubviews: [textStack, actionButton])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 12
        bottomStack.alignment = .center
        bottomStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(appIconView)
        contentView.addSubview(bottomStack)

        NSLayoutConstraint.activate([
            appIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            appIconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            appIconView.widthAnchor.constraint(equalToConstant: 64),
            appIconView.heightAnchor.constraint(equalToConstant: 64),

            bottomStack.topAnchor.constraint(equalTo: appIconView.bottomAnchor, constant: 16),
            bottomStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    func configure(with card: MediumCard) {
        appIconView.image = card.appIcon
        appNameLabel.text = card.appName
        descLabel.text = card.desc
    }
}
