//
//  Util.m
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <SystemConfiguration/SCNetworkReachability.h>
#import "Util.h"

@implementation Util

+ (NSString *)getDatabaseURL {
    return @"https://api.themoviedb.org/3/movie";
}

+ (NSString *)getDatabaseImageURL {
    return @"https://www.themoviedb.org/t/p/w220_and_h330_face";
}

+ (NSString *)getAPIKey {
    return @"b753852a01fe0f123476f4a30dcbacc2";
}

+ (NSData *)getDatabaseReturn:(NSString *)urlRequest {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlRequest]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *dbdata = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    NSLog(@"Data: %@", dbdata);
    
    NSString *returnString = [[NSString alloc] initWithData:dbdata encoding:NSUTF8StringEncoding];
//    NSLog(@"Data Returned: %@", returnString);
    
    NSArray* words = [returnString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
//    NSLog(@"Non Spacing Data Returned: %@", nospacestring);
    
    return dbdata;
}

+ (void)saveMovieIDRouting:(NSString *)movieID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:movieID forKey:@"selectedMovieID"];
    [userDefaults synchronize];
}

+ (NSString *)getMovieIDRouting {
    NSString *movieID = @"";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"selectedMovieID"] != nil){
        movieID = [userDefaults objectForKey:@"selectedMovieID"];
    } else {
        movieID = @"";
    }
    
    return movieID;
}

+ (NSString *)timeFormatted:(int)totalMinutes {
    int minutes = totalMinutes % 60;
    int hours = totalMinutes / 3600;

    return [NSString stringWithFormat:@"%02d Hrs %02d Mins", hours, minutes];
}

+ (BOOL)isNetworkAvailable {
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "https://www.google.com");
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    
    BOOL canReach = success
    && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);
    
    return canReach;
}

+ (void)setupURLImage:(NSString *)urlString ImageView:(UIImageView *)imageView {
    NSURL *userUrl = [NSURL URLWithString:urlString];
    NSData *userData = [NSData dataWithContentsOfURL:userUrl];
    UIImage *userImage = [UIImage imageWithData:userData];
    
    if (userImage == nil) {
        imageView.image = [UIImage imageNamed:@"no_image_available.png"];
    } else {
        imageView.image = userImage;
    }
}

+ (UIAlertController *)setupToast:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
    
    return alert;
}

@end
