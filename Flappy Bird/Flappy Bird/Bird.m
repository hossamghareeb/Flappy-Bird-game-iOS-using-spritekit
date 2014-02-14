//
//  Bird.m
//  Flappy Bird
//
//  Created by Hossam Ghareeb on 2/14/14.
//  Copyright (c) 2014 Hossam Ghareeb. All rights reserved.
//

#import "Bird.h"

@implementation Bird


static const CGFloat bounceImpulse = 20.5;

-(void)bounce
{
    CGFloat birdDirection = self.zRotation + M_PI_2;
    self.physicsBody.velocity = CGVectorMake(0, 0);
    [self.physicsBody applyImpulse: CGVectorMake(bounceImpulse*cosf(birdDirection),
                                                 bounceImpulse*sinf(birdDirection))];
}
@end
