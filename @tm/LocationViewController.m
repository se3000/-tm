#import "LocationViewController.h"
#import "ATMTableViewCell.h"

enum {
    MoneySection,
    LocationSection
};

@interface LocationViewController()

@property (nonatomic) ATMTableViewCell *feeCell, *bankCell;

@end

@implementation LocationViewController

- (id)initWithCLLocation:(CLLocation *)clLocation {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.location = [[ATMLocation alloc] initWithCLLocation:clLocation];
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSLog(@"1");
        return self.feeCell;
    } else if (indexPath.row == 1) {
        NSLog(@"2");
        return self.bankCell;
    }
    return nil;
}

- (ATMTableViewCell *)feeCell {
    if (!_feeCell) {
        _feeCell = [[ATMTableViewCell alloc] init];
        _feeCell.label.text = @"Fee";
    }
    return _feeCell;
}

- (ATMTableViewCell *)bankCell {
    if (!_bankCell) {
        _bankCell = [[ATMTableViewCell alloc] init];
        _bankCell.label.text = @"Bank";
    }
    return _bankCell;
}

@end
