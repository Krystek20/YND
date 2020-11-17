import Foundation
import UIKit.UIColor

protocol ImageMetadataParsing {
    func parseImageMetadata(_ jsonDict: [String: Any]) -> [ImageMetadata]
    func totalCount(_ jsonDict: [String: Any]) -> UInt
    func colorFromHexString(hexString: String) -> UIColor?
}

final class ImageMetadataParser: NSObject, ImageMetadataParsing {

    // MARK: - Properties

    private let jsonDecoder: JSONDecoder
    private let jsonSerializationType: JSONSerialization.Type
    
    // MARK: - Initialization

    init(jsonDecoder: JSONDecoder = JSONDecoder(),
         jsonSerializationType: JSONSerialization.Type = JSONSerialization.self) {
        self.jsonDecoder = jsonDecoder
        self.jsonSerializationType = jsonSerializationType
    }

    // MARK: - Public

    @objc func parseImageMetadata(_ jsonDict: [String: Any]) -> [ImageMetadata] {
        do {
            return try prepareImageMetadataContainer(from: jsonDict).results
        } catch {
            return []
        }
    }

    @objc func totalCount(_ jsonDict: [String: Any]) -> UInt {
        do {
            return UInt(try prepareImageMetadataContainer(from: jsonDict).results.count)
        } catch {
            return .zero
        }
    }

    @objc func colorFromHexString(hexString: String) -> UIColor? {
        UIColor(hexString: hexString)
    }

    // MARK: - Private

    private func prepareImageMetadataContainer(from dictionary: [String: Any]) throws -> ImageMetadataContainer {
        let data = try convertData(from: dictionary)
        return try jsonDecoder.decode(ImageMetadataContainer.self, from: data)
    }

    private func convertData(from dictionary: [String: Any]) throws -> Data {
        try jsonSerializationType.data(withJSONObject: dictionary)
    }
}

extension ImageMetadataParser {
    @objc static func defaultParser() -> ImageMetadataParser {
        ImageMetadataParser()
    }
}
