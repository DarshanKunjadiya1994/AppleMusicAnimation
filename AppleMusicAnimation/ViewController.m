//
//  ViewController.m
//  AppleMusicAnimation
//
//  Created by Darshan Kunjadiya on 20/01/17.
//  Copyright © 2017 Darshan kunjadiya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // From here you can add name of node and background color of node
    NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Darshan" forKey:@"title"];
    [dict1 setObject:[UIColor lightGrayColor] forKey:@"color"];
    
    NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Kunjadiya" forKey:@"title"];
    [dict2 setObject:[UIColor lightGrayColor] forKey:@"color"];
    
    NSMutableArray *arrColor=[[NSMutableArray alloc] init];
    [arrColor addObject:dict1];
    [arrColor addObject:dict2];
    [arrColor addObject:dict1];
    [arrColor addObject:dict2];
    [arrColor addObject:dict1];
    [arrColor addObject:dict2];
    
    // This is the SKView using this we can add node with animation
    skView = [[SKView alloc] initWithFrame:self.viewSubView.bounds];
    [self.viewSubView insertSubview:skView atIndex:0]; // Add SKView in UIView
    animatedMenuScene = [[AnimatedMenuScene alloc] initWithSize:skView.bounds.size];
    animatedMenuScene.animatedSceneDelegate = self;// If you want to get notify when an item get selected
    animatedMenuScene.allowMultipleSelection=YES;
    animatedMenuScene.menuNodes = arrColor;
    //animatedMenuScene.backgroundColor = [UIColor redColor]; // For change background color
    [skView presentScene:animatedMenuScene];
    
}

#pragma mark - AnimatedMenuScene Delegate
- (void)animatedMenuScene:(AnimatedMenuScene*)animatedScene didSelectNodeAtIndex:(NSInteger)index
{
    NSLog(@"Selected menu index %ld",(long)index);
}
- (void)animatedMenuScene:(AnimatedMenuScene *)animatedScene didDeSelectNodeAtIndex:(NSInteger)index
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
