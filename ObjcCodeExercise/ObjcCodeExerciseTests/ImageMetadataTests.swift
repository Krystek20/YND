import XCTest
@testable import ObjcCodeExercise

final class ImageMetadataTests: XCTestCase {

    func testImageMetadataParserReturnsTrueForIsFullGreaterThanSmall() {
        // when
        let result = ImageMetadata.isGreater(firstType: .full, than: .small)

        // then
        XCTAssertTrue(result)
    }
    
    func testImageMetadataParserReturnsFalseForIsFullGreaterThanSmall() {
        // when
        let result = ImageMetadata.isGreater(firstType: .thumb, than: .raw)

        // then
        XCTAssertFalse(result)
    }
}
