#import "ATMLocationCreateClient.h"

@implementation ATMLocationCreateClient

+ (ATMLocationCreateClient *)jsonClient {
    static ATMLocationCreateClient *jsonClient;
    if (!jsonClient) {
        NSURL *baseURL = [NSURL URLWithString:@"http://atmserver.herokuapp.com"];
        jsonClient = [super clientWithBaseURL:baseURL];
        jsonClient.parameterEncoding = AFJSONParameterEncoding;
    }
    return jsonClient;
}

- (void)post:(NSDictionary *)params withDelegate:(id<ATMLocationCreateDelegate>)delegate {
    [self postPath:@"/locations" 
        parameters:@{@"location":params}
           success:^(AFHTTPRequestOperation *request, id responseObject) {
               NSLog(@"create SUCCESS");
               [delegate locationCreated];
           }
           failure:^(AFHTTPRequestOperation *request, NSError *error) {
               NSLog(@"create FAILURE");
           }];
}

@end
