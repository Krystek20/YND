import XCTest
@testable import ObjcCodeExercise

final class ImageMetadataParserTests: XCTestCase {

    private var sut: ImageMetadataParsing!
    
    override func setUp() {
        super.setUp()
        sut = ImageMetadataParser()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testImageMetadataParserReturnsEmptyArray() {
        // when
        let array = sut.parseImageMetadata([:])

        // then
        XCTAssertTrue(array.isEmpty)
    }

    func testImageMetadataParserReturnsFirstImageMetaData() {
        // given
        let jsonDict = TestDataProvider.imageMetadataJson
        let expectedData = ImageMetadata(
            identifier: "ieic5Tq8YMk",
            hexString: "#F48D09",
            urls: ImageThumbnailUrls(
                full: "https://fullFakeUrl.com/1",
                raw: "https://rawFakeUrl.com/1",
                regular: "https://regularFakeUrl.com/1",
                small: "https://smallFakeUrl.com/1",
                thumb: "https://thumbFakeUrl.com/1"
            )
        )

        // when
        let array = sut.parseImageMetadata(jsonDict)

        // then
        XCTAssertEqual(array[0], expectedData)
    }
    
    func testImageMetadataParserReturnsTotalCountForTwoObjects() {
        // given
        let jsonDict = TestDataProvider.imageMetadataJson

        // when
        let totalCount = sut.totalCount(jsonDict)

        // then
        XCTAssertEqual(totalCount, 2)
    }
    
    func testImageMetadataParserReturnsTotalCountForEmptyArray() {
        // when
        let totalCount = sut.totalCount([:])

        // then
        XCTAssertEqual(totalCount, .zero)
    }

    func testImageMetadataParserReturnsColorForHexStringNotNil() {
        // when
        let color = sut.colorFromHexString(hexString: "#F48D09")

        // then
        XCTAssertNotNil(color)
    }
}
