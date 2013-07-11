#import "ATMLocation.h"
#import "ATMLocationCreateClient.h"

@implementation ATMLocation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [self init]) {
        self.coordinate = coordinate;
    }
    return self;
}

- (NSDictionary *)dictionary {
    NSNumber *feeNumber = [NSNumber numberWithFloat:self.fee];
    NSNumber *latitude = [NSNumber numberWithFloat:self.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.coordinate.longitude];
    NSString *bankName = self.bank;
    if (!bankName)
        bankName = @"";
    NSDictionary *attributes = @{
             @"fee": feeNumber,
             @"bank_name": bankName,
             @"latitude": latitude,
             @"longitude": longitude};
    return attributes;
}

@end