//
//  Util.h
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSString *)getDatabaseURL;

+ (NSString *)getDatabaseImageURL;

+ (NSString *)getAPIKey;

+ (NSData *)getDatabaseReturn:(NSString *)urlRequest;

+ (void)saveMovieIDRouting:(NSString *)movieID;

+ (NSString *)timeFormatted:(int)totalMinutes;

+ (NSString *)getMovieIDRouting;

+ (BOOL)isNetworkAvailable;

+ (void)setupURLImage:(NSString *)urlString ImageView:(UIImageView *)imageView;

+ (UIAlertController *)setupToast:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
