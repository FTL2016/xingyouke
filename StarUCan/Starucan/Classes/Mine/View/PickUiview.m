//
//  PickUiview.m
//  Starucan
//
//  Created by vgool on 16/2/14.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "PickUiview.h"
@interface PickUiview()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *monthMutableArray;
    NSMutableArray *DaysMutableArray;
    NSMutableArray *DaysArray;
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
    
}
@end
@implementation PickUiview
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.customPicker = [[UIPickerView alloc]init];
        self.customPicker.frame =  CGRectMake(0, 40, YTHScreenWidth, 150);
        self.customPicker.dataSource = self;
        self.customPicker.delegate = self;
        
        [self addSubview:self.customPicker];
        
        m=0;
        firstTimeLoad = YES;
        NSDate *date = [NSDate date];
        
        // Get Current Year
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        
        NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                       [formatter stringFromDate:date]];
        year =[currentyearString intValue];
        
        
        // Get Current  Month
        
        [formatter setDateFormat:@"MM"];
        
        currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
        month=[currentMonthString intValue];
        
        
        
        
        // Get Current  Date
        
        [formatter setDateFormat:@"dd"];
        NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        
        day =[currentDateString intValue];
        
        
        yearArray = [[NSMutableArray alloc]init];
        monthMutableArray = [[NSMutableArray alloc]init];
        DaysMutableArray= [[NSMutableArray alloc]init];
        for (int i = 1970; i <= year ; i++)
        {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        
        // PickerView -  Months data
        
        
        monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        
        for (int i=1; i<month+1; i++) {
            [monthMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        DaysArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i <= 31; i++)
        {
            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for (int i = 1; i <day+1; i++)
        {
            [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        
        
        // 设置初始默认值
        [self.customPicker selectRow:20 inComponent:0 animated:YES];
        
        // [pickerView selectRow:30 inComponent:0 animated:NO];
        
        [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
        
        [self.customPicker selectRow:0 inComponent:2 animated:YES];
        
        UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth,YTHAdaptation(40))];
        [self addSubview:viewBg];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(YTHScreenWidth-YTHAdaptation(100), 0, YTHAdaptation(100), YTHAdaptation(40));
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:YTHColor(115, 217, 255) forState:UIControlStateNormal];
        [viewBg addSubview:button];
        //[viewBg.layer setMasksToBounds:YES];
        //[viewBg.layer setCornerRadius:43];
        viewBg.layer.borderColor = [UIColor grayColor].CGColor;
        viewBg.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(buttonActionSure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m=row;
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
    }
    NSLog(@"日期%@",[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]]);
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-1970;
        if (selectRow==n) {
            return [monthMutableArray count];
        }else
        {
            return [monthArray count];
            
        }
    }
    else
    {
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-1970;
        NSInteger selectRow =  [pickerView selectedRowInComponent:1];
        
        if (selectRow==month-1 &selectRow1==n) {
            
            return day;
            
        }else{
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
            
            
        }
        
    }
    
}



- (void)showInView:(UIView *) view
{
    //    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.frame = CGRectMake(0, YTHScreenHeight, YTHScreenWidth, 250);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, YTHScreenHeight-250, YTHScreenWidth, 250);
    }];
}
-(void)buttonActionSure:(UIButton *)btn
{
    NSString *text = [NSString stringWithFormat:@"%@/%@/%@ ",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    NSLog(@"日期%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]]);
    if ([self.delagate respondsToSelector:@selector(SureBtn:didClickTitle:)]) {
        
        [self.delagate SureBtn:self didClickTitle:text];
    }
    
    
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end