//
//  Possession.m
//  RandomPossessions
//
//  Created by bhardy on 7/29/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "Possession.h"


@implementation Possession

@synthesize possessionName, serialNumber, valueInDollars, dateCreated, imageKey;
@synthesize inheritorName, inheritorNumber;
+ (id)randomPossession {
	NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
														  @"Rusty",
														  @"Shiny", nil];
	NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
														@"Spork",
														@"Mac", nil];
	
	int adjectiveIndex = random() % [randomAdjectiveList count];
	int nounIndex = random() % [randomNounList count];
	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
								[randomAdjectiveList objectAtIndex:adjectiveIndex],
								[randomNounList objectAtIndex:nounIndex]];
	int randomValue = random() % 100;
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
																	'0' + random() % 10,
																	'A' + random() % 26,
																	'0' + random() % 10,
																	'A' + random() % 26,
																	'0' + random() % 10];
	Possession *newPossession = [[self alloc] initWithPossessionName:randomName
																													valueInDollars:randomValue
																														serialNumber:randomSerialNumber];
	return [newPossession autorelease];
}

- (id)initWithPossessionName:(NSString *)name 
							valueInDollars:(int)value
								serialNumber:(NSString *)sNumber
{
	// Call the superclass's designated initializer 
	self = [super init];
	
	// Did the superclass's initialization fail? 
	if (!self)
		return nil;
	
	// Give the instance variables initial values 
	[self setPossessionName:name]; 
	[self setSerialNumber:sNumber]; 
	[self setValueInDollars:value];
	dateCreated = [[NSDate alloc] init];
	
	// Return the address of the newly initialized object
	return self;
}


- (id)initWithPossessionName:(NSString *)name 
{
	return [self initWithPossessionName:name 
                         valueInDollars:0
                           serialNumber:@""];
}
- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	// For each instance variable that is archived, we decode it,
	// and pass it to our setters. (Where it is retained)
	[self setPossessionName:[decoder decodeObjectForKey:@"possessionName"]];
	[self setSerialNumber:[decoder decodeObjectForKey:@"serialNumber"]];
	[self setValueInDollars:[decoder decodeIntForKey:@"valueInDollars"]];
	[self setImageKey:[decoder decodeObjectForKey:@"imageKey"]];
	
	// dateCreated is read only, we have no setter. We explicitly
	// retain it and set our instance variable pointer to it
	dateCreated = [[decoder decodeObjectForKey:@"dateCreated"] retain];
	
	thumbnailData = [[decoder decodeObjectForKey:@"thumbnailData"] retain];

    [self setInheritorName:[decoder decodeObjectForKey:@"inheritorName"]]; 
    [self setInheritorNumber:[decoder decodeObjectForKey:@"inheritorNumber"]]; 

	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	// For each instance variable, archive it under its variable name
	[encoder encodeObject:possessionName forKey:@"possessionName"];
	[encoder encodeObject:serialNumber forKey:@"serialNumber"];
	[encoder encodeInt:valueInDollars forKey:@"valueInDollars"];
	[encoder encodeObject:dateCreated forKey:@"dateCreated"];
	[encoder encodeObject:imageKey forKey:@"imageKey"];
	[encoder encodeObject:thumbnailData forKey:@"thumbnailData"];
    // Put new inheritor data in to an archive 
    [encoder encodeObject:inheritorName forKey:@"inheritorName"]; 
    [encoder encodeObject:inheritorNumber forKey:@"inheritorNumber"]; 
}

- (void)setThumbnailDataFromImage:(UIImage *)image
{
    // Create an empty image of size 70 x 70
    CGRect imageRect = CGRectMake(0, 0, 70, 70);
    UIGraphicsBeginImageContext(imageRect.size);
    [image drawInRect:imageRect];

    // Get the image from the image context, retain it as our thumbnail
    [thumbnail release];
    thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    [thumbnail retain];
    
    // Cleanup image contex resources, we're done
    UIGraphicsEndImageContext();
    
    [thumbnailData release];
    thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.5);
    [thumbnailData retain];
}

- (UIImage *)thumbnail
{
    if (!thumbnailData) {
        return nil;
    }
    if (!thumbnail) {
        thumbnail = [[UIImage imageWithData:thumbnailData] retain];
    }
    return thumbnail;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%@): Worth $%d, Recorded on %@",
														possessionName, serialNumber, valueInDollars, dateCreated];
}

- (void)dealloc 
{
    [inheritorName release]; 
    [inheritorNumber release]; 
    [thumbnail release];
	[thumbnailData release];
	[possessionName release]; 
	[serialNumber release];
	[dateCreated release];
	[imageKey release];
	[super dealloc];
}

@end
