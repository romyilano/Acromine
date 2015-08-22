#import "AcromineNetworkManager.h"

NSString *AcromineNetworkManagerDomain = @"AcromineNetworkManagerDomain";

@implementation AcromineNetworkManager

+ (instancetype)sharedNetworkManager {
    
    static AcromineNetworkManager *_sharedNetworkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetworkManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAcromineBaseURL]];
    });
    return _sharedNetworkManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)makeRequestToAcromineWithParameterDictionary:(NSDictionary *)parameterDictionary andCompletionBlock:(void (^)(NSArray *, NSError *))completionBlock {
    if (!completionBlock) {
        @throw [NSException exceptionWithName:@"Missing completion block"
                                       reason:@"Please add completion block"
                                     userInfo:nil];
    }
    
    __block NSError *finalError = nil;
    
    if (!parameterDictionary) {
        finalError = [NSError errorWithDomain:AcromineNetworkManagerDomain
                                         code:AcromineNetworkManagerErrorInvalidParameter
                                     userInfo:@{NSLocalizedDescriptionKey : @"Please supply missing acromine string to network manager"}];
        completionBlock(@[], finalError);
    }
    [self GET:@"dictionary.py" parameters:parameterDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        completionBlock(@[], error);
    }];
}

@end
