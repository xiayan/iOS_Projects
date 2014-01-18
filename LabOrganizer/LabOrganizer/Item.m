//
//  Item.m
//  LabOrganizer
//
//  Created by Yan Xia on 4/9/11.
//  Copyright (c) 2011 the University of Kansas. All rights reserved.
//

#import "Item.h"
#import "Person.h"


@implementation Item
@dynamic quantity;
@dynamic name;
@dynamic thumbnailImage;
@dynamic note;
@dynamic catalog;
@dynamic webpage;
@dynamic checkMode;
@dynamic category;
@dynamic experiment;
@dynamic company;
@dynamic orderItemDates;
@dynamic location;
@dynamic image;
@dynamic checkItemDates;
@dynamic person;
@dynamic receiveItemDates;




- (void)addOrderItemDatesObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"orderItemDates"] addObject:value];
    [self didChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeOrderItemDatesObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"orderItemDates"] removeObject:value];
    [self didChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void)addOrderItemDates:(NSSet *)value {    
    [self willChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"orderItemDates"] unionSet:value];
    [self didChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeOrderItemDates:(NSSet *)value {
    [self willChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"orderItemDates"] minusSet:value];
    [self didChangeValueForKey:@"orderItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}




- (void)addCheckItemDatesObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"checkItemDates"] addObject:value];
    [self didChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeCheckItemDatesObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"checkItemDates"] removeObject:value];
    [self didChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void)addCheckItemDates:(NSSet *)value {    
    [self willChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"checkItemDates"] unionSet:value];
    [self didChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeCheckItemDates:(NSSet *)value {
    [self willChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"checkItemDates"] minusSet:value];
    [self didChangeValueForKey:@"checkItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



- (void)addReceiveItemDatesObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"receiveItemDates"] addObject:value];
    [self didChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
}

- (void)removeReceiveItemDatesObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"receiveItemDates"] removeObject:value];
    [self didChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
}

- (void)addReceiveItemDates:(NSSet *)value {    
    [self willChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"receiveItemDates"] unionSet:value];
    [self didChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeReceiveItemDates:(NSSet *)value {
    [self willChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"receiveItemDates"] minusSet:value];
    [self didChangeValueForKey:@"receiveItemDates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
