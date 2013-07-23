#import "ATMLocation.h"
#import "ATMLocationCreateDelegate.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UITableViewController <UITableViewDelegate, ATMLocationCreateDelegate, MKMapViewDelegate>

@property (nonatomic) ATMLocation *location;
@property (nonatomic) BOOL editable;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithATMLocation:(ATMLocation *)location;

@end
