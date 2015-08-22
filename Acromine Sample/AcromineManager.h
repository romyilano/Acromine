#import <Foundation/Foundation.h>
#import "Constants.h"
@import UIKit;

typedef NS_ENUM(NSUInteger, AcromineManagerSort) {
    AcromineManagerSortFrequency,
    AcromineManagerSortDate
};

@class AcromineNetworkManager;
@interface AcromineManager : NSObject

/**
 *  Acromine Dateformatter - these are expensive use them in the singleton so
 *  we only have to initialize and store them once
 */
@property (strong, nonatomic) NSDateFormatter *acromineDateFormatter;

@property (strong, nonatomic) AcromineNetworkManager *networkManager;

+ (instancetype)shared;

#pragma mark - Fetch data

- (void)updateAcromineResultsWithRequest:(NSString *)acromineString
                     acromineRequestType:(AcromineRequestType)requestType
                      andCompletionBlock:(void(^)(NSArray *results, NSError *error))completionBlock;

#pragma mark - Sort Data

- (NSArray *)sortAcroResultsBy:(NSArray *)acroResultsArray
               bySortingMethod:(AcromineManagerSort)sortingMethod;

@end

extern NSString *AcromineManagerDomain;

typedef NS_ENUM(NSUInteger, AcromineManagerError) {
    AcromineManagerErrorInvalidParameter,
    AcromineManagerErrorBadData
};