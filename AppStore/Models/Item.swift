import Foundation

enum Item: Hashable {
    case largeCard(LargeCard)
    case mediumCard(MediumCard)
    case app(AppInfo)
}
