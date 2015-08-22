#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - URLs

extern NSString *const kAcromineBaseURL;
extern NSString *const kSegueResult;

@end

typedef NS_ENUM(NSUInteger, AcromineRequestType) {
    AcromineRequestTypeShortForm,
    AcromineRequestTypeLongForm
};
