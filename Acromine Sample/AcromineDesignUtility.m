#import "AcromineDesignUtility.h"

@implementation AcromineDesignUtility

+ (UIFont *)mainFont {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.0];
}

+ (UIFont *)mainSecondaryFont {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:15.0];
}

+ (NSDictionary *)mainNavigationBarTitleTextAttributes {
    return @{
             NSFontAttributeName: [AcromineDesignUtility mainFont]
             };
}

+ (NSDictionary *)segmentedControlTitleTextAttributes {
    return @{
             NSFontAttributeName: [AcromineDesignUtility mainSecondaryFont]
             };
}

@end
