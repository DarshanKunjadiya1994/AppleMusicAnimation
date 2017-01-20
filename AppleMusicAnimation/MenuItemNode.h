//
//  MenuItemNode.h
//  Party
//
//  Created by Adnan Aftab on 8/25/15.
//  Copyright (c) 2015 CX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MenuItemNode : SKShapeNode
{
    BOOL isFirstTime;
}

@property (nonatomic, strong) NSString *title;

+ (instancetype)menuNode;
+ (instancetype)menuNodeWithTitle:(NSString*)title;
@end
