//
//  ViewController.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TwitterServices.h"
#import "ResultsViewController.h"
#import "SimpleItemCell.h"
#import "SearchDAO.h"
#import "TwitterTrend.h"

#define TWITTER_LOGO_TOP_PADDING 165.0f

#define SEARCH_BAR_BOTTOM_PADDING 198.0f
#define SEARCH_BAR_LANDSCAPE_PADDING 140.0f

#define SEARCH_FIELD_MIN_WIDTH 320.0f
#define SEARCH_FIELD_PADDING 110.0f

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
    
    if ([self isOnLandscape]) {
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
        self.recentSearchesView.hidden = true;
        self.trendingNowView.hidden = true;
    }
    
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
    self.searchField.textAlignment = NSTextAlignmentLeft;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
        
        
        self.searchBarBottomConstraint.constant = (self.view.frame.size.height / 2)  - self.searchBar.frame.size.height;
        
        if([self isOnLandscape]) {
            self.twitterLogoTopConstraint.constant = self.twitterIcon.frame.origin.y - SEARCH_BAR_LANDSCAPE_PADDING;
            self.twitterIcon.frame = CGRectMake(self.twitterIcon.frame.origin.x, self.twitterLogoTopConstraint.constant, self.twitterIcon.frame.size.width, self.twitterIcon.frame.size.height);
            self.searchBarBottomConstraint.constant += SEARCH_BAR_LANDSCAPE_PADDING;
        }
        self.searchFieldWidthConstraint.constant = self.view.frame.size.width - SEARCH_FIELD_PADDING;
        
        self.searchField.frame = CGRectMake(SEARCH_FIELD_PADDING/2, self.searchField.frame.origin.y, self.searchFieldWidthConstraint.constant, self.searchField.frame.size.height);
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, (self.view.frame.size.height / 2), self.searchBar.frame.size.width, self.searchBar.frame.size.height);

    } completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 1;
        self.trendingNowView.alpha = 1;
        self.twitterLogoTopConstraint.constant = TWITTER_LOGO_TOP_PADDING;
        self.twitterIcon.frame = CGRectMake(self.twitterIcon.frame.origin.x, self.twitterLogoTopConstraint.constant, self.twitterIcon.frame.size.width, self.twitterIcon.frame.size.height);
        self.searchBarBottomConstraint.constant = SEARCH_BAR_BOTTOM_PADDING;
        self.searchFieldWidthConstraint.constant = SEARCH_FIELD_MIN_WIDTH;
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.view.frame.size.height - (self.searchBar.frame.size.height + SEARCH_BAR_BOTTOM_PADDING), self.searchBar.frame.size.width, self.searchBar.frame.size.height);
    } completion:nil];
}

-(void)textFieldDidEndEditingOnExit:(UITextField *)textField {
    [self.searchField resignFirstResponder];
    if(self.searchField.text.length == 0) {
        self.searchField.textAlignment = NSTextAlignmentCenter;
    }
    
    NSString *searchTerm = self.searchField.text;
    [self searchForTerm:searchTerm];
    
    
}

-(BOOL) isOnLandscape {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return UIInterfaceOrientationIsLandscape(orientation);
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        if ([self isOnLandscape])
            [self showRecentSearchesAndTrending];
        else
            [self hideRecentSearchesAndTrending];
    }
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void) showRecentSearchesAndTrending{
    self.recentSearchesView.hidden = false;
    self.trendingNowView.hidden = false;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 1;
        self.trendingNowView.alpha = 1;
    } completion:nil];
    

}

-(void) hideRecentSearchesAndTrending {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
    } completion:^(BOOL success) {
        self.recentSearchesView.hidden = true;
        self.trendingNowView.hidden = true;
    }];
}

-(void)searchForTerm:(NSString *)searchTerm {
    [self.twitterServices searchTweets:searchTerm callback:^(BOOL success, NSArray *twitterStatuses) {
        if (success) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[AppDelegate currentStoryboard] bundle:nil];
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
