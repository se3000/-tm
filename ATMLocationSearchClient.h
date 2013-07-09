#import "AFHTTPClient.h"
#import <CoreLocation/CoreLocation.h>

@interface ATMLocationSearchClient : AFHTTPClient

+ (ATMLocationSearchClient *)jsonClient;
- (void)getWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
