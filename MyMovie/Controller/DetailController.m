//
//  ViewController.m
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import "DetailController.h"
#import "Util.h"
#import "Movie.h"

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMovieDetail];
}

- (void)getMovieDetail {
    NSString *mainstr = [NSString stringWithFormat:@"%@/%@?api_key=%@&language=%s", [Util getDatabaseURL], [Util getMovieIDRouting], [Util getAPIKey], "en-US"];
    NSData *dbdata = [Util getDatabaseReturn:mainstr];

    if (dbdata!=nil) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"Response Data: %@", dictionary);
        
        [Util setupURLImage:[NSString stringWithFormat:@"%@%@", [Util getDatabaseImageURL], [dictionary objectForKey:@"poster_path"]] ImageView:self.imageView_movie];
        self.label_movieName.text = [dictionary objectForKey:@"title"];
        
        self.label_movieOverview.numberOfLines = 0;
        self.label_movieOverview.text = [NSString stringWithFormat:@"%@\n%@", @"Overview: ", [dictionary objectForKey:@"overview"]];
        [self.label_movieOverview sizeToFit];
        
        self.label_releaseDate.text = [NSString stringWithFormat:@"%@%@", @"Release Date: ", [dictionary objectForKey:@"release_date"]];
        self.label_duration.text = [NSString stringWithFormat:@"%@%@", @"Duration: ", [Util timeFormatted:[[dictionary objectForKey:@"runtime"] intValue]]];
        self.label_averageVote.text = [NSString stringWithFormat:@"%@%.2f / %@", @"Rating: ", [[dictionary objectForKey:@"vote_average"] floatValue], @"10"];;
        self.label_popularity.text = [NSString stringWithFormat:@"%@%d", @"Popularity: ", [[dictionary objectForKey:@"popularity"] intValue]];
    } else {
        //Nothing
    }
}

@end
