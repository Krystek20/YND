//
//  ImageMetadataParser.h
//  ObjcCodeExercise
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIColor;

@interface ImageMetadataParser : NSObject

- (NSArray *)parseImageMetadata:(NSDictionary *)jsonDict;

- (UIColor *)colorFromHexString:(NSString *)hexString;

- (NSUInteger)totalCount:(NSDictionary *)jsonDict;

@end

NS_ASSUME_NONNULL_END
