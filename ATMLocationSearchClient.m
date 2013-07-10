#import "ATMLocationSearchClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>

@implementation ATMLocationSearchClient

+ (ATMLocationSearchClient *)jsonClient {
    static ATMLocationSearchClient *jsonClient;
    if (!jsonClient) {
        NSURL *baseURL = [NSURL URLWithString:@"http://atmserver.herokuapp.com"];
        jsonClient = [super clientWithBaseURL:baseURL];
        [jsonClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return jsonClient;
}

- (void)getWithCoordinate:(CLLocationCoordinate2D)coordinate 
              andDelegate:(id <ATMLocationSearchDelegate>)delegate {
    NSDictionary *params = @{@"latitude": [NSNumber numberWithFloat:coordinate.latitude],
                             @"longitude": [NSNumber numberWithFloat:coordinate.longitude]};
    [self getPath:@"/locations/search.json"
       parameters:params 
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *locationData = [responseObject valueForKey:@"locations"];
              NSLog(@"SUCCESS: %@", locationData);
              [delegate handleLocationData:locationData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"FAILIURE: %@", error);
          }];
}

@end