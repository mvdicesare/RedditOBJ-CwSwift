//
//  MVDPost.m
//  RedditStarteriOS29
//
//  Created by Michael Di Cesare on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "MVDPost.h"

static NSString * const kTitle = @"title";
static NSString * const kThumbnail = @"thumbnail";

@implementation MVDPost

- (MVDPost *)initWithTItle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self)
    {
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}
@end
@implementation MVDPost (JSONConvertable)

- (MVDPost *)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString * title = dictionary[kTitle];
    NSString * thumbnail = dictionary[kThumbnail];
    
    return [self initWithTItle:title thumbnail:thumbnail];
}



@end
