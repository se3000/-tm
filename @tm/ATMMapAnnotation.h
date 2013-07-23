#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ATMMapAnnotationDelegate.h"
#import "ATMLocation.h"

@interface ATMMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) ATMLocation *location;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPinAnnotationView *pinView;
@property (nonatomic, readonly) NSString *fee, *bankName;
@property (nonatomic, copy) NSString *title, *subtitle;
@property (nonatomic) id <ATMMapAnnotationDelegate> delegate;

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)cord;
- (ATMMapAnnotation *)initWithDictionary:(NSDictionary *)dictionary;
- (void)addCallout;

@end
