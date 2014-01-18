//
//  Person.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/8/11.
//  Copyright (c) 2011 the University of Kansas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Person : NSManagedObject {
@private
}
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) NSNumber * title;
@property (nonatomic, strong) NSString * personPhone;
@property (nonatomic, strong) NSSet* items;

- (NSString *)fullName;

@end
