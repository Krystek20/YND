//
//  ImageMetadata.h
//  ObjcCodeExercise
//


#import <Foundation/Foundation.h>

@class UIColor;

@interface ImageMetadata : NSObject

@property(nonatomic, strong, nonnull) NSString *identifier;
@property(nonatomic, copy, nullable) UIColor *color;
@property(atomic, strong, nonnull) NSString *url;

@end
