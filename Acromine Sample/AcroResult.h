#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

/**
 *  Acroresult model class. we use the Mantle framework
 */
@interface AcroResult : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *longForm;
@property (strong, nonatomic) NSNumber *frequency;
@property (strong, nonatomic) NSDate *firstAppearanceDate;
@property (strong, nonatomic) NSArray *variations;

- (NSString *)dateString;

@end
