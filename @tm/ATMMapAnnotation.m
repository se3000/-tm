#import "ATMMapAnnotation.h"

@implementation ATMMapAnnotation

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)cord {
    if (self = [super init]) {
        self.coordinate = cord;
    }
    return self;
}

- (ATMMapAnnotation *)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *coordDictionary = [dictionary valueForKey:@"coordinate"];
    double latitude = [[coordDictionary valueForKey:@"latitude"] doubleValue];
    double longitude = [[coordDictionary valueForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    if (self = [self initWithCoordinate:coordinate]) {
        NSString *fee = [dictionary valueForKey:@"fee"];
        NSString *bankName = [dictionary valueForKey:@"bank_name"];
        
        [self addCallout];
        if (fee)
            self.title = [NSString stringWithFormat:@"$%@", fee];
        if (![bankName length] == 0)
            self.subtitle = [NSString stringWithFormat:@"Bank: %@", bankName];
    }
    return self;
}

- (void)addCallout {
    self.pinView.canShowCallout = YES;
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [detailButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
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

@end
