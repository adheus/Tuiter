//
//  SearchDAO.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "SearchDAO.h"
#import "AppDelegate.h"

@implementation SearchDAO

+(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void) save:(NSString *)searchTerm {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newSearch = [NSEntityDescription insertNewObjectForEntityForName:@"Search" inManagedObjectContext:context];
    [newSearch setValue:searchTerm forKey:@"text"];
    [newSearch setValue:[NSDate date] forKey:@"date"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

+(NSArray *)list {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Search"];
    
    NSSortDescriptor *dateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:@[dateSortDescriptor]];
    [fetchRequest setFetchLimit:10];
    
    return [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
}

@end
