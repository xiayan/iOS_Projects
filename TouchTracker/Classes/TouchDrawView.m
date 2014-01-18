//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"
#import "Circle.h"

@implementation TouchDrawView
@synthesize completeShapes;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder]; 
	linesInProcess = [[NSMutableDictionary alloc] init];
    circleInProgress = [[NSMutableDictionary alloc] init];    
	[self setMultipleTouchEnabled:YES];
	return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 10.0);
	CGContextSetLineCap(context, kCGLineCapRound);
	
	// Draw complete lines in black
	[[UIColor blackColor] set];
    int i;
    for (i = 0; i < [completeShapes count]; i++)
    {
        if ([[completeShapes objectAtIndex:i] class] == [Line class])
        {
            Line *line = [completeShapes objectAtIndex:i];
            CGContextMoveToPoint(context, [line begin].x, [line begin].y);
            CGContextAddLineToPoint(context, [line end].x, [line end].y);
            CGContextStrokePath(context);
        } else {
            Circle *circle = [completeShapes objectAtIndex:i];
            CGContextAddArc(context, circle.center.x, circle.center.y, circle.radius, 0.0, M_PI * 2.0, YES);
            CGContextStrokePath(context);
        }
        
        
    }

	[[UIColor redColor] set];
	for (NSValue *v in linesInProcess) {
		Line *line = [linesInProcess objectForKey:v];
		CGContextMoveToPoint(context, [line begin].x, [line begin].y);
		CGContextAddLineToPoint(context, [line end].x, [line end].y);
		CGContextStrokePath(context);
	}
    
    for (NSMutableSet *v in circleInProgress) {
        Circle *circle = [circleInProgress objectForKey:v];
        CGContextAddArc(context, circle.center.x, circle.center.y, circle.radius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
    }
}

- (void)clearAll 
{
	[linesInProcess removeAllObjects];
	[completeShapes removeAllObjects];
    [circleInProgress removeAllObjects];
	
	// Redraw
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        for (UITouch *t in touches) {
            // Is this a double-tap?
            if ([t tapCount] > 1) {
                [self clearAll];
                return;
            }
		
            // Use the touch object (packed in an NSValue) as the key
            NSValue *key = [NSValue valueWithPointer:t];
	
            // Create a line for the value
            CGPoint loc = [t locationInView:self];
            Line *newLine = [[Line alloc] init]; 
            [newLine setBegin:loc];
            [newLine setEnd:loc];
	
            // Put pair in dictionary
            [linesInProcess setObject:newLine forKey:key];
            [newLine release];
        }
    }
    
    if ([touches count] == 2) {
        NSMutableSet *keySet = [[NSMutableSet alloc] init];
        CGPoint center;
        for (UITouch *t in touches) {
            center.x += [t locationInView:self].x;
            center.y += [t locationInView:self].y;
            NSValue *key = [NSValue valueWithPointer:t];
            [keySet addObject:key];
        }
        
        center.x /= 2.0;
        center.y /= 2.0;
        
        Circle *newCircle = [[[Circle alloc] init] autorelease];
        [newCircle setCenter:center];
        [newCircle setRadius:[[touches anyObject] locationInView:self].x - center.x];
        
        [circleInProgress setObject:newCircle forKey:keySet];
        [keySet release];
        
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Update currentLocations
	if ([touches count] == 1) {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithPointer:t];
		
            // Find the line for this touch
            Line *line = [linesInProcess objectForKey:key];

            // Update the line
            CGPoint loc = [t locationInView:self];
            [line setEnd:loc];
        }
	}
    
    if ([touches count] == 2) {
        NSMutableSet *keySet = [[NSMutableSet alloc] init];
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithPointer:t];
            [keySet addObject:key];
        }
        
        Circle *circle = [circleInProgress objectForKey:keySet];
        
        if (circle) {
            CGPoint center;
            for (UITouch *t in touches) {
                center.x += [t locationInView:self].x;
                center.y += [t locationInView:self].y;
            }
            
            center.x /= 2.0;
            center.y /= 2.0;
            
            [circle setCenter:center];
            [circle setRadius:[[touches anyObject] locationInView:self].x - center.x];
        }
        
        [keySet release];
    }
	// Redraw
	[self setNeedsDisplay];
}

- (void)endTouches:(NSSet *)touches
{
	// Remove ending touches from dictionary
	if ([touches count] == 1) {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithPointer:t];
            Line *line = [linesInProcess objectForKey:key];
		
            // If this is a double-tap, 'line' will be nil
            if (line) {
                [completeShapes addObject:line];
                [linesInProcess removeObjectForKey:key];
            }		
        }
    }
    
    if ([touches count] == 2) {
        NSMutableSet *keySet = [[NSMutableSet alloc] init];
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithPointer:t];
            [keySet addObject:key];
        }
        
        Circle *circle = [circleInProgress objectForKey:keySet];
        
        if (circle) {
            [completeShapes addObject:circle];
            [circleInProgress removeObjectForKey:keySet];
        }
        
        [keySet release];
    }
	
	// Redraw
	[self setNeedsDisplay];
}
	
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self endTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self endTouches:touches];
}

- (void)dealloc {
	[linesInProcess release];
	[completeShapes release];
    [circleInProgress release];
    [super dealloc];
}

@end
