#import <UIKit/UIKit.h>

@class AcroResult;

/**
 *  Variations view controller - none of the cells are selectable
 */
@interface AcroMineVariationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) AcroResult *acroResult;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentedControlClicked:(UISegmentedControl *)sender;

@end
