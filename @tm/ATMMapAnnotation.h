#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ATMMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPinAnnotationView *pinView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (ATMMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)cord;
- (ATMMapAnnotation *)initWithDictionary:(NSDictionary *)dictionary;

@end
