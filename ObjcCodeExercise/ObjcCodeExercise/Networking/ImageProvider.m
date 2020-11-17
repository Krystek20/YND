//
//  ImageProvider.m
//  ObjcCodeExercise
//


#import "ImageProvider.h"
#import "NetworkLayer.h"
#import <UIKit/UIKit.h>
#import "ObjcCodeExercise-Swift.h"

@interface ImageProvider()

@property(nonatomic, strong) NetworkLayer *networkLayer;
@property(nonatomic, strong) ImageMetadataParser *parser;

@end

@implementation ImageProvider

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkLayer = [[NetworkLayer alloc] initWithAdditionalHeaders:@{@"Authorization": @"Client-ID AsmlG2NU3-l_C-8Z0BTDl-vhIER3pjquBqiGU_l_C5s"}];
        self.parser = [ImageMetadataParser defaultParser];
        self.imageCache = [[ImageCache alloc] init];
    }
    return self;
}

- (void)getImageMetadataForQuery:(NSString *)query completion: (void(^)(NSArray<ImageMetadata *> *, NSUInteger))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.unsplash.com/search/photos/?query=%@&per_page=50", query];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    [self.networkLayer getDataFromURL:url completion:^(NSDictionary * _Nonnull jsonDict) {
        NSArray<ImageMetadata *> *imagesMetadata = [self.parser parseImageMetadata:jsonDict];
        NSUInteger totalCount = [self.parser totalCount:jsonDict];
        if (completion) {
            completion(imagesMetadata, totalCount);
        }
    } error:^(NSError * _Nonnull error) {
        if (completion) {
            completion([NSMutableArray new], 0);
        }
    }];
}

// TODO: Implement image downloading method. Use available URLSession from NetworkLayer for image downloading. For image caching use existing cache implementation - ImageCache.swift.
/// Parameters:
/// url - url for the image
/// useCache - flag to decide if the image should be fetched from the cache. If flag is YES and image doesn't exist in cache, download the image stored in cache, otherwise just download the image and call completion block.
/// completion - completion block with downloaded image and image url
- (void)getImageFromUrl:(NSURL *)url useCache:(BOOL)useCache completion:(void(^)(UIImage *, NSURL *))completion {
    NSString *fileName = [self prepareNameFromUrl:url];
    if (useCache) {
        UIImage *image = [self.imageCache cachedImageFor:fileName];
        if (image) {
            completion(image, url);
            return;
        }
    }
    
    [self.networkLayer getBinaryDataFromURL:url completion:^(NSData * _Nonnull data) {
        UIImage *image = [UIImage imageWithData:data];
        if (useCache) {
            NSError *error;
            [self.imageCache storeImageInCacheWithImage:image imageName:fileName error:&error];
        }
        completion(image, url);
    }];
}

- (NSString *)prepareNameFromUrl:(NSURL *)url {
    NSString *fileName = [@[url.lastPathComponent, url.query] componentsJoinedByString:@""];
    NSData * data = [fileName dataUsingEncoding:NSUTF8StringEncoding];
    return [[data base64EncodedDataWithOptions:kNilOptions] base64EncodedStringWithOptions:kNilOptions];
}

@end
