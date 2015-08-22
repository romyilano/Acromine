#import <UIKit/UIKit.h>

/**
 *  Search view controller 
 *  Note that only cells with more than one variation are selectable
 */
@interface AcroMineSearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentedControlClicked:(UISegmentedControl *)sender;

@end

