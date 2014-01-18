//
//  Company.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/16/11.
//  Copyright (c) 2011 the University of Kansas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Company : NSManagedObject {
@private
}
@property (nonatomic, strong) NSString * companyWebsite;
@property (nonatomic, strong) NSString * companyEmail;
@property (nonatomic, strong) NSString * companyName;
@property (nonatomic, strong) NSString * companyPhone;
@property (nonatomic, strong) NSSet* items;

@end
