//
//  ViewController.h
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <UIKit/UIKit.h>

@interface DetailController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView_movie;
@property (weak, nonatomic) IBOutlet UILabel *label_movieName;
@property (weak, nonatomic) IBOutlet UILabel *label_movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *label_releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *label_duration;
@property (weak, nonatomic) IBOutlet UILabel *label_averageVote;
@property (weak, nonatomic) IBOutlet UILabel *label_popularity;

@end

