#import "LocationViewController.h"
#import "ATMTableViewCell.h"
#import "ATMMapAnnotation.h"
#import "ATMLocationCreateClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>

enum {
    MoneySection,
    LocationSection
};

@interface LocationViewController()

@property (nonatomic) ATMTableViewCell *feeCell, *bankCell;
@property (nonatomic) UITableViewCell *mapCell, *saveCell;

@end

@implementation LocationViewController

- (id)initWithCLLocation:(CLLocation *)clLocation {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.location = [[ATMLocation alloc] initWithCoordinate:clLocation.coordinate];
        self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MoneySection) {
        if (indexPath.row == 0) {
            return self.mapCell;
        } else if (indexPath.row == 1) {
            return self.feeCell;
        } else if (indexPath.row == 2) {
            return self.bankCell;
        }
    } else {
        return self.saveCell;
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
        [_mapCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        ATMMapAnnotation *annotation = [[ATMMapAnnotation alloc] initWithCoordinate:self.location.coordinate];
        annotation.pinView.draggable = YES;
        
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        mapView.delegate = self;
        mapView.region = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1, 1)];
        [mapView addAnnotation:annotation];
        
        [_mapCell.contentView addSubview:mapView];
    }
    return _mapCell;
}

- (UITableViewCell *)saveCell {
    if (!_saveCell) {
        _saveCell = [[UITableViewCell alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0.0, 0.0, 320, 44);
        [button setTitle:@"Save" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(saveATMLocation) forControlEvents:UIControlEventTouchUpInside];
        
        [_saveCell addSubview:button];
    }
    return _saveCell;
}

- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 200;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (void)saveATMLocation {
    self.location.fee = [self.feeCell.textField.text floatValue];
    self.location.bank = self.bankCell.textField.text;
    
    [[ATMLocationCreateClient jsonClient] post:[self.location dictionary] 
                                  withDelegate:self];
}

- (void)locationCreated {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mapView:(MKMapView *)mapView 
 annotationView:(MKAnnotationView *)view 
didChangeDragState:(MKAnnotationViewDragState)newState 
   fromOldState:(MKAnnotationViewDragState)oldState {
    if (newState == MKAnnotationViewDragStateEnding)
        self.location.coordinate = view.annotation.coordinate;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(ATMMapAnnotation *)annotation {    
    return annotation.pinView;
}

@end
