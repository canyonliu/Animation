//
//  ViewController.m
//  动画
//
//  Created by Albert_Liu on 15-1-22.
//  Copyright (c) 2015年 Albert_Liu. All rights reserved.
//

#import "ViewController.h"
#define  IMAGE_COUNT 5

@interface ViewController ()
{
    UIImageView *_imageView;
    UIImageView *_image;
    int _currentIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _imageView = [[UIImageView alloc]init];
    //震荡和转动时的大小
    _imageView.frame = CGRectMake(50, 50, 130, 130);
    //单独转动时的大小
   // _imageView.frame = [UIScreen mainScreen].applicationFrame;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:_imageView];
    
    
    
    //_image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
   // _image.center=CGPointMake(200, 200);
//[self.view addSubview:_image];
    
    
    
    
    //添加手势
    UISwipeGestureRecognizer *leftswipeGesture = [[UISwipeGestureRecognizer alloc ]initWithTarget:self  action:@selector(leftSwipe:)];
    leftswipeGesture.direction =UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftswipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    
   // Do any additional setup after loading the view, typically from a nib.
}

-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture

{
    [self transitionAnimation:YES];
}


#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}


#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    CATransition *transition = [[CATransition alloc]init];
    transition.type = @"cube";
    if(isNext)
    {
        transition.subtype = kCATransitionFromRight;
    }
    else
    {
        transition.subtype = kCATransitionFromLeft;
    }
    
    transition.duration = 1.0f;
    _imageView.image =[self getImage:isNext];
     [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
   // NSString *imageName = [NSString stringWithFormat:@"%i.jpg",_currentAction];
    
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",_currentIndex];
    return [UIImage imageNamed:imageName];
}


//弹性动画

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center=location; //CGPointMake(160, 284);
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
