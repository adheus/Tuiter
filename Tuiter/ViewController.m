//
//  ViewController.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "ViewController.h"
#import "TwitterServices.h"
#import "ResultsViewController.h"
#import "SimpleItemCell.h"
#import "SearchDAO.h"
#import "TwitterTrend.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lastRequestedTrending = [NSArray array];
    self.lastSearchedTerms = [NSArray array];
    
    self.twitterServices = [[TwitterServices alloc] init];
    [self.searchField addTarget:self action:@selector(textFieldDidEndEditingOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) updateData {
    self.lastSearchedTerms = [SearchDAO list];
    [self.recentSearchesTableView reloadData];
    
    [self.twitterServices getTrends:@"1" callback:^(BOOL success, NSArray *twitterTrends) {
        if (success) {
            self.lastRequestedTrending = twitterTrends;
            [self.trendingNowTableView reloadData];
        }
    }];
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchField.text = @"";
    self.searchField.textColor = [UIColor colorWithRed:0.41 green:0.41 blue:0.44 alpha:1.0];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, -100.0f, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

-(void)textFieldDidEndEditingOnExit:(UITextField *)textField {
    [self.searchField resignFirstResponder];
    if(self.searchField.text.length == 0) {
        self.searchField.textColor = [UIColor colorWithRed:0.37 green:0.62 blue:0.79 alpha:1.0];
        self.searchField.text = @"Search it";
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    NSString *searchTerm = self.searchField.text;
    [self searchForTerm:searchTerm];
    
    
}

-(void)searchForTerm:(NSString *)searchTerm {
    [self.twitterServices searchTweets:searchTerm callback:^(BOOL success, NSArray *twitterStatuses) {
        if (success) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ResultsViewController *resultsViewController = (ResultsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
            resultsViewController.results = twitterStatuses;
            resultsViewController.title = [NSString stringWithFormat:@"\"\%@\"", searchTerm];
            UINavigationController *navigationController =  [[UINavigationController alloc] initWithRootViewController:resultsViewController];
            [SearchDAO save:searchTerm];
            [self presentViewController:navigationController animated:YES completion:nil];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Não foi possível completar esta ação no momento. Tente novamente." delegate:self cancelButtonTitle:@"Ok :(" otherButtonTitles:nil] show];
        }
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if([tableView isEqual:self.recentSearchesTableView]) {
        return self.lastSearchedTerms.count;
    }
    return self.lastRequestedTrending.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableViewCellIdentifier = @"SimpleItemCell";
    
    SimpleItemCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[SimpleItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableViewCellIdentifier];
    }
    
    if ([tableView isEqual:self.recentSearchesTableView]) {
        cell.title.text = [[self.lastSearchedTerms objectAtIndex:indexPath.row] valueForKey:@"text"];
    } else {
        cell.title.text = ((TwitterTrend *)[self.lastRequestedTrending objectAtIndex:indexPath.row]).name;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     if ([tableView isEqual:self.recentSearchesTableView]) {
         [self searchForTerm:[[self.lastSearchedTerms objectAtIndex:indexPath.row] valueForKey:@"text"]];
     } else {
         [self searchForTerm:((TwitterTrend *)[self.lastRequestedTrending objectAtIndex:indexPath.row]).name];
     }
    
}



@end
