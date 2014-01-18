//
//  CompanyTableViewCell.m
//  LabOrganizer
//
//  Created by Yan Xia on 4/10/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "CompanyTableViewCell.h"

@implementation CompanyTableViewCell
@synthesize label;
@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCell:(NSManagedObject *)selectedObject forAttribute:(NSString *)attribute enable:(BOOL)enable  forClass:(NSString *)selectedClass
{
    self.textField.enabled = enable;
    
    if ([selectedClass isEqualToString:@"Company"]) {
        if (attribute == @"companyName") {
        self.label.text = @"Vendor";
        } else if (attribute == @"companyPhone") {
            self.label.text = @"Phone";
        } else if (attribute == @"companyEmail") {
            self.label.text = @"Email";
        } else {
            self.label.text = @"WebSite";
        }
    } else if ([selectedClass isEqualToString:@"Location"]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label.text = @"Location";
    } else if ([selectedClass isEqualToString:@"Category"]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label.text = @"Category";
    } else if ([selectedClass isEqualToString:@"Experiment"]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label.text = @"Experiment";
    }
    
    self.textField.text = [selectedObject valueForKey:attribute];
}

@end
