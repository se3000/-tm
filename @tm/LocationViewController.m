#import "LocationViewController.h"
#import "ATMLocationView.h"

@implementation LocationViewController

- (id)initWithCLLocation:(CLLocation *)clLocation {
    if (self = [super init]) {
        self.location = [[ATMLocation alloc] initWithCLLocation:clLocation];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[ATMLocationView alloc] init];
}

@end
