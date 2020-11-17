import Foundation
import UIKit.UIColor

final class ImageMetadata: NSObject, Decodable {
    
    // MARK: - Properties

    let identifier: String
    let color: UIColor?
    let urls: ImageThumbnailUrls

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case id, color, urls
    }

    // MARK: - Initialization

    init(identifier: String, hexString: String?, urls: ImageThumbnailUrls) {
        self.identifier = identifier
        self.color = UIColor(hexString: hexString)
        self.urls = urls
    }

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .id)
        let hexString = try container.decodeIfPresent(String.self, forKey: .color)
        let urls = try container.decode(ImageThumbnailUrls.self, forKey: .urls)
        self.init(identifier: identifier, hexString: hexString, urls: urls)
    }
}

extension ImageMetadata {
    static func isGreater(firstType: ImageThumbnailType, than secondType: ImageThumbnailType) -> Bool {
        firstType < secondType
    }
}

extension ImageMetadata {
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ImageMetadata else { return false }
        return identifier == object.identifier &&
            color == object.color &&
            urls == object.urls
    }
}
