#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ATMMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, readonly) UIBarButtonItem *refreshButton;
@property (nonatomic, readonly) UIBarButtonItem *addButton;
@property (nonatomic, readonly) CLLocation *recentLocation;

@end
