#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface ATMLocation : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *bankName;
@property (nonatomic) NSString *fee;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionary;

@end
