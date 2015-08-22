#import <UIKit/UIKit.h>

@class AcroResult;
/**
 *  Customized acromine table view cell class
 */
@interface AcromineTableViewCell : UITableViewCell

@property (strong, nonatomic) AcroResult *acroResult;
@property (weak, nonatomic) IBOutlet UILabel *acromineLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
