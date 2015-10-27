//
//  TwitterServices.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFTwitterSessionManager.h"

@interface TwitterServices : NSObject

@property(nonatomic) AFTwitterSessionManager *manager;
@property(nonatomic) NSString  *bearerToken;

- (void)searchTweets:(NSString *) search callback:(void (^)(BOOL success, NSArray *twitterStatuses))callback;
@end
