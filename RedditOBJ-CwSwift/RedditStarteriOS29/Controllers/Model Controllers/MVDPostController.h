//
//  MVDPostController.h
//  RedditStarteriOS29
//
//  Created by Michael Di Cesare on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVDPost.h"
NS_ASSUME_NONNULL_BEGIN

@interface MVDPostController : NSObject

@property (nonatomic, copy) NSArray<MVDPost *> * post;

+(instancetype) sharedController;

-(void)fetchPosts:(void (^)(BOOL))completion;

-(void)fetchImageForPose:(MVDPost *)post completion:(void (^) (UIImage * _Nullable))completion;





@end

NS_ASSUME_NONNULL_END
