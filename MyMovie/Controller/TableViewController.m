//
//  TableViewController.m
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "Util.h"
#import "Movie.h"

@interface TableViewController () {
    NSMutableArray *mutualMovies;
    NSMutableArray *filterMovies;
    BOOL isFiltered;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFiltered = false;
    self.search_movie.delegate = self;
    
    [self setupInit];
    [self getMovieList];
}

- (void) setupInit {
    mutualMovies = [[NSMutableArray alloc] init];
}

- (void)getMovieList {
    NSString *mainstr = [NSString stringWithFormat:@"%@/now_playing?api_key=%@&language=%s&page=%d&region=%s", [Util getDatabaseURL], [Util getAPIKey], "en-US", 1, "SG"];
    NSData *dbdata = [Util getDatabaseReturn:mainstr];

    if (dbdata!=nil) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"Response Data: %@", dictionary);

        NSArray *result = [dictionary objectForKey:@"results"];
        [self getMovieListDataResponse:result];
    } else {
        //Nothing
    }
}

- (void)getMovieListDataResponse:(NSArray *)results {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for (NSDictionary *movieDict in results) {
        Movie *movie = [[Movie alloc] init];
        movie.moviePath = [NSString stringWithFormat:@"%@%@", [Util getDatabaseImageURL], movieDict[@"poster_path"]];
        movie.movieID = movieDict[@"id"];
        movie.movieName = movieDict[@"title"];
        movie.movieOverview = movieDict[@"overview"];
        movie.movieRelease = movieDict[@"release_date"];
        [movies addObject:movie];
    }
    
    mutualMovies = movies;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        isFiltered = false;
    } else {
        isFiltered = true;
        filterMovies = [[NSMutableArray alloc] init];
        
        for (Movie *movie in mutualMovies) {
            NSRange nameRange = [movie.movieName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [filterMovies addObject:movie];
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFiltered) {
        return filterMovies.count;
    }
    return mutualMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MovieCell";
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
    if (isFiltered) {
        Movie *filterMovie = filterMovies[indexPath.row];
        
        [Util setupURLImage:filterMovie.moviePath ImageView:cell.imageView_movie];
        cell.label_name.text = filterMovie.movieName;
        cell.label_overview.text = filterMovie.movieOverview;
        [cell.label_overview setNumberOfLines:0];
        [cell.label_overview sizeToFit];
        cell.label_release.text = filterMovie.movieRelease;
    } else {
        Movie *movie = mutualMovies[indexPath.row];
        
        [Util setupURLImage:movie.moviePath ImageView:cell.imageView_movie];
        cell.label_name.text = movie.movieName;
        cell.label_overview.text = movie.movieOverview;
        [cell.label_overview setNumberOfLines:0];
        [cell.label_overview sizeToFit];
        cell.label_release.text = movie.movieRelease;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFiltered) {
        Movie *filterMovie = filterMovies[indexPath.row];
        [Util saveMovieIDRouting:filterMovie.movieID];
        
        NSLog(@"Selected Movie ID: %@", [Util getMovieIDRouting]);
    } else {
        Movie *movie = mutualMovies[indexPath.row];
        [Util saveMovieIDRouting:movie.movieID];
        
        NSLog(@"Selected Movie ID: %@", [Util getMovieIDRouting]);
    
    }
    
    [self performSegueWithIdentifier:@"showDetailSegue" sender:nil];
}

@end
