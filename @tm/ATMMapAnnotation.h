#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ATMMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPinAnnotationView *pinView;

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)cord;

@end
