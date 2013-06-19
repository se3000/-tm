#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ATMLocation.h"

@interface LocationViewController : UITableViewController

@property (nonatomic) ATMLocation *location;

- (id)initWithCLLocation:(CLLocation *)clLocation;

@end
