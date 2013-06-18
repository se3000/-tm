#import "ATMLocation.h"

@implementation ATMLocation

- (id)initWithCLLocation:(CLLocation *)location {
    if (self = [self init]) {
        self.clLocation = location;
    }
    return self;
}

@end
