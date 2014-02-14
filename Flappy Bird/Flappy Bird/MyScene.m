//
//  MyScene.m
//  Flappy Bird
//
//  Created by Hossam Ghareeb on 2/14/14.
//  Copyright (c) 2014 Hossam Ghareeb. All rights reserved.
//

#import "MyScene.h"

#define kGap 120
#define kHorizontalSpace 100
#define kMaxMargin 350
#define kMinMargin 40
#define kObstacleWidth 60
#define kObstacleHeight 600
#define kSpeed 1.5
@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor redColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.bird = [Bird spriteNodeWithImageNamed:@"bird.png"];
        self.bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bird.size.width / 2];
        self.bird.physicsBody.dynamic = NO;
        self.bird.physicsBody.density = 1.5;
        self.bird.physicsBody.linearDamping = 1;
        self.bird.position = CGPointMake(120, 300);
        
        [self addChild:self.bird];
        
        self.obstacles = [NSMutableArray array];
        
        [self addObstacle];
        
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

-(void)addObstacle
{
    SKSpriteNode *topObstacle = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(kObstacleWidth, kObstacleHeight)];
    topObstacle.anchorPoint = CGPointMake(0, 1);
    topObstacle.position = CGPointMake(320 , self.size.height + kObstacleHeight);
    
    SKSpriteNode *bottomObstacle = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(kObstacleWidth, kObstacleHeight)];
    bottomObstacle.anchorPoint = CGPointMake(0, 1);
    bottomObstacle.position = CGPointMake(320 , 0);
    
    [self addChild:topObstacle];
    [self addChild:bottomObstacle];

    int randomMargin = kMinMargin + arc4random() % (kMaxMargin - kMinMargin);
    
    //Add margin to top and bottom obstacles
    
    topObstacle.position = CGPointMake(topObstacle.position.x, topObstacle.position.y - randomMargin);
    bottomObstacle.position = CGPointMake(bottomObstacle.position.x, bottomObstacle.position.y + self.size.height - kGap - randomMargin);
    
    [self.obstacles addObject:topObstacle];
    [self.obstacles addObject:bottomObstacle];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (!gameOver && gameStarted) {
        
        NSMutableArray *toBeRemovedFromScene = [NSMutableArray array];
        spacing += kSpeed;
        
        if (spacing > (kHorizontalSpace + kObstacleWidth)) {
            spacing = 0;
            
            [self addObstacle];
        }
        
        for (SKSpriteNode *obstacle in self.obstacles) {

            obstacle.position = CGPointMake(obstacle.position.x - kSpeed, obstacle.position.y);
            
            if ([obstacle intersectsNode:self.bird]) {
                gameOver = YES;
                self.bird.physicsBody.dynamic = NO;
            }
            
            if (obstacle.position.x < - kObstacleWidth) {
                //remove
                [obstacle removeFromParent];
                [toBeRemovedFromScene addObject:obstacle];
            }
        }
        
        [self.obstacles removeObjectsInArray:toBeRemovedFromScene];
    }
}

@end
