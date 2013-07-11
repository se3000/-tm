#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface ATMLocation : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *bank;
@property (nonatomic) float fee;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (NSDictionary *)dictionary;

@end
