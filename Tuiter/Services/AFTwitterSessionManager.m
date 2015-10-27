//
//  AFTwitterSession.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "AFTwitterSessionManager.h"
#import "AFNetworking.h"

#define API_URL @"https://api.twitter.com"
#define API_CREDENTIAL @"u6FZORyUZrAgW40nzFlsw:LPgSsYusIxGOsarD3YtYGl7VFO8gdzb4lEzJyYX3aNo"

@implementation AFTwitterSessionManager

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:API_URL]];
    if(self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}


-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    
    if (self.bearerToken) {
        return [super POST:URLString parameters:parameters success:success failure:failure];
    } else {
        return [self requestBearerToken:^(NSURLSessionDataTask * task, id responseObject) {
            [super POST:URLString parameters:parameters success:success failure:failure];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            failure(task, error);
        }];
    }
    
}

-(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    
    if (self.bearerToken) {
        return [super GET:URLString parameters:parameters success:success failure:failure];
    } else {
        return [self requestBearerToken:^(NSURLSessionDataTask * task, id responseObject) {
            [super GET:URLString parameters:parameters success:success failure:failure];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            failure(task, error);
        }];
    }
    
}

-(NSURLSessionDataTask *) requestBearerToken:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    return [super POST:@"/oauth2/token" parameters:@{@"grant_type":@"client_credentials"} success:^(NSURLSessionDataTask *task, id responseObject)
     {
         // Success
         NSLog(@"Success: %@", [responseObject valueForKey:@"access_token"]);
         
         if ([responseObject valueForKey:@"access_token"] != nil) {
             self.bearerToken = [responseObject valueForKey:@"access_token"];
             success(task, responseObject);
             return;
         }
         success(task, responseObject);
         return;
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         // Failure
         failure(task, error);
         return;
     }];
}

-(NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler {
    
    NSMutableURLRequest *req = (NSMutableURLRequest *)request;
    if(self.bearerToken)
    {
        [req setValue:[NSString stringWithFormat:@"Bearer %@", self.bearerToken] forHTTPHeaderField:@"Authorization"];
    } else {
        NSLog(@"Setting headers...");
        [req setValue:[NSString stringWithFormat:@"Basic %@", [AFTwitterSessionManager toBase64String:API_CREDENTIAL]] forHTTPHeaderField:@"Authorization"];
        [req setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    // Give each request a unique ID for tracing
    
    return [super dataTaskWithRequest:req completionHandler:completionHandler];
}

+ (NSString *)toBase64String:(NSString *)string {
    NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:kNilOptions];
}

@end
