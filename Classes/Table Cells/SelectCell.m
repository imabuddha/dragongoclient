//
//  SelectCell.m
//  DGSPhone
//
//  Created by Justin Weiss on 6/30/10.
//  Copyright 2010 Avvo. All rights reserved.
//

#import "SelectCell.h"


@implementation SelectCell

@synthesize label;
@synthesize value;
@synthesize picker;
@synthesize options;
@synthesize selectedOptions;
@synthesize changedSelector;
@synthesize sizes;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	UITableView *tableView = (UITableView *)self.superview;
	
	int pickerViewHeight = 215;
	int tableViewHeight = 416;
	
	if (selected && !self.picker) {
		NSLog(@"selected %@", self.label.text);
		self.picker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, tableViewHeight, 320.0, pickerViewHeight)] autorelease];
		[tableView.superview addSubview:self.picker];

		[UIView animateWithDuration:0.5 animations:^(void) {
			tableView.contentOffset = CGPointMake(0, MAX(0, (self.frame.origin.y + self.frame.size.height) - (tableViewHeight - pickerViewHeight)));
		}];

		self.picker.showsSelectionIndicator = YES;
		self.picker.dataSource = self;
		self.picker.delegate = self;
		for(int i = 0; i < [self.selectedOptions count]; i++) {
			int row = [[self.options objectAtIndex:i] indexOfObject:[self.selectedOptions objectAtIndex:i]];
			[self.picker selectRow:row inComponent:i animated:NO];
		}
		
		[UIView animateWithDuration:0.5 animations:^(void) {
			CGRect pickerViewFrame = self.picker.frame;
			pickerViewFrame.origin.y = tableViewHeight - pickerViewHeight;
			self.picker.frame = pickerViewFrame;
		} completion:^(BOOL completed) {
			CGRect tableViewFrame = tableView.frame;
			tableViewFrame.size.height = tableViewHeight - pickerViewHeight;
			tableView.frame = tableViewFrame;
		}];
		[super setSelected:YES animated:animated];
	} else {
		NSLog(@"deselected %@", self.label.text);
		
		if (self.picker) {
			CGRect tableViewFrame = tableView.frame;
			tableViewFrame.size.height = tableViewHeight;
			tableView.frame = tableViewFrame;
			// Apparently resetting the frame here also resets the 
			// content offset. Manually setting it again here seems 
			// to work though.
			tableView.contentOffset = CGPointMake(0, MAX(0, (self.frame.origin.y + self.frame.size.height) - (tableViewHeight - pickerViewHeight)));
			
			[UIView animateWithDuration:0.5 animations:^(void) {
				
				tableView.contentOffset = CGPointMake(0, MAX(0, (self.frame.origin.y + self.frame.size.height) - (tableViewHeight)));
			}];
			
			[UIView animateWithDuration:0.5 animations:^(void) {
				CGRect pickerViewFrame = self.picker.frame;
				pickerViewFrame.origin.y = tableViewHeight;
				self.picker.frame = pickerViewFrame;
			} completion:^(BOOL finished) {
				if (finished) {
					[self.picker removeFromSuperview];
					self.picker = nil;
				}
			}];
		}
		[super setSelected:NO animated:animated];
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (self.changedSelector) {
		[[UIApplication sharedApplication] sendAction:self.changedSelector to:nil from:self forEvent:nil];
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[self.options objectAtIndex:component] objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	CGFloat size;
	if (self.sizes) {
		size = [[self.sizes objectAtIndex:component] floatValue];
	} else {
		size = self.picker.frame.size.width / [self.options count];
	}
	return size;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return [self.options count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[self.options objectAtIndex:component] count];
}

- (NSString *)selectedValueInComponent:(NSInteger)component {
	return [[self.options objectAtIndex:component] objectAtIndex:[self.picker selectedRowInComponent:component]];
}


- (void)dealloc {
	self.label = nil;
	self.value = nil;
	[self.picker removeFromSuperview];
	self.picker = nil;
	self.sizes = nil;
	self.selectedOptions = nil;
    [super dealloc];
}


@end
