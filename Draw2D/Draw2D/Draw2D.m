//
//  Draw2D.m
//  Draw2D
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Draw2D.h"

@implementation Draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *myImage = [UIImage imageNamed:@"pumpkin.jpg"];
    // UIImage to CIImage
    CIImage *cimage = [[CIImage alloc] initWithImage:myImage];
    
    // Filters on CIImage
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaFilter setDefaults];
    [sepiaFilter setValue:cimage forKey:@"inputImage"];
    [sepiaFilter setValue:[NSNumber numberWithFloat:0.8f] forKey:@"inputIntensity"];
    
    // Output processed image
    CIImage *image = [sepiaFilter outputImage];
    
    // CIImage to UIImage
    UIImage *resultUIImage = [UIImage imageWithCIImage:image];
    //CIContext *context = [CIContext contextWithOptions:nil];
    //CGImageRef cgImage = [context createCGImage:image fromRect:image.extent];
    //UIImage *resultUIImage = [UIImage imageWithCGImage:cgImage];
    [resultUIImage drawInRect:[UIScreen mainScreen].bounds];
}

@end
