//
//  ApiUtil.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ApiUtil.h"
#import "SOCKit.h"
#import "AFURLRequestSerialization.h"


NSString *const ECAPIBaseURL  = @"https://api-news.layervault.com";
NSString *const ECAPIStories  = @"/api/v1/stories?client_id=750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d";
NSString *const ECAPIComments = @"/api/v1/comments/:id";
NSString *const ECAPILogin    = @"/oauth/token";

#pragma mark -

// below interface and implementation for NSURL is from snippet
@interface NSURL (ApiUtil)

+ (NSURL *)DNURLWithString:(NSString *)string;

@end

@implementation NSURL (ApiUtil)

+ (NSURL *)DNURLWithString:(NSString *)string {
    return [[self class] URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], string]];
}

+ (NSString *)baseURL {
    NSString *baseURLConfiguration = [[[NSProcessInfo processInfo] environment] objectForKey:@"baseURL"];
    
    return baseURLConfiguration ?: HOST;
}

@end

// below NSURLRequest implementation are partially from snippet
@implementation NSURLRequest (ApiUtil)


// below are implemented by Xiaolei
+ (NSMutableURLRequest *) buildGetUserRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_USER :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod: HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreateUserRequest:(User *) user {
    NSString *url = CREATE_USER;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[user toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildGetPostRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_POST_BY_USER_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreatePostRequest:(Post *) post {
    NSString *url = CREATE_POST;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString: url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[post toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildDeletePostRequest:(NSString *) id {
    NSString *url = [self buildUrlString:DELETE_POST_BY_POST_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetPostByUserRequest:(NSString *) userId {
    NSString *url = [self buildUrlString:GET_POST_BY_USER_ID :userId];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetPostBySearchRequest:(double) latitude :(double) longitude :(NSInteger) maxDistance {
    // TODO
    return nil;
}

+ (NSMutableURLRequest *) buildCreateCommentToPostRequest:(NSString *) postId :(Comment *) comment {
    NSString *url = [self buildUrlString:CREATE_COMMENT_TO_POST :postId];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_POST];
        [request setValuesForKeysWithDictionary:[comment toDictionary]];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_EVENT_BY_EVENT_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreateEventRequest:(Event *) event {
    NSString *url = CREATE_EVENT;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[event toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildCreateUpdateEventRequest:(Event *) event {
    NSString *url = UPDATE_EVENT;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_PATCH];
    [request setValuesForKeysWithDictionary:[event toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildDeleteEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:DELETE_EVENT :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_DELETE];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetMessageByEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_MESSAGE_BY_EVENT_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetNotificationRequest {
    NSString *url = GET_NOTIFICATION;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_GET];
    return request;
}

+ (NSMutableURLRequest *) buildReadNotificationByIdRequest:(NSString *) id {
    NSString *url = [self buildUrlString:READ_NOTIFICATION_BY_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_PATCH];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildReadNotificationRequest {
    NSString *url = READ_NOTIFICATION;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_PATCH];
    return request;
}

+ (NSString *) buildUrlString:(NSString *) format :(NSString *) param {
    if (format) {
        return [HOST stringByAppendingString: [NSString stringWithFormat:format, param]];
    }
    return nil;
}


// Xiaolei's implementation ends here

// Added by Lyman
+ (NSMutableURLRequest *) buildGetSessionRequest:(NSString *)parameters {
    NSString *url = [self buildUrlString:SESSION :parameters];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod: HTTP_GET];
        return request;
    }
    return nil;
}



// Below are from snippet

+ (NSURLRequest *)requestWithPattern:(NSString *)string object:(id)object {
    SOCPattern *pattern = [SOCPattern patternWithString:string];
    NSString *urlString = [pattern stringFromObject:object];
    NSURLRequest *request = [self requestWithURL:[NSURL DNURLWithString:urlString]];
    return request;
}

+ (NSURLRequest *)postRequest:(NSString *)string parameters:(NSDictionary *)parameters {
    return [NSURLRequest requestWithMethod:@"POST"
                                       url:string
                                parameters:parameters];
}

+ (NSURLRequest *)getRequest:(NSString *)string parameters:(NSDictionary *)parameters {
    return [NSURLRequest requestWithMethod:@"GET"
                                       url:string
                                parameters:parameters];
}

+ (NSURLRequest *)deleteRequest:(NSString *)string parameters:(NSDictionary *)parameters {
    return [NSURLRequest requestWithMethod:@"DELETE"
                                       url:string
                                parameters:parameters];
}

+ (NSURLRequest *)requestWithMethod:(NSString *)method
                                url:(NSString *)url
                         parameters:(NSDictionary *)parameters {
    
    SOCPattern *pattern = [SOCPattern patternWithString:url];
    NSString *urlString = [pattern stringFromObject:parameters];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]
                                    requestWithMethod:method
                                    URLString:[NSString stringWithFormat:@"%@%@", [NSURL baseURL], urlString]
                                    parameters:parameters];
    return request;
}


@end


@implementation ApiUtil

+ (void)saveCookiesWithId:(NSString *)mId{
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults setObject:mId forKey:@"mId"];
    
    [defaults synchronize];
    
}


+ (NSString *)loadCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    // return the user id
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mId"];
}

+ (NSString *)convertTimeStampWithUTCString: (NSString *)utcString {
    // TODO: add more comprehensive methods for displaying time
    
    return [utcString substringToIndex:[utcString length]-3];
}

+ (NSDate *)dateFromISO8601String:(NSString *)dateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    
    return [formatter dateFromString:dateString];
}

+ (NSString *)ISO8601StringFromDate: (NSDate *)date {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    [dateFomatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    return [dateFomatter stringFromDate:date];
}

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (NSString *)detectUrlInString:(NSString *)source{
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:source options:0 range:NSMakeRange(0, [source length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSString *url = [[match URL] absoluteString];
            return url;
        }
    }
    return nil;
}

+(NSDateFormatter *)getDateFormatter{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM'-'dd'-'yyyy"];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    return dateFormat;
}
+(NSDateFormatter *)setDateFormatter:(NSString *)dateFormatString{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM'-'dd'-'yyyy"];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    return dateFormat;
}

+ (NSString *) generateTimestamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    
    NSDate *now = [NSDate date];
    NSString *currentTimestamp = [dateFormatter stringFromDate:now];
    return currentTimestamp;
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}
@end
