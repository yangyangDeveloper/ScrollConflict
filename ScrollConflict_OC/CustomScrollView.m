//
//  CustomScrollView.m
//  ScrollConflict
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import "CustomScrollView.h"
#define PAN_X  100
@implementation CustomScrollView

/*
    iOS响应者链
    •	The implementation of hitTest:withEvent: in UIResponder does the following:
	•	It calls pointInside:withEvent: of self
	•	If the return is NO, hitTest:withEvent: returns nil. the end of the story.
	•	If the return is YES, it sends hitTest:withEvent: messages to its subviews. it starts from the top-level subview, and continues to other views until a subview returns a non-nil object, or all subviews receive the message.
	•	If a subview returns a non-nil object in the first time, the first hitTest:withEvent: returns that object. the end of the story.
	•	If no subview returns a non-nil object, the first hitTest:withEvent: returns self
*/

// 解决slider 和 scrollview 冲突
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if ([hitView isKindOfClass:[UISlider class]]) self.scrollEnabled = NO;
    else self.scrollEnabled = YES;
    return hitView;
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        UIGestureRecognizerState state = pan.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (location.x < PAN_X && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

// 解决 scrollview 和 左滑返回 冲突
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    return YES;
}

@end
