import UIKit

let todayItems: [Item] = [
    .card(Card(title: "카드 1")),
    .card(Card(title: "카드 2")),
]

let recommendItems: [Item] = [
    .app(
        AppInfo(
            icon: UIImage(systemName: "app")!,
            name: "지그재그 - ZIGZAG",
            desc: "제가 알아서 살게요",
            actionLabel: "받기"
        )
    ),
    .app(
        AppInfo(
            icon: UIImage(systemName: "app")!,
            name: "밴드-모임이 쉬워진다!",
            desc: "소모임, 챌린지, 스터디, 취미모임",
            actionLabel: "열기"
        )
    ),
    .app(
        AppInfo(
            icon: UIImage(systemName: "app")!,
            name: "Youtube Music",
            desc: "오직 나만을 위한 음악의 세계",
            actionLabel: "열기"
        )
    ),
    .app(
        AppInfo(
            icon: UIImage(
                systemName: "app"
            )!,
            name: "Youtube",
            desc: "동영상과 음악을 즐기고 공유하세요",
            actionLabel: "열기"
        )
    ),
    .app(
        AppInfo(
            icon: UIImage(systemName: "app")!,
            name: "카카오톡",
            desc: "모든 연결의 시작",
            actionLabel: "업데이트"
        )
    ),
]
