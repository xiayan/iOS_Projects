//
//  CompanyTableViewCell.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/10/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CompanyTableViewCell : UITableViewCell {
    IBOutlet UILabel *label;
    IBOutlet UITextField *textField;
}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

- (void)configureCell:(NSManagedObject *)selectedCompany forAttribute:(NSString *)attribute enable:(BOOL)enable  forClass:(NSString *)selectedClass;

@end
