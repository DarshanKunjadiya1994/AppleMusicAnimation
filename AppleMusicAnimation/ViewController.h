//
//  ViewController.h
//  AppleMusicAnimation
//
//  Created by Darshan Kunjadiya on 20/01/17.
//  Copyright © 2017 Darshan kunjadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedMenuScene.h"
#import "MenuItemNode.h"
#import <SpriteKit/SpriteKit.h>

@interface ViewController : UIViewController<AnimatedMenuSceneDelegate>
{
    AnimatedMenuScene *animatedMenuScene;
    SKView *skView;
}
@property (weak, nonatomic) IBOutlet UIView *viewSubView;

@end

