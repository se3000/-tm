#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface ATMLocation : NSObject

@property (nonatomic) CLLocation *clLocation;
@property (nonatomic) NSString *bank;
@property (nonatomic) float fee;

- (id)initWithCLLocation:(CLLocation *)location;
- (void)save;
- (NSDictionary *)dictionary;

@end
