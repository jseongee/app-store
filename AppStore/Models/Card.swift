import UIKit

struct LargeCard: Hashable {
    let subComment: String
    let mainComment: String
    let appIcon: UIImage
    let appCategory: String?
    let appName: String
    let appDesc: String
}

struct MediumCard: Hashable {
    let appIcon: UIImage
    let appName: String
    let desc: String
}

