//
//  MVDPost.h
//  RedditStarteriOS29
//
//  Created by Michael Di Cesare on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVDPost : NSObject

// this is a class in swift
@property(nonatomic, copy, readonly, nonnull)NSString * title;
@property(nonatomic, copy, readonly, nullable)NSString * thumbnail;

// init
-(MVDPost *)initWithTItle:(NSString *)title thumbnail:(NSString *)thumbnail;


@end


//extiontion

@interface MVDPost (JSONConvertable)

-(MVDPost *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
