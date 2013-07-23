#import <Foundation/Foundation.h>
#import "ATMLocation.h"

@protocol ATMMapAnnotationDelegate <NSObject>

@required

- (void)displayLocation:(ATMLocation *)location;

@end
