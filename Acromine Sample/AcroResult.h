//
//  AcroResult.h
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface AcroResult : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *longForm;
@property (strong, nonatomic) NSNumber *frequency;
@property (strong, nonatomic) NSDate *firstAppearanceDate;
@property (strong, nonatomic) NSArray *variations;

- (NSString *)dateString;

@end
