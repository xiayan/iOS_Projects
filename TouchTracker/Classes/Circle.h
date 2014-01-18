//
//  Circle.h
//  TouchTracker
//
//  Created by Yan Xia on 3/4/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Circle : NSObject <NSCoding> {
    CGPoint center;
    float radius;
}

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) float radius;

@end
