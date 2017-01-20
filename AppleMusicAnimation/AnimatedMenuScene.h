//
//  AnimatedMenuScene.h
//  Party
//
//  Created by Adnan Aftab on 8/25/15.
//  Copyright (c) 2015 CX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class AnimatedMenuScene;

@protocol AnimatedMenuSceneDelegate

@optional
- (void)animatedMenuScene:(AnimatedMenuScene*)animatedScene didSelectNodeAtIndex:(NSInteger)index;
- (void)animatedMenuScene:(AnimatedMenuScene *)animatedScene didDeSelectNodeAtIndex:(NSInteger)index;

@end

@interface AnimatedMenuScene : SKScene

@property (nonatomic, assign) BOOL allowMultipleSelection;
@property (nonatomic, strong) NSArray *menuNodes;
@property (nonatomic, weak) id<AnimatedMenuSceneDelegate>animatedSceneDelegate;

@end
