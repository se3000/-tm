#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ATMLocationSearchDelegate.h"

@interface ATMMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, ATMLocationSearchDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, readonly) UIBarButtonItem *refreshButton;
@property (nonatomic, readonly) UIBarButtonItem *addButton;

@end
