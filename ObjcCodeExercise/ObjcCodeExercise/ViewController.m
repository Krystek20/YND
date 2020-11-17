//
//  ViewController.m
//  ObjcCodeExercise
//


#import "ViewController.h"
#import "ImageProvider.h"
#import "ObjcCodeExercise-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation ViewController

- (IBAction)didTapSearchButton:(UIButton *)sender {
    NSLog(@"Will perform search for query %@", self.textInput.text);
    [sender setHidden:YES];
    [self.indicatorView startAnimating];
    [self.indicatorView setHidden:NO];
    
    ImageProvider *imageProvider = [[ImageProvider alloc] init];
    __weak ViewController *weakSelf = self;
    __weak UIButton *weakButton = sender;
    [imageProvider getImageMetadataForQuery:self.textInput.text completion:^(NSArray<ImageMetadata *> * _Nonnull images, NSUInteger totalCount) {
        NSLog(@"We have got %lu images, total count is %lu ", (unsigned long)images.count, (unsigned long)totalCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakButton setHidden:NO];
            [weakSelf.indicatorView stopAnimating];
            [weakSelf performImageCollectionViewControllerWithImages: images andTotalCount: totalCount];
        });
    }];
}

- (void)performImageCollectionViewControllerWithImages: (NSArray<ImageMetadata *> *) images andTotalCount: (NSUInteger) totalCount {
    ImageCollectionViewModel *viewModel = [ImageCollectionViewModel defaultViewModelWithQuery:self.textInput.text totalCount:totalCount images: images];
    [self performSegueWithIdentifier: @"imageCollectionSegue" sender: viewModel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"imageCollectionSegue"]) {
        if ([segue.destinationViewController isKindOfClass: [ImageCollectionViewController class]] && [sender isKindOfClass: [ImageCollectionViewModel class]]) {
            ImageCollectionViewModel *viewModel = (ImageCollectionViewModel *) sender;
            ImageCollectionViewController *controller = (ImageCollectionViewController *) segue.destinationViewController;
            [controller setupViewModel: viewModel];
        }
    }
}

@end
