#import "ATMMapViewController.h"

@implementation ATMMapViewController

@synthesize refreshButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

        self.mapView = [[MKMapView alloc] init];
        self.mapView.delegate = self;

        self.navigationItem.leftBarButtonItem = self.refreshButton;
    }
    return self;
}

- (void)viewDidLoad {
    [self.locationManager startUpdatingLocation];

    self.mapView.showsUserLocation = YES;

    self.view = self.mapView;
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

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

- (UIBarButtonItem *)refreshButton {
    if (!refreshButton) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                      target:self
                                                                      action:@selector(updateLocation)];
    }
    return refreshButton;
}

@end
