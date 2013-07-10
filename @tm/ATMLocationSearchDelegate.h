#import <Foundation/Foundation.h>

@protocol ATMLocationSearchDelegate <NSObject>

@required

- (void)handleLocationData:(NSArray *)locations;

@end
