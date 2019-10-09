//
//  MVDPostController.m
//  RedditStarteriOS29
//
//  Created by Michael Di Cesare on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "MVDPostController.h"

static NSString * const kBaseURLString = @"https://www.reddit.com/";
static NSString * const KRComponentString = @"r";
static NSString * const kFunnyComponent = @"funny";
static NSString * const kJSONExrwnaion = @"json";

@implementation MVDPostController

+ (instancetype)sharedController
{
    static MVDPostController * sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [MVDPostController new];
    // or this both same
    //    sharedController = [[MVDPostController alloc] init];
        
    });
    return sharedController;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    NSURL *rURL = [url URLByAppendingPathComponent:KRComponentString];
    NSURL *funnyURL = [rURL URLByAppendingPathComponent:kFunnyComponent];
    NSURL *finalURL = [funnyURL URLByAppendingPathExtension:kJSONExrwnaion];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching post %@", error);
            completion(false);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"error with fetch post data");
            completion(false);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (error)
        {
            NSLog(@"Error parsing Json data %@", [error localizedDescription]);
            completion(false);
            return;
        }
        NSDictionary *secondLevelJSON = topLevelJSON[@"data"];
        NSArray<NSDictionary *> *thirdLevelJSON = secondLevelJSON[@"children"];
        // placeholder for post
        NSMutableArray *arrayOfPost = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in thirdLevelJSON)
        {
            NSDictionary *postDictionary = currentDictionary[@"data"];
            MVDPost *post = [[MVDPost alloc] initWithDictionary:postDictionary];
            [arrayOfPost addObject:post];
        }
        if (arrayOfPost.count != 0)
        {
            MVDPostController.sharedController.post = arrayOfPost;
            completion(true);
        }
        else
        {
            completion(false);
        }
    }]resume];
}
- (void)fetchImageForPose:(MVDPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:post.thumbnail];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"error %@ %@",error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"error with fetched post image data");
            completion(nil);
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
            
            }] resume];
}
@end
