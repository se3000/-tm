#import "ATMMapViewController.h"
#import "ATMLocationSearchClient.h"
#import "ATMMapAnnotation.h"
#import "LocationViewController.h"

@interface ATMMapViewController()

@property (nonatomic) CLLocation *lastLocation;
@property (nonatomic) NSMutableArray *pinAnnotations;

@end


@implementation ATMMapViewController

@synthesize refreshButton, addButton;

- (id)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.pinAnnotations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {    
    [super viewDidLoad];

    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.navigationItem.title = @"@tm";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:100
                                                                                          target:self
                                                                                          action:@selector(updateLocationData)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(createNewRecord)];
    self.view = self.mapView;
}

- (void)updateLocationData {
    [self.mapView removeAnnotations:self.pinAnnotations];
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateLocationData];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    
    self.lastLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = self.lastLocation.coordinate;
    [[ATMLocationSearchClient jsonClient] getWithCoordinate:coordinate 
                                                andDelegate:self];
    
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.locationManager stopUpdatingLocation];
    [self.mapView setRegion:newRegion 
                   animated:NO];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Failed to update location");
}

- (void)createNewRecord {
    LocationViewController *locationViewController = [[LocationViewController alloc] initWithCoordinate:self.lastLocation.coordinate];
    [self.navigationController pushViewController:locationViewController
                                         animated:YES];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isMemberOfClass:[ATMMapAnnotation class]])
        return [annotation performSelector:@selector(pinView)];
    return nil;
}

#pragma mark ATMMapAnnotationDelegate

- (void)displayLocation:(ATMLocation *)location {
    NSLog(@"mapViewController display location info");
    LocationViewController *locationViewController = [[LocationViewController alloc] initWithATMLocation:location];
    [self.navigationController pushViewController:locationViewController
                                         animated:YES];
}

#pragma mark ATMLocationSearchDelegate

- (void)handleLocationData:(NSArray *)locations {
    for (NSDictionary *locationData in locations) {
        [self addAnnotation:[[ATMMapAnnotation alloc] initWithDictionary:locationData]];
    }
}

#pragma mark private

- (void)addAnnotation:(ATMMapAnnotation *)annotation {
    annotation.delegate = self;
    [annotation addCallout];
    [self.pinAnnotations addObject:annotation];
    [self.mapView addAnnotation:annotation];
}
    
@end
