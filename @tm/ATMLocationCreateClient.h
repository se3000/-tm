#import "AFHTTPClient.h"

@interface ATMLocationCreateClient : AFHTTPClient

+ (ATMLocationCreateClient *)jsonClient;

- (void)post:(id)params;

@end
