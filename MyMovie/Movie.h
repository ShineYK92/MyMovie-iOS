//
//  Movie.h
//  MyMovie
//
//  Created by YK Gan on 7/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property NSString *movieID;
@property NSString *moviePath;
@property NSString *movieName;
@property NSString *movieOverview;
@property NSString *movieRelease;

@end

NS_ASSUME_NONNULL_END
