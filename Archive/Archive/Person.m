//
//  Person.m
//  Archive
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize personName, personAddress, personPhone;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.personName = [aDecoder decodeObjectForKey:@"name"];
    self.personAddress = [aDecoder decodeObjectForKey:@"address"];
    self.personPhone = [aDecoder decodeObjectForKey:@"phone"];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.personName forKey:@"name"];
    [aCoder encodeObject:self.personAddress forKey:@"address"];
    [aCoder encodeObject:self.personPhone forKey:@"phone"];
}

-(id)init
{
    self = [self initWithName:@"" Address:@"" Phone:@""];
    return self;
}

-(id)initWithName:(NSString *)aName Address:(NSString *)anAddress Phone:(NSString *)aPhone
{
    self = [super init];
    self.personName = aName;
    self.personAddress = anAddress;
    self.personPhone = aPhone;
    return self;
}

-(void)setName:(NSString *)name Address:(NSString *)address Phone:(NSString *)phone
{
    self.personName = name;
    self.personAddress = address;
    self.personPhone = phone;
}

@end