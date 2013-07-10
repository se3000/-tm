#import "ATMMapAnnotation.h"

@implementation ATMMapAnnotation

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)cord {
    if (self = [super init]) {
        self.coordinate = cord;
        self.pinView = [[MKPinAnnotationView alloc] init];
        self.pinView.animatesDrop = YES;
        self.pinView.annotation = self;
    }
    return self;
}

@end
