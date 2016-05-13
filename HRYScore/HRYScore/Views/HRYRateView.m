//
//  HRYRateView.m
//  HRYScore
//
//  Created by linxiu on 16/5/13.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "HRYRateView.h"

@interface HRYRateView(){
    float starRating;
    float lastRating;
    
    float height;
    float width;
    
    UIImage *unSelectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
}
@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;

@property (nonatomic,weak) id<HRYRateViewDelegate> delegate;
@end

@implementation HRYRateView

-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<HRYRateViewDelegate>)delegate{

    self.delegate = delegate;
    
    unSelectedImage = [UIImage imageNamed:deselectedName];
    halfSelectedImage = halfSelectedName == nil ? unSelectedImage : [UIImage imageNamed:halfSelectedName];
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    
    height = 0.0,width = 0.0;
    
    if (height < [fullSelectedImage size].height) {
        height = [fullSelectedImage size].height;
    }
    if (height < [halfSelectedImage size].height) {
        height = [halfSelectedImage size].height;
    }
    if (height < [unSelectedImage size].height) {
        height = [unSelectedImage size].height;
    }
    if (width < [fullSelectedImage size].width) {
        width = [fullSelectedImage size].width;
    }
    if (width < [halfSelectedImage size].width) {
        width = [halfSelectedImage size].width;
    }
    if (width < [unSelectedImage size].width) {
        width = [unSelectedImage size].width;
    }
    
    starRating = 0.0;
    lastRating = 0.0;
    
    _s1 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s2 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s3 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s4 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s5 = [[UIImageView alloc] initWithImage:unSelectedImage];
    
    [_s1 setFrame:CGRectMake(0,         0, width, height)];
    [_s2 setFrame:CGRectMake(width,     0, width, height)];
    [_s3 setFrame:CGRectMake(2 * width, 0, width, height)];
    [_s4 setFrame:CGRectMake(3 * width, 0, width, height)];
    [_s5 setFrame:CGRectMake(4 * width, 0, width, height)];
    
    [_s1 setUserInteractionEnabled:NO];
    [_s2 setUserInteractionEnabled:NO];
    [_s3 setUserInteractionEnabled:NO];
    [_s4 setUserInteractionEnabled:NO];
    [_s5 setUserInteractionEnabled:NO];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
    
    CGRect frame = [self frame];
    frame.size.width = width * 5;
    frame.size.height = height;
    [self setFrame:frame];

}
-(void)displayRating:(float)rating{

    [_s1 setImage:unSelectedImage];
    [_s2 setImage:unSelectedImage];
    [_s3 setImage:unSelectedImage];
    [_s4 setImage:unSelectedImage];
    [_s5 setImage:unSelectedImage];
    
    if (rating >= 0.5) {
        [_s1 setImage:halfSelectedImage];
    }
    if (rating >= 1) {
        [_s1 setImage:fullSelectedImage];
    }
    if (rating >= 1.5) {
        [_s2 setImage:halfSelectedImage];
    }
    if (rating >= 2) {
        [_s2 setImage:fullSelectedImage];
    }
    if (rating >= 2.5) {
        [_s3 setImage:halfSelectedImage];
    }
    if (rating >= 3) {
        [_s3 setImage:fullSelectedImage];
    }
    if (rating >= 3.5) {
        [_s4 setImage:halfSelectedImage];
    }
    if (rating >= 4) {
        [_s4 setImage:fullSelectedImage];
    }
    if (rating >= 4.5) {
        [_s5 setImage:halfSelectedImage];
    }
    if (rating >= 5) {
        [_s5 setImage:fullSelectedImage];
    }
    
    starRating = rating;
    lastRating = rating;
     [_delegate ratingBar:self ratingChanged:rating];


}
-(float)rating{
    return starRating;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
     [self touchesRating:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
  [self touchesRating:touches];
}
//触发
- (void)touchesRating:(NSSet *)touches{
    if (self.isIndicator) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //星星图片之间的间距
    CGFloat space = (CGFloat)(self.frame.size.width - width*5)/6;
    
    float newRating = 0;
    
    if (point.x >= 0 && point.x <= self.frame.size.width) {
        
        if (point.x <= space+width*0.5f) {
            newRating = 0.5;
        }else if (point.x < space*2+width){
            newRating = 1.0;
        }else if (point.x < space*2+width*1.5){
            newRating = 1.5;
        }else if (point.x <= 3*space+2*width){
            newRating = 2.0;
        }else if (point.x <= 3*space+2.5*width){
            newRating = 2.5;
        }else if (point.x <= 4*space+3*width){
            newRating = 3.0;
        }else if (point.x <= 4*space+3.5*width){
            newRating = 3.5;
        }else if (point.x <= 5*space+4*width){
            newRating = 4.0;
        }else if (point.x <=5*space+4.5*width){
            newRating = 4.5;
        }else {
            newRating = 5.0;
        }
        
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
    }
}
@end
