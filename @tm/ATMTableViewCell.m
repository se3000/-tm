#import "ATMTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ATMTableViewCell()
{
    UILabel *label;
    UIView *separator;
    UITextField *textField;
}

@end

@implementation ATMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.separator];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (UILabel *)label {
    if (!label) {
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, 89, [self cellHeight]);
        label.backgroundColor = [UIColor whiteColor];
    }
    return label;
}

- (UITextField *)textField {
    if (!textField) {
        textField = [[UITextField alloc] init];
        textField.backgroundColor = [UIColor whiteColor];
        textField.frame = CGRectMake(120, 0, 200, [self cellHeight]);
    }
    return textField;
}

- (UIView *)separator {
    if (!separator) {
        separator = [[UIView alloc] init];

        separator.frame = CGRectMake(109, 0, 0.5, [self cellHeight]);
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = separator.bounds;
        gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.1],
                                                            [NSNumber numberWithFloat:1.0], nil];
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,
                                                         (id)[UIColor lightGrayColor].CGColor, nil];

        [separator.layer addSublayer:gradientLayer];
    }
    return separator;
}

- (int)cellHeight {
    return self.frame.size.height;
}

@end
