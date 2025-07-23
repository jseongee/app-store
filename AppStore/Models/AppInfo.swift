import UIKit

struct AppInfo: Hashable {
    let id = UUID()
    let icon: UIImage
    let name: String
    let desc: String
    let actionLabel: String
}
