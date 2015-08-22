#import "AcromineManager.h"
#import "AcromineNetworkManager.h"
#import "AcroResult.h"
#import <Mantle/Mantle.h>

NSString *AcromineManagerDomain = @"AcromineManagerDomain";

@implementation AcromineManager

+ (instancetype)shared {
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] initPrivate];
    });
    return _shared;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        _networkManager = [AcromineNetworkManager sharedNetworkManager];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"This is a singleton, use +[AcromineController sharedController] instead"
                                 userInfo:nil];
}

#pragma mark - Accessors 

- (NSDateFormatter *)acromineDateFormatter {
    if (!_acromineDateFormatter) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        _acromineDateFormatter = dateFormatter;
    }
    return _acromineDateFormatter;
}

#pragma mark - Fetch data

- (void)updateAcromineResultsWithRequest:(NSString *)acromineString
                     acromineRequestType:(AcromineRequestType)requestType
                      andCompletionBlock:(void (^)(NSArray *, NSError *))completionBlock {
    
    if (!completionBlock) {
        @throw [NSException exceptionWithName:@"Missing completion block"
                                       reason:@"Please add completion block"
                                     userInfo:nil];
    }
    
    __block NSError *finalError = nil;
    
    if (!acromineString) {
        finalError = [NSError errorWithDomain:AcromineNetworkManagerDomain
                                         code:AcromineNetworkManagerErrorInvalidParameter
                                     userInfo:@{NSLocalizedDescriptionKey : @"Please supply missing acromine string to network manager"}];
        completionBlock(@[], finalError);
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    switch (requestType) {
        case AcromineRequestTypeShortForm:
            parameters[@"sf"] = acromineString;
            break;
        case AcromineRequestTypeLongForm:
            parameters[@"lf"] = acromineString;
        default:
            parameters[@"sf"] = acromineString;
            break;
    }
    
    [_networkManager makeRequestToAcromineWithParameterDictionary:parameters
                                               andCompletionBlock:^(NSArray *responseArray, NSError *error) {
        if (error) {
            
            completionBlock(@[], error);
        } else if (responseArray.count == 0) {
            finalError = [NSError errorWithDomain:AcromineManagerDomain code:AcromineNetworkManagerErrorMissingDataError userInfo:@{NSLocalizedDescriptionKey: @"No search results returned"}];
            completionBlock(@[], error);
        }
        else if (responseArray.count > 0) {
            NSDictionary *resultsDict = responseArray[0];
            NSArray *rawResultsArray = resultsDict[@"lfs"];
            
            NSMutableArray *workingArray = [[NSMutableArray alloc] initWithCapacity:rawResultsArray.count];
            
            for (NSDictionary *rawAcroResultObj in rawResultsArray) {
                 [workingArray addObject:[MTLJSONAdapter modelOfClass:[AcroResult class] fromJSONDictionary:rawAcroResultObj    error:&finalError]];
            }
            
            if (finalError) {
                completionBlock([workingArray copy], finalError);
            } else {
                completionBlock([workingArray copy], nil);
            }
        }
    }];
}

#pragma mark - Sorting Method

- (NSArray *)sortAcroResultsBy:(NSArray *)acroResultsArray bySortingMethod:(AcromineManagerSort)sortingMethod {
    
    NSArray *finalArray = nil;
    
    if (sortingMethod == AcromineManagerSortFrequency) {
        finalArray = [acroResultsArray sortedArrayUsingComparator:^NSComparisonResult(AcroResult *obj1, AcroResult* obj2) {
            NSNumber *frequencyOne = obj1.frequency;
            NSNumber *frequencyTwo = obj2.frequency;
            return [frequencyTwo compare:frequencyOne];
        }];
    } else if (sortingMethod == AcromineManagerSortDate) {
        finalArray = [acroResultsArray sortedArrayUsingComparator:^NSComparisonResult(AcroResult *obj1,AcroResult *obj2) {
            NSDate *dateOne = obj1.firstAppearanceDate;
            NSDate *dateTwo = obj2.firstAppearanceDate;
            return [dateTwo compare:dateOne];
        }];
    }
    return finalArray;
}

@end
