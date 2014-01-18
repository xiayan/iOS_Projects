//
//  Item.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/9/11.
//  Copyright (c) 2011 the University of Kansas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Item : NSManagedObject {
@private
}
@property (nonatomic, strong) NSNumber * quantity;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) id thumbnailImage;
@property (nonatomic, strong) NSString * note;
@property (nonatomic, strong) NSString * catalog;
@property (nonatomic, strong) NSString * webpage;
@property (nonatomic, strong) NSNumber * checkMode;
@property (nonatomic, strong) NSManagedObject * category;
@property (nonatomic, strong) NSManagedObject * experiment;
@property (nonatomic, strong) NSManagedObject * company;
@property (nonatomic, strong) NSSet* orderItemDates;
@property (nonatomic, strong) NSManagedObject * location;
@property (nonatomic, strong) NSManagedObject * image;
@property (nonatomic, strong) NSSet* checkItemDates;
@property (nonatomic, strong) Person * person;
@property (nonatomic, strong) NSSet* receiveItemDates;

@end
