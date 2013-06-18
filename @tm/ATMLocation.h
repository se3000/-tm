#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ATMLocation : NSObject

@property (nonatomic) CLLocation *clLocation;

- (id)initWithCLLocation:(CLLocation *)location;

@end
