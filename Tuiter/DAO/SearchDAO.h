//
//  SearchDAO.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDAO : NSObject


+(void) save:(NSString *)searchTerm;
+(NSArray *) list;
@end
