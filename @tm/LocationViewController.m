#import "LocationViewController.h"

enum {
    FeeSection,
    BankSection,
    LocationSection
};

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.firstCell) {
        self.firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.firstCell.textLabel.text = @"here";
        
    }
    return self.firstCell;
}

@end
