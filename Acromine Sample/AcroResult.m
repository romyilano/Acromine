//
//  AcroResult.m
//  RomyIlano_Macys
//
//  Created by Romy on 8/21/15.
//  Copyright (c) 2015 Romy. All rights reserved.
//

#import "AcroResult.h"
#import "AcromineManager.h"

@implementation AcroResult

+ (NSDateFormatter *)dateFormatter {
    return [[AcromineManager shared] acromineDateFormatter];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"longForm" : @"lf",
             @"frequency" : @"freq",
             @"firstAppearanceDate" : @"since",
             @"variations" : @"vars"
             };
}

+ (MTLValueTransformer *)firstAppearanceDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *yearNumber, BOOL *success, NSError *__autoreleasing *error) {
        NSString *dateStringFromNumber = [NSString stringWithFormat:@"%@", yearNumber];
        return [[AcroResult dateFormatter] dateFromString:dateStringFromNumber];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        NSString *dateString = [[AcroResult dateFormatter] stringFromDate:date];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter numberFromString:dateString];
    }];
}

+ (NSValueTransformer *)variationsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[AcroResult class]];
}

- (NSString *)dateString {
    if (!_firstAppearanceDate) {
        return @"";
    } else {
        return [[AcroResult dateFormatter] stringFromDate:self.firstAppearanceDate];
    }
}

@end
