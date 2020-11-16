//
//  NetworkLayer.h
//  ObjcCodeExercise
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkLayer : NSObject

@property(nonatomic, strong) NSURLSession *session;

- (instancetype)initWithAdditionalHeaders:(NSDictionary<NSString *, NSString *> *)additionalHeaders;

- (void)getDataFromURL:(NSURL *)url completion: (void(^)(NSDictionary *))completion;

@end

NS_ASSUME_NONNULL_END
