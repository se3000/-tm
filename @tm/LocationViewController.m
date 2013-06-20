#import "LocationViewController.h"
#import "ATMTableViewCell.h"
#import "ATMMapAnnotation.h"

enum {
    MoneySection,
    LocationSection
};

@interface LocationViewController()

@property (nonatomic) ATMTableViewCell *feeCell, *bankCell;
@property (nonatomic) UITableViewCell *mapCell;

@end

@implementation LocationViewController

- (id)initWithCLLocation:(CLLocation *)clLocation {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.location = [[ATMLocation alloc] initWithCLLocation:clLocation];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.feeCell;
        } else if (indexPath.row == 1) {
            return self.bankCell;
        }
    } else {
        return self.mapCell;
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

- (UITableViewCell *)mapCell {
    if (!_mapCell) {
        _mapCell = [[UITableViewCell alloc] init];
        _mapCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ATMMapAnnotation *annotation = [[ATMMapAnnotation alloc] init];
        annotation.coordinate = self.location.clLocation.coordinate;
        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] init];
        annotationView.annotation = annotation;
        
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        mapView.region = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(self.location.clLocation.coordinate, 0.1, 0.1)];
        
        [mapView addAnnotation:annotation];    
        [_mapCell.contentView addSubview:mapView];
    }
    return _mapCell;
}

- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == LocationSection) {
        return 200;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end
