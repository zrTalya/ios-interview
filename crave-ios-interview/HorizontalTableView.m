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
#define DEFAULT_CELLS_IN_ROW  (([[UIScreen mainScreen] bounds].size.width)/DEFAULT_CELL_WIDTH )



@implementation HorizontalTableView
	UIScrollView *scrollView;
	NSMutableArray* displayedCellsArr;
	UILabel* hiddenCell;


	int currCell;

- (UIView*)dequeueCell{
		return hiddenCell ;
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
	displayedCellsArr = [[NSMutableArray alloc]init];
	UIView *myLabel;
	for (int i=0; i < DEFAULT_CELLS_IN_ROW;i++){
		
		myLabel = [_dataSource horizontalScrollView:self cellForIndex:i];
		myLabel.frame = CGRectMake(currX, 0, DEFAULT_CELL_WIDTH, self.frame.size.height);
		[self addSubview:myLabel];
		[displayedCellsArr addObject:myLabel];
		
		[scrollView addSubview:myLabel];
		currX+=DEFAULT_CELL_WIDTH;

		
	}
	currCell = 0;


}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//get current first cell and last
	int cellNum = (scrollView.contentOffset.x - ((int)scrollView.contentOffset.x % DEFAULT_CELL_WIDTH))/ DEFAULT_CELL_WIDTH;
	int lastCellNum = ceil((scrollView.contentOffset.x + scrollView.frame.size.width) / DEFAULT_CELL_WIDTH);
	
	NSLog(@"scrollX: %f, cellNum: %d, lastCellNum: %d", scrollView.contentOffset.x, cellNum, lastCellNum);
	
	if ((cellNum > currCell) && (currCell < [_dataSource horizontalScrollViewNumberOfCells:self])){
		//means first cell is hidden, and we will load new cell
		hiddenCell = [displayedCellsArr objectAtIndex:0];
		[displayedCellsArr removeObjectAtIndex:0];


		UIView* cell = [_dataSource horizontalScrollView:self cellForIndex:cellNum+DEFAULT_CELLS_IN_ROW];
		cell.frame =CGRectMake(((UIView*)[displayedCellsArr objectAtIndex:displayedCellsArr.count-1]).frame.origin.x+DEFAULT_CELL_WIDTH, 0,DEFAULT_CELL_WIDTH, self.frame.size.height);
		
		[displayedCellsArr insertObject:cell atIndex:displayedCellsArr.count];
		
		currCell = cellNum;
	}
	else if ((cellNum < currCell)&&(currCell>0)){
		//means last cell is hidden, and we will load new cell
		hiddenCell = [displayedCellsArr objectAtIndex:displayedCellsArr.count - 1];
		[displayedCellsArr removeObjectAtIndex:displayedCellsArr.count-1];
		
		
		UIView* cell = [_dataSource horizontalScrollView:self cellForIndex:cellNum];
		cell.frame = CGRectMake(cellNum*DEFAULT_CELL_WIDTH, 0, DEFAULT_CELL_WIDTH, self.frame.size.height);
		
		[displayedCellsArr insertObject:cell atIndex:0];
		
		currCell = cellNum;
	}

	
}






@end
