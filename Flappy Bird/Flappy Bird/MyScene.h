//
//  MyScene.h
//  Flappy Bird
//

//  Copyright (c) 2014 Hossam Ghareeb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bird.h"
@interface MyScene : SKScene
{
    BOOL gameStarted;
}

@property (nonatomic, strong) Bird *bird;
@property (nonatomic, strong) NSMutableArray *obstacles;
@end
