#import "ATMMapViewController.h"

@interface ATMMapViewController ()

@end

@implementation ATMMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];

    
        self.mapView = [[MKMapView alloc] init];
        self.mapView.showsUserLocation = YES;
        
        self.view = self.mapView;
    }
    return self;
}

- (void)viewDidLoad {
}

- (void)locationManager:(CLLocationManager *)manager 
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.mapView setRegion:newRegion animated:YES];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error {
    NSLog(@"Failed to update location");
}

@end
