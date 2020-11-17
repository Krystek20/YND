import Foundation

struct ImageMetadataContainer: Decodable {
    let results: [ImageMetadata]
    let total: UInt
}
