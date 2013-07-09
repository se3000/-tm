#import "ATMLocationCreateClient.h"

@implementation ATMLocationCreateClient

+ (ATMLocationCreateClient *)jsonClient {
    static ATMLocationCreateClient *jsonClient;
    if (!jsonClient) {
        NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
        jsonClient = [super clientWithBaseURL:baseURL];
        jsonClient.parameterEncoding = AFJSONParameterEncoding;
    }
    return jsonClient;
}

- (void)post:(NSDictionary *)params {
    [self postPath:@"/locations" 
        parameters:@{@"location":params}
           success:^(AFHTTPRequestOperation *request, id responseObject) {
               NSLog(@"SUCCESS");
           }
           failure:^(AFHTTPRequestOperation *request, NSError *error) {
               NSLog(@"FAILURE");
           }];
}

@end
