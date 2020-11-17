import Foundation

@objc enum ImageThumbnailType: Int {
    case raw
    case full
    case regular
    case small
    case thumb
}

extension ImageThumbnailType: Comparable {
    static func <(lhs: ImageThumbnailType, rhs: ImageThumbnailType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
