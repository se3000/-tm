#import "AFHTTPClient.h"
#import "ATMLocationCreateDelegate.h"

@interface ATMLocationCreateClient : AFHTTPClient

+ (ATMLocationCreateClient *)jsonClient;

- (void)post:(id)params withDelegate:(id <ATMLocationCreateDelegate>)delegate;

@end
