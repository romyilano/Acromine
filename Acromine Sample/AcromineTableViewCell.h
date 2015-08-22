//
//  AcromineTableViewCell.h
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AcroResult;
@interface AcromineTableViewCell : UITableViewCell

@property (strong, nonatomic) AcroResult *acroResult;
@property (weak, nonatomic) IBOutlet UILabel *acromineLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
