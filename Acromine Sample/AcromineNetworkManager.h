#import "AFHTTPSessionManager.h"
#import "Constants.h"

@interface AcromineNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedNetworkManager;

- (instancetype)initWithBaseURL:(NSURL *)url;

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