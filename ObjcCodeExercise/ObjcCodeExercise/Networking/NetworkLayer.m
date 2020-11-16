//
//  NetworkLayer.m
//  ObjcCodeExercise
//

#import "NetworkLayer.h"

@implementation NetworkLayer

- (instancetype)initWithAdditionalHeaders:(NSDictionary<NSString *, NSString *> *)additionalHeaders
{
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPAdditionalHeaders = additionalHeaders;
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)getDataFromURL:(NSURL *)url completion: (void(^)(NSDictionary *))completion {
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionTask *task = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *e = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &e];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *)jsonObject;
            NSLog(@"jsonDict - %@",jsonDict);
            completion(jsonDict);
        }
    }];
    [task resume];
}

@end
