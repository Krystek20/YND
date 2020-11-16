//
//  ImageMetadataParser.m
//  ObjcCodeExercise
//

#import "ImageMetadataParser.h"
#import "ImageMetadata.h"
#import <UIKit/UIKit.h>

@implementation ImageMetadataParser

- (NSArray *)parseImageMetadata:(NSDictionary *)jsonDict {
    
    NSArray *results = jsonDict[@"results"];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:results.count];
    
    for (NSDictionary *result in results) {
        
        NSString *identifier = result[@"id"];
        NSString *colorString = result[@"color"];
        NSDictionary *allUrls = result[@"urls"];
        NSString *small = allUrls[@"small"];
        
        ImageMetadata *metadata = [[ImageMetadata alloc] init];
        metadata.identifier = identifier;
        metadata.color = [self colorFromHexString:colorString];
        metadata.url = small;
        [images addObject:metadata];
    }

    return images;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    CGFloat r = ((rgbValue & 0xFF0000) >> 16)/255.0;
    CGFloat g = ((rgbValue & 0xFF00) >> 8)/255.0;
    CGFloat b = (rgbValue & 0xFF)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (NSUInteger)totalCount:(NSDictionary *)jsonDict {
    return [jsonDict[@"total"] integerValue];;
}

@end
