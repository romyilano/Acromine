#import "AcromineTableViewCell.h"
#import "AcromineDesignUtility.h"
#import "AcroResult.h"

@implementation AcromineTableViewCell

#pragma mark - Accessor

- (void)setAcroResult:(AcroResult *)acroResult {
    if (![_acroResult isEqual:acroResult]) {
        _acroResult = acroResult;
        _acromineLabel.text = acroResult.longForm;
        _infoLabel.text = [NSString stringWithFormat:@"Frequency: %@ appearing since: %@\n%lu variations", _acroResult.frequency, [_acroResult dateString], (unsigned long)[[_acroResult variations] count]];
    }
}

#pragma mark - View LifeCycle

- (void)awakeFromNib {

    _acromineLabel.font = [AcromineDesignUtility mainFont];
    _infoLabel.font = [AcromineDesignUtility mainSecondaryFont];
    _infoLabel.numberOfLines = 2;
}

@end
