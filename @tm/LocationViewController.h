#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ATMLocation.h"

@interface LocationViewController : UITableViewController

@property (nonatomic) ATMLocation *location;
@property (nonatomic) UITableViewCell *firstCell;

- (id)initWithCLLocation:(CLLocation *)clLocation;

@end
