//
//  AcroMineVariationsViewController.h
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AcroResult;
@interface AcroMineVariationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) AcroResult *acroResult;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentedControlClicked:(UISegmentedControl *)sender;

@end
