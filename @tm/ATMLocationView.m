#import "ATMLocationView.h"

@implementation ATMLocationView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame style:UITableViewStyleGrouped]) {
//        [self addSubview:self.feeField];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    } else {
        return [[UITableViewCell alloc] init];
    }
}

- (UITextField *)feeField {
    if (!feeField) {
        feeField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
        feeField.borderStyle = UITextBorderStyleBezel;
    }
    return feeField;
}

@end
