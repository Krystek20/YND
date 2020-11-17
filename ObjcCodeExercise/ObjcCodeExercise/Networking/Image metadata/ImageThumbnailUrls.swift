import Foundation

final class ImageThumbnailUrls: NSObject, Decodable {
    
    // MARK: - Properties
    
    let full: String
    let raw: String
    let regular: String
    let small: String
    let thumb: String
    
    // MARK: - Initilization
    
    init(full: String, raw: String, regular: String, small: String, thumb:String) {
        self.full = full
        self.raw = raw
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
    
    // MARK: - Public
    
    func path(for type: ImageThumbnailType) -> String {
        switch type {
        case .full: return full
        case .raw: return raw
        case .regular: return regular
        case .small: return small
        case .thumb: return thumb
        }
    }
}

extension ImageThumbnailUrls {
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ImageThumbnailUrls else { return false }
        return full == object.full &&
            raw == object.raw &&
            regular == object.regular &&
            small == object.small &&
            thumb == object.thumb
    }
}
