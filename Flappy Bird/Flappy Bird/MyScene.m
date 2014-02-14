//
//  MyScene.m
//  Flappy Bird
//
//  Created by Hossam Ghareeb on 2/14/14.
//  Copyright (c) 2014 Hossam Ghareeb. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        
        self.bird = [Bird spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(30, 30)];
        self.bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bird.size.width / 2];
        self.bird.physicsBody.dynamic = NO;
        self.bird.physicsBody.density = 1.5;
        self.bird.physicsBody.linearDamping = 1;
        self.bird.position = CGPointMake(160, 300);
        
        [self addChild:self.bird];
        
        self.obstacles = [NSMutableArray array];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        if (!gameStarted) {
            gameStarted = YES;
            self.bird.physicsBody.dynamic = YES;
        }
        
        [self.bird bounce];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
