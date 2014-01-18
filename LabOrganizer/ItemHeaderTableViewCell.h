//
//  ItemHeaderTableViewCell.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/2/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemHeaderTableViewCell: UITableViewCell {
        IBOutlet UILabel *label;
        IBOutlet UITextField *textField;
    }
    
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end
