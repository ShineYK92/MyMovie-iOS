//
//  TableViewCell.h
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_movie;

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_overview;
@property (weak, nonatomic) IBOutlet UILabel *label_release;

@end

NS_ASSUME_NONNULL_END
