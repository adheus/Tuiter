//
//  ResultsViewController.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "ResultsViewController.h"
#import "TwitterStatusCell.h"

@implementation ResultsViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.37 green:0.62 blue:0.79 alpha:1.0];
    
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    closeButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = closeButton;

}

-(void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *statusTableViewCellIdentifier = @"TwitterStatusCell";
    
    TwitterStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statusTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[TwitterStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusTableViewCellIdentifier];
    }
    
    [cell setTwitterStatus:[self.results objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
