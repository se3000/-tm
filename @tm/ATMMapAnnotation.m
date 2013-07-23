#import "ATMMapAnnotation.h"

@implementation ATMMapAnnotation

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [super init]) {
        self.location = [[ATMLocation alloc] initWithCoordinate:coordinate];
    }
    return self;
}

- (ATMMapAnnotation *)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.location = [[ATMLocation alloc] initWithDictionary:dictionary];
    }
    return self;
}

- (void)addCallout {
    self.pinView.canShowCallout = YES;
    
    if (self.fee)
        self.title = [NSString stringWithFormat:@"$%@", self.fee];
    if (![self.bankName length] == 0)
        self.subtitle = [NSString stringWithFormat:@"Bank: %@", self.bankName];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [detailButton addTarget:self
                     action:@selector(displayLocationInfo)
           forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(0, 0, 32, 32);
    detailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    detailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.pinView.rightCalloutAccessoryView = detailButton;
}

- (MKPinAnnotationView *)pinView {
    if (!_pinView) {
        _pinView = [[MKPinAnnotationView alloc] init];
        _pinView.animatesDrop = YES;
        _pinView.annotation = self;
    }
    return _pinView;
}

- (void)displayLocationInfo {
    NSLog(@"mapAnnotation display location info");
    [self.delegate displayLocation:self.location];
}

#pragma mark delegate

- (NSString *)fee {
    return self.location.fee;
}

- (NSString *)bankName {
    return self.location.bankName;
}

- (CLLocationCoordinate2D)coordinate {
    return self.location.coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate {
    self.location.coordinate = coordinate;
}

@end
