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
@property (nonatomic) UIButton *saveButton;

@end

@implementation LocationViewController

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.location = [[ATMLocation alloc] initWithCoordinate:coordinate];
        self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    return self;
}

- (id)initWithATMLocation:(ATMLocation *)location {
    if (self = [self initWithCoordinate:location.coordinate]) {
        self.location = location;
        self.feeCell.textField.text = location.fee;
        self.bankCell.textField.text = location.bankName;
        
        self.editable = NO;
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
        self.saveButton.frame = CGRectMake(0.0, 0.0, 320, 44);
        [_saveCell addSubview:self.saveButton];
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
    self.location.fee = self.feeCell.textField.text;
    self.location.bankName = self.bankCell.textField.text;
    
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

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_saveButton setTitle:@"Save"
                         forState:UIControlStateNormal];
        [_saveButton setTitle:@"Save"
                         forState:UIControlStateDisabled];
        [_saveButton addTarget:self
                            action:@selector(saveATMLocation)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)setEditable:(BOOL)editable {
    _editable = editable;
    self.feeCell.textField.enabled = editable;
    self.bankCell.textField.enabled = editable;
    self.saveButton.enabled = editable;
    if (editable) {
        self.saveCell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        self.saveCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

@end
