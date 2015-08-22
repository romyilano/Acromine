#import "AFHTTPSessionManager.h"
#import "Constants.h"

/**
 *  Network Manager
 */
@interface AcromineNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedNetworkManager;

- (instancetype)initWithBaseURL:(NSURL *)url;

/**
 *  make request to Acromine with the parameter dictionary, which includes the search string, etc.
 */
- (void)makeRequestToAcromineWithParameterDictionary:(NSDictionary *)parameterDictionary
                                  andCompletionBlock:(void (^)(NSArray *responseArray, NSError *error))completionBlock;;

@end

extern NSString *AcromineNetworkManagerDomain;

typedef NS_ENUM(NSUInteger, AcromineNetworkManagerError) {
    AcromineNetworkManagerErrorInvalidJSONError,
    AcromineNetworkManagerErrorInvalidParameter,
    AcromineNetworkManagerErrorNetworkError,
    AcromineNetworkManagerErrorMissingDataError,
    AcromineNetworkManagerErrorBadData
};