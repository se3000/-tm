#import "ATMLocation.h"
#import "ATMLocationCreateDelegate.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UITableViewController <UITableViewDelegate, ATMLocationCreateDelegate>

@property (nonatomic) ATMLocation *location;

- (id)initWithCLLocation:(CLLocation *)clLocation;

@end
