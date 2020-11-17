//
//  ImageProvider.h
//  ObjcCodeExercise
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ImageMetadata, UIImage, ImageCache;

@interface ImageProvider : NSObject

@property(nonatomic, strong) ImageCache *imageCache;

- (void)getImageMetadataForQuery:(NSString *)query completion: (void(^)(NSArray<ImageMetadata *> *, NSUInteger))completion;
- (void)getImageFromUrl:(NSURL *)url useCache:(BOOL)useCache completion:(void(^)(UIImage *, NSURL *))completion;

@end

NS_ASSUME_NONNULL_END
