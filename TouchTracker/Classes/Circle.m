//
//  Circle.m
//  TouchTracker
//
//  Created by Yan Xia on 3/4/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "Circle.h"


@implementation Circle
@synthesize center, radius;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeCGPoint:center forKey:@"center"];
    [aCoder encodeFloat:radius forKey:@"radius"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    [super init];
    
    CGPoint newCenter = [aDecoder decodeCGPointForKey:@"center"];
    float newRadius = [aDecoder decodeFloatForKey:@"radius"];
    
    [self setCenter:newCenter];
    [self setRadius:newRadius];
    
    return self;
}


@end
