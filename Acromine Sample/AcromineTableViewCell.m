//
//  AcromineTableViewCell.m
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

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
    // Initialization code
    _acromineLabel.font = [AcromineDesignUtility mainFont];
    _infoLabel.font = [AcromineDesignUtility mainSecondaryFont];
    _infoLabel.numberOfLines = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
