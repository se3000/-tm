#import "ATMLocation.h"
#import "ATMLocationCreateClient.h"

@implementation ATMLocation

- (id)initWithCLLocation:(CLLocation *)location {
    if (self = [self init]) {
        self.clLocation = location;
    }
    return self;
}

- (NSDictionary *)dictionary {
    NSNumber *feeNumber = [NSNumber numberWithFloat:self.fee];
    NSNumber *latitude = [NSNumber numberWithFloat:self.clLocation.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.clLocation.coordinate.longitude];
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