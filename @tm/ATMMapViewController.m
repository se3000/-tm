#import "ATMMapViewController.h"
#import "ATMLocationSearchClient.h"
#import "ATMMapAnnotation.h"
#import "LocationViewController.h"

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

    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.navigationItem.title = @"@tm";
    self.navigationItem.leftBarButtonItem = self.refreshButton;
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.view = self.mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {    
    self.lastLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = self.lastLocation.coordinate;
    [[ATMLocationSearchClient jsonClient] getWithCoordinate:coordinate andDelegate:self];
    
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.locationManager stopUpdatingLocation];
    [self.mapView setRegion:newRegion animated:NO];
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

- (void)handleLocationData:(NSArray *)locations {
    for (NSDictionary *locationData in locations) {
        ATMMapAnnotation *annotation = [[ATMMapAnnotation alloc] initWithDictionary:locationData];
        [self.mapView addAnnotation:annotation];
    }
    [self.mapView setNeedsDisplay];
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isMemberOfClass:[ATMMapAnnotation class]])
        return [annotation performSelector:@selector(pinView)];
    return nil;
}

@end
