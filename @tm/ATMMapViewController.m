#import "ATMMapViewController.h"
#import "LocationViewController.h"
#import "ATMLocationSearchClient.h"

@interface ATMMapViewController()

@property (nonatomic) CLLocation *lastLocation;

@end


@implementation ATMMapViewController

@synthesize refreshButton, addButton;

- (id)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

- (void)viewDidLoad {    
    [super viewDidLoad];

    [self.locationManager startUpdatingLocation];

    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.navigationItem.title = @"@tm";
    self.navigationItem.leftBarButtonItem = self.refreshButton;
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.view = self.mapView;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    self.lastLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = self.lastLocation.coordinate;
    [[ATMLocationSearchClient jsonClient] getWithCoordinate:coordinate];
    
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

- (void)createNewRecord {
    LocationViewController *locationViewController = [[LocationViewController alloc] initWithCLLocation:self.lastLocation];
    [self.navigationController pushViewController:locationViewController animated:YES];
}

- (UIBarButtonItem *)refreshButton {
    if (!refreshButton) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:100
                                                                      target:self
                                                                      action:@selector(updateLocation)];
    }
    return refreshButton;
}

- (UIBarButtonItem *)addButton {
    if (!addButton) {
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                  target:self
                                                                  action:@selector(createNewRecord)];
    }
    return addButton;
}

@end
