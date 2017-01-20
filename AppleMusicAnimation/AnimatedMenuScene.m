//
//  AnimatedMenuScene.m
//  Party
//
//  Created by Adnan Aftab on 8/25/15.
//  Copyright (c) 2015 CX. All rights reserved.
//

#import "AnimatedMenuScene.h"
#import "MenuItemNode.h"


static NSString *SelectAnimation = @"SelectAction";
static NSString *DeselectAnimation = @"DeselectAnimation";

@interface AnimatedMenuScene()
@property (nonatomic, strong) SKFieldNode *magneticField;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) NSTimeInterval touchStartTime;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, strong) SKNode *selectedNode;
@property (nonatomic, strong) NSMutableArray *selectedNodes;
@end
@implementation AnimatedMenuScene
- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        
    }
    return self;
}
- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    _selectedNodes = [NSMutableArray new];
    [self configure];
}
- (void)configure
{
    self.magneticField = [SKFieldNode radialGravityField];
    self.scaleMode = SKSceneScaleModeAspectFill;
    CGRect frame = self.frame;
    frame.size.width = self.magneticField.minimumRadius;
    frame.origin.x -= frame.size.width/2;
    frame.size.height = frame.size.height;
    frame.origin.y = frame.size.height - frame.size.height;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:frame];
    self.magneticField.position = CGPointMake(frame.size.width/2, frame.size.height / 2);
}
- (void)addChild:(SKNode *)node
{
    
    CGFloat x = arc4random_uniform(self.frame.size.width - node.frame.size.width);
    CGFloat y = arc4random_uniform(self.frame.size.height - node.frame.size.height);
    
    node.position = CGPointMake(x, y);
    
    if (node.physicsBody == nil)
    {
        node.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:((SKShapeNode*)node).path];
    }
    
    node.physicsBody.dynamic = YES;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.mass = 0.3;
    node.physicsBody.friction = 0;
    node.physicsBody.linearDamping = 3;
    SKRange *xRange = [SKRange rangeWithLowerLimit:0 upperLimit:self.frame.size.width-node.frame.size.width];
    SKRange *yRange = [SKRange rangeWithLowerLimit:0 upperLimit:self.frame.size.height-node.frame.size.height];
    SKConstraint *constraint = [SKConstraint positionX:xRange Y:yRange];
    node.constraints = @[constraint];
    [super addChild:node];
}
- (void)setMenuNodes:(NSArray *)menuNodes
{
    if (_menuNodes)
    {
        [self.children makeObjectsPerformSelector:@selector(removeFromParent)];
    }
    _selectedNode = nil;
    [_selectedNodes removeAllObjects];
    _menuNodes = menuNodes;
    [self updateScene];
}
- (void)updateScene
{
    
    
    for (int i=0; i < [_menuNodes count]; i++) {
        MenuItemNode *menuItem = [MenuItemNode menuNodeWithTitle:[[_menuNodes objectAtIndex:i] objectForKey:@"title"]];
        [menuItem setFillColor:[[_menuNodes objectAtIndex:i] objectForKey:@"color"]];
//        SKSpriteNode* node = [[SKSpriteNode alloc] initWithImageNamed:@"gym.png"];
//        node.name = @"workoutSelection";
//        //node.size = CGSizeMake(30, 30);
//        [menuItem addChild:node];
        [self addChild:menuItem];
    }
    
//    for (NSString *nodeTitle in _menuNodes)
//    {
//        MenuItemNode *menuItem = [MenuItemNode menuNodeWithTitle:nodeTitle];
//        [menuItem setFillColor:[UIColor blackColor]];
//        [self addChild:menuItem];
//    }
}
- (SKNode *)nodeAtPoint:(CGPoint)p
{
    SKNode *node = [super nodeAtPoint:p];
    if (![node.parent isKindOfClass:[SKScene class]] &&
        ![node isKindOfClass:[MenuItemNode class]] &&
        node.parent != nil &&
        !node.userInteractionEnabled)
    {
        node = node.parent;
    }
    return node;
}
- (void)deselectNode:(SKNode*)node
{
    if (!node)
    {
        return;
    }
    

    NSLog(@"%@",node.children);
    for(SKSpriteNode *object in node.children)
    {
        if([object isKindOfClass:[SKSpriteNode class]])
        {
            if ([object.name isEqualToString:@"workoutSelection"]) {
                [object removeFromParent];
                break;
            }
        }
    }
  
    [node removeActionForKey:SelectAnimation];
    SKAction *action = [SKAction scaleTo:1 duration:0.2];
    [node runAction:action completion:^{
        [node removeAllActions];
    }];
    NSInteger index = [self.children indexOfObject:node];
    if(index != NSNotFound)
    {
        [self.animatedSceneDelegate animatedMenuScene:self didDeSelectNodeAtIndex:index];
    }
}
- (void)selectNode:(SKNode*)node
{
    if (!_allowMultipleSelection)
    {
        [self deselectNode:_selectedNode];
        if (_selectedNode == node)
        {
            _selectedNode = nil;
            return;
        }
        _selectedNodes = nil;
    }
    else
    {
        if ([_selectedNodes containsObject:node])
        {
            [self deselectNode:node];
            [_selectedNodes removeObject:node];
            return;
        }
    }
    SKAction *action = [SKAction scaleTo:1.3 duration:0.2];
    [node runAction:action withKey:SelectAnimation];
    if (_allowMultipleSelection)
    {
//        SKSpriteNode* node1 = [[SKSpriteNode alloc] initWithImageNamed:@"workoutSelection.png"];
//        node1.name = @"workoutSelection";
//        node1.size = CGSizeMake(0, 0);
//        node1.position=CGPointMake(30, 30);
//        [node addChild:node1];
        
        [self.selectedNodes addObject:node];
    }
    else
    {
        _selectedNode = node;
    }
    NSInteger index = [self.children indexOfObject:node];
    if (index != NSNotFound)
    {
        [self.animatedSceneDelegate animatedMenuScene:self didSelectNodeAtIndex:index];
    }
}

-(void)handleSingleTap
{
    NSLog(@"tapCount 1");
}

-(void)handleDoubleTap
{
    NSLog(@"tapCount 2");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInNode:self];
    self.touchStartTime = touch.timestamp;

    
    NSUInteger numTaps = [[touches anyObject] tapCount];
    float delay = 0.2;
    if (numTaps < 2)
    {
        [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay ];
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
    else if(numTaps == 2)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(handleDoubleTap) withObject:nil afterDelay:delay ];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _moving = YES;
    UITouch *touch = [touches anyObject];
    CGPoint prePoint = [touch previousLocationInNode:self];
    CGPoint point = [touch locationInNode:self];
    
    float dx = point.x - prePoint.x;
    float dy = point.y - prePoint.y;
    
    for (SKNode *node in self.children)
    {
        CGVector vector = CGVectorMake(100 * dx, 100 * dy);
        [node.physicsBody applyForce:vector];
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_moving)
    {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if (node)
        {
            [self selectNode:node];
        }
    }
    _moving = NO;
}
@end
