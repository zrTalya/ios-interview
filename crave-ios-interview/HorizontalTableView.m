//
//  HorizontalScrollView.m
//  testa
//
//  Created by Ishay Weinstock on 12/16/14.
//  Copyright (c) 2014 Ishay Weinstock. All rights reserved.
//

#import "HorizontalTableView.h"

#define SEPARATOR_WIDTH 1
#define DEFAULT_CELL_WIDTH 100



@implementation HorizontalTableView
	UIScrollView *scrollView;

- (UIView*)dequeueCell{
    return nil;
}


- (void) layoutSubviews
{
	long int cellNum = [_dataSource horizontalScrollViewNumberOfCells:self];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
	scrollView.contentSize = CGSizeMake(DEFAULT_CELL_WIDTH * cellNum,self.frame.size.height);
	scrollView.showsHorizontalScrollIndicator = true;
	scrollView.alwaysBounceHorizontal=true;
	scrollView.delegate = self;

	[self addSubview:scrollView];
	int currX = 0;

	for (int i=0; i<cellNum;i++){
		
		UIView* currCell = [[UIView alloc] initWithFrame:CGRectMake(currX, 0, DEFAULT_CELL_WIDTH, self.frame.size.height)];
		UIView *myLabel = [_dataSource horizontalScrollView:self cellForIndex:i];
		myLabel.frame =CGRectMake(0, 0,DEFAULT_CELL_WIDTH, self.frame.size.height);
		[currCell addSubview:myLabel];
		
		[scrollView addSubview:currCell];
		currX += DEFAULT_CELL_WIDTH;
		
	}
}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
	NSLog(@"Did begin decelerating");

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	NSLog(@"Did begin dragging");
}


- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
	CGPoint newOffset = CGPointMake(0, contentOffset.x);
	[scrollView setContentOffset:newOffset animated:animated];
}

- (void)setContentOffset:(CGPoint)contentOffset {
	CGPoint newOffset = CGPointMake(0, contentOffset.x);
	[scrollView setContentOffset:newOffset];
}





@end
