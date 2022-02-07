//
//  TableViewController.h
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *search_movie;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

NS_ASSUME_NONNULL_END
