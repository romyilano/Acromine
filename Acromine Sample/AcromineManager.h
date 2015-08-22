#import <Foundation/Foundation.h>
#import "Constants.h"
@import UIKit;

typedef NS_ENUM(NSUInteger, AcromineManagerSort) {
    AcromineManagerSortFrequency,   // Sorts by frequency, highest to lowest
    AcromineManagerSortDate         // sorts by appearance date, most recent to most distant int he past
};

@class AcromineNetworkManager;

/**
 *  Manager class - network calls etc go through this class
 */
@interface AcroMineManager : NSObject

/**
 *  Acromine Dateformatter - these are expensive use them in the singleton so
 *  we only have to initialize and store them once
 */
@property (strong, nonatomic) NSDateFormatter *acromineDateFormatter;

/**
 *  Acromine Dateformatter - these are expensive use them in the singleton so
 */
@property (strong, nonatomic) AcromineNetworkManager *networkManager;

/**
 *  Singleton class
 */
+ (instancetype)shared;

#pragma mark - Fetch data

/**
 *  Called on to update results in the view controllers with a specific search string
 *   Request type -> only using the short form for now
 *   Results returned in completion block
 */
- (void)updateAcromineResultsWithRequest:(NSString *)acromineString
                     acromineRequestType:(AcromineRequestType)requestType
                      andCompletionBlock:(void(^)(NSArray *results, NSError *error))completionBlock;

#pragma mark - Sort Data

/**
 *  Sorts results by with either sort by first date sighted or by frequency
 *   - by date - Newest first dates sighted are listed first
 *   - frequency - higher frequency to lower freqency
 */
- (NSArray *)sortAcroResultsBy:(NSArray *)acroResultsArray
               bySortingMethod:(AcromineManagerSort)sortingMethod;

@end

extern NSString *AcromineManagerDomain;

typedef NS_ENUM(NSUInteger, AcromineManagerError) {
    AcromineManagerErrorInvalidParameter,
    AcromineManagerErrorBadData
};