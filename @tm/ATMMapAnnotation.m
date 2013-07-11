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

- (ATMMapAnnotation *)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *coordDictionary = [dictionary valueForKey:@"coordinate"];
    double latitude = [[coordDictionary valueForKey:@"latitude"] doubleValue];
    double longitude = [[coordDictionary valueForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    if (self = [self initWithCoordinate:coordinate]) {
        NSString *fee = [dictionary valueForKey:@"fee"];
        NSString *bankName = [dictionary valueForKey:@"bank_name"];

        if (fee)
            self.title = [NSString stringWithFormat:@"$%@", fee];
        if (![bankName length] == 0)
            self.subtitle = [NSString stringWithFormat:@"Bank: %@", bankName];
    }
    return self;
}

@end
