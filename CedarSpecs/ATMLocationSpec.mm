#import "ATMLocation.h"
#import <CoreLocation/CoreLocation.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ATMLocationSpec)

describe(@"ATMLocation", ^{
    describe(@"#initWithCoordinate", ^{
        it(@"it adds the coordinate to the new instance", ^{
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(101.0, 10.1);
            
            ATMLocation *location = [[ATMLocation alloc] initWithCoordinate:coordinate];
            
            location.coordinate.latitude should equal(coordinate.latitude);
            location.coordinate.longitude should equal(coordinate.longitude);
        });
    });
    
    describe(@"#initWithDictionary", ^{
        it(@"it adds the coordinate to the new instance", ^{
            NSNumber *latitude = [NSNumber numberWithFloat:101.0];
            NSNumber *longitude = [NSNumber numberWithFloat:10.1];
            NSDictionary *dictionary = @{@"coordinate": @{@"latitude": latitude,
                                                    @"longitude": longitude}};
            
            ATMLocation *location = [[ATMLocation alloc] initWithDictionary:dictionary];
            
            location.coordinate.latitude should equal(latitude);
            location.coordinate.longitude should equal(longitude);
        });
        
        it(@"handles null fee values", ^{
            NSDictionary *dictionary = @{@"fee": [NSNull null]};
            
            ATMLocation *location = [[ATMLocation alloc] initWithDictionary:dictionary];
            
            (location.fee == nil) should be_truthy;
        });
        
        it(@"handles null bank name values", ^{
            NSDictionary *dictionary = @{@"bank_name": [NSNull null]};
            
            ATMLocation *location = [[ATMLocation alloc] initWithDictionary:dictionary];
            
            (location.bankName == nil) should be_truthy;
        });
        
        it(@"properly stubs methods", ^{
            ATMLocation *location = [[ATMLocation alloc] initWithDictionary:@{}];
            
            spy_on(location);
            
            [location description];
            
            location should have_received("description");
        });
    });
});

SPEC_END
