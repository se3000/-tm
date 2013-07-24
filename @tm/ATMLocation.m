#import "ATMLocation.h"
#import "ATMLocationCreateClient.h"

@implementation ATMLocation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [self init]) {
        self.coordinate = coordinate;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *coordDictionary = [dictionary valueForKey:@"coordinate"];
    double latitude = [[coordDictionary valueForKey:@"latitude"] doubleValue];
    double longitude = [[coordDictionary valueForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    if (self = [self initWithCoordinate:coordinate]) {
        if (![[dictionary valueForKey:@"fee"] isKindOfClass:[NSNull class]])
            self.fee = [[dictionary valueForKey:@"fee"] stringValue];
        if (![[dictionary valueForKey:@"bank_name"] isKindOfClass:[NSNull class]])
            self.bankName = [dictionary valueForKey:@"bank_name"];
    }
    return self;
}

- (NSDictionary *)dictionary {
    NSNumber *latitude = [NSNumber numberWithFloat:self.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.coordinate.longitude];
    NSString *bankName = self.bankName;
    if (!bankName)
        bankName = @"";
    NSDictionary *attributes = @{
             @"fee": self.fee,
             @"bank_name": bankName,
             @"latitude": latitude,
             @"longitude": longitude};
    return attributes;
}

@end