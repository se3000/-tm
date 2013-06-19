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
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.separator];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (UILabel *)label {
    if (!label) {
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, 89, self.frame.size.height);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"!";
    }
    return label;
}

- (UITextField *)textField {
    if (!textField) {
        textField = [[UITextField alloc] init];
        textField.backgroundColor = [UIColor whiteColor];
        textField.frame = CGRectMake(110, 0, 200, self.frame.size.height);
    }
    return textField;
}

- (UIView *)separator {
    if (!separator) {
        separator = [[UIView alloc] init];

        separator.frame = CGRectMake(109, 0, 0.5, self.frame.size.height);
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = separator.bounds;
        gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.333],
                                                            [NSNumber numberWithFloat:1.0], nil];
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,
                                                         (id)[UIColor lightGrayColor].CGColor, nil];

        [separator.layer addSublayer:gradientLayer];
    }
    return separator;
}

@end
