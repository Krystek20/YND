//
//  ImageProvider.m
//  ObjcCodeExercise
//


#import "ImageProvider.h"
#import "NetworkLayer.h"
#import "ImageMetadataParser.h"
#import "ImageMetadata.h"
#import <UIKit/UIKit.h>

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
        self.parser = [[ImageMetadataParser alloc] init];
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
    }];
}

// TODO: Implement image downloading method. Use available URLSession from NetworkLayer for image downloading. For image caching use existing cache implementation - ImageCache.swift.
/// Parameters:
/// url - url for the image
/// useCache - flag to decide if the image should be fetched from the cache. If flag is YES and image doesn't exist in cache, download the image stored in cache, otherwise just download the image and call completion block.
/// completion - completion block with downloaded image and image url
- (void)getImageFromUrl:(NSURL *)url useCache:(BOOL)useCache completion:(void(^)(UIImage *, NSURL *))completion {

}

@end
