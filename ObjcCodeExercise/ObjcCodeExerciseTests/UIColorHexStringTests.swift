import XCTest
@testable import ObjcCodeExercise

final class UIColorHexStringTests: XCTestCase {

    func testInitializationColorWithHexStringNotNil() {
        // given
        let hexString = "#F48D09"

        // when
        let color = UIColor(hexString: hexString)

        // then
        XCTAssertNotNil(color)
    }
    
    func testHexColorShouldGetCorrectRGBValues() {
        // given
        let hexString = "#F48D09"
        let color = UIColor(hexString: hexString)
        var red = CGFloat.zero
        var green = CGFloat.zero
        var blue = CGFloat.zero
        var alpha = CGFloat.zero
        
        // when
        
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        // then
        XCTAssertEqual(red, 0.956, accuracy: 3)
        XCTAssertEqual(green, 0.552, accuracy: 3)
        XCTAssertEqual(blue, 0.035, accuracy: 3)
        XCTAssertEqual(alpha, 1.0, accuracy: 3)
    }
}
