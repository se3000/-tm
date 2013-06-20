#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ATMLocation.h"
#import <MapKit/MapKit.h>

@interface LocationViewController : UITableViewController <MKMapViewDelegate, UITableViewDelegate>

@property (nonatomic) ATMLocation *location;

- (id)initWithCLLocation:(CLLocation *)clLocation;

@end
