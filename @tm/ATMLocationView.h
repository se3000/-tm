#import <UIKit/UIKit.h>
#import "ATMLocation.h"

@interface ATMLocationView : UITableView
{
    UITextField *feeField;
}

@property (nonatomic) ATMLocation *location;

@end
