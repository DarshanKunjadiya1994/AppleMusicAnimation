# AppleMusicAnimation
AppleMusicAnimation (Similar like apple music genre section screen)
is a component which you can use to create a pool of subviews which can animated and will use physicis to animate on siwpe.
Its very easy to use you can add SKShpaeNode as menu item.

**Usage**

1. Create a SKView object and add it to your view, then create AnimatedMenuScene and present in SKView.

2. To add menu item set menuNodes array property (should be an array of NSStrings)

3. If need multiple selections set allowMultipleSelection = YES (Default is NO)

4. Set animatedSceneDelegate if you want to get notify when user selects menuItem (node)

5. For full demo code download code :).

```objectivec
_skView = [[SKView alloc] initWithFrame:self.view.bounds];
[self.view insertSubview:_skView atIndex:0];
_animatedMenuScene = [[AnimatedMenuScene alloc] initWithSize:self.skView.bounds.size];  
_animatedMenuScene.animatedSceneDelegate = self;// If you want to get notify when an item get selected       
_animatedMenuScene.menuNodes = _typeArray;
_animatedMenuScene.backgroundColor = [UIColor blueColor];
[_skView presentScene:_animatedMenuScene];
```
        
**Credit**

This demo code have use AnimatedMenuPool. you can find that here https://github.com/CoderXpert/AnimatedMenuPool

This component use DSMultilineLabelNode to use wrap text in two lines you can find that here https://github.com/downrightsimple/DSMultilineLabelNode 


**Example**

[ScreenShot](https://s24.postimg.org/stoyq6cvp/IMG_0798.png)

[![IMAGE ALT TEXT HERE](https://s24.postimg.org/stoyq6cvp/IMG_0798.png)]
