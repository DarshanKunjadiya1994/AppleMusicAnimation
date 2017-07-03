# AppleMusicAnimation
AppleMusicAnimation is similar to Apple Music’s genre selection screen. This project provides a component which you can use to create a pool of subviews. Each of these subviews are animated with physics when the user swipe across the screen. You can easily start using this project by adding SKShapeNode as menu item.

**Usage**

1. Create a SKView object and add it to your view, then create AnimatedMenuScene and present in SKView.

2. To add menu item set menuNodes array property (should be an array of NSStrings)

3. If need multiple selections set allowMultipleSelection = YES (Default is NO)

4. Set animatedSceneDelegate if you want to get notify when user selects menuItem (node)

5. For full demo code download code :).

```objectivec
_View = [[SKView alloc] initWithFrame:self.view.bounds];
[self.view insertSubview:_skView atIndex:0];
_animatedMenuScene = [[AnimatedMenuScene alloc] initWithSize:self.skView.bounds.size];  
_animatedMenuScene.animatedSceneDelegate = self;// If you want to get notify when an item get selected       
_animatedMenuScene.menuNodes = _typeArray;
_animatedMenuScene.backgroundColor = [UIColor blueColor];
[_skView presentScene:_animatedMenuScene];
```
        
**Credit**

This project has reference code from AnimatedMenuPool. You can find that here https://github.com/CoderXpert/AnimatedMenuPool

DSMultilineLabelNode is used to wrap text in two lines. You can find that here https://github.com/downrightsimple/DSMultilineLabelNode 


**Example**

![See Example](https://raw.githubusercontent.com/DarshanKunjadiya1994/AppleMusicAnimation/master/AppleMusicAnimation/AppleMusicAnimation.gif)

 License

`AppleMusicAnimation` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
