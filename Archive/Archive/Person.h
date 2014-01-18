//
//  Person.h
//  Archive
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
{
    NSString *personName;
    NSString *personAddress;
    NSString *personPhone;
}

@property (strong, nonatomic) NSString *personName;
@property (strong, nonatomic) NSString *personAddress;
@property (strong, nonatomic) NSString *personPhone;

-(id)initWithName:(NSString *)aName Address:(NSString *)anAddress Phone:(NSString *)aPhone;
-(void) setName:(NSString *)name Address:(NSString *)address Phone:(NSString *)phone;

@end
