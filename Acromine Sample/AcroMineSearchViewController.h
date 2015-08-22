//
//  ViewController.h
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcroMineSearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentedControlClicked:(UISegmentedControl *)sender;

@end

