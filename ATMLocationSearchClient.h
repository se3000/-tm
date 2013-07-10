#import "AFHTTPClient.h"
#import "ATMLocationSearchDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface ATMLocationSearchClient : AFHTTPClient

+ (ATMLocationSearchClient *)jsonClient;
- (void)getWithCoordinate:(CLLocationCoordinate2D)coordinate 
              andDelegate:(id <ATMLocationSearchDelegate>)delegate;

@end
