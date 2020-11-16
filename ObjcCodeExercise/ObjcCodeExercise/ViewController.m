//
//  ViewController.m
//  ObjcCodeExercise
//


#import "ViewController.h"
#import "ImageProvider.h"
#import "ImageMetadata.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)didTapSearchButton:(id)sender {
    NSLog(@"Will perform search for query %@", self.textInput.text);
    
    ImageProvider *imageProvider = [[ImageProvider alloc] init];
    [imageProvider getImageMetadataForQuery:self.textInput.text completion:^(NSArray<ImageMetadata *> * _Nonnull images, NSUInteger totalCount) {
        NSLog(@"We have got %lu images, total count is %lu ", (unsigned long)images.count, (unsigned long)totalCount);
    }];
}

@end
