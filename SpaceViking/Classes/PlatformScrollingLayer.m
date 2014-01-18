//  PlatformScrollingLayer.m
//  SpaceViking
//
#import "PlatformScrollingLayer.h"
#import "GameManager.h"

@interface PlatformScrollingLayer (PrivateMethods)
-(void)resetCloudWithNode:(id)node;
-(void)createCloud;
-(void)createVikingAndPlatform;
-(void)createStaticBackground;
@end

@implementation PlatformScrollingLayer

-(void)createVikingAndPlatform {
    CGSize screenSize = [CCDirector sharedDirector].winSize; // 1
    int nextZValue = [scrollingBatchNode children].count + 1; // 2
    
    // 3
    CCSprite *platform = [CCSprite 
                          spriteWithSpriteFrameName:@"platform.png"];
    [platform setPosition:
     ccp(screenSize.width/2, 
         screenSize.height * 0.09f)];
    [scrollingBatchNode addChild:platform z:nextZValue];
    
    nextZValue = nextZValue + 1; // 4
    
    //5
    CCSprite *viking = [CCSprite 
                        spriteWithSpriteFrameName:@"sv_anim_1.png"];
    [viking setPosition:
     ccp(screenSize.width/2,
         screenSize.height * 0.23f)];
    [scrollingBatchNode addChild:viking z:nextZValue];
}

-(void)resetCloudWithNode:(id)node {
    CGSize screenSize = [CCDirector sharedDirector].winSize; // 1
    CCNode *cloud = (CCNode*)node; // 2
    float xOffSet = [cloud boundingBox].size.width /2; // 3
    
    int xPosition = screenSize.width + 1 + xOffSet; // 4
    int yPosition = random() % (int)screenSize.height; // 5
    
    [cloud setPosition:ccp(xPosition,yPosition)]; // 6
    
    int moveDuration = random() % kMaxCloudMoveDuration; // 7
    if (moveDuration < kMinCloudMoveDuration) {
        moveDuration = kMinCloudMoveDuration; // 8
    }
    
    float offScreenXPosition = (xOffSet * -1) - 1; // 9
    
    // 10
    id moveAction = [CCMoveTo actionWithDuration:moveDuration 
                                        position:
                     ccp(offScreenXPosition,[cloud position].y)];
    id resetAction = [CCCallFuncN 
                      actionWithTarget:self 
                      selector:@selector(resetCloudWithNode:)];
    id sequenceAction = [CCSequence 
                         actions:moveAction,resetAction,nil];
    
    [cloud runAction:sequenceAction]; // 11
    
    int newZOrder = kMaxCloudMoveDuration - moveDuration; // 12
    
    [scrollingBatchNode reorderChild:cloud z:newZOrder]; // 13
}


-(void)createCloud {
    int cloudToDraw = random() % 6; // 0 to 5
    NSString *cloudFileName = [NSString stringWithFormat:@"tiles_cloud%d.png",cloudToDraw];
    CCSprite *cloudSprite = [CCSprite spriteWithSpriteFrameName:cloudFileName];
    [scrollingBatchNode addChild:cloudSprite];
    [self resetCloudWithNode:cloudSprite];
}


-(void)createStaticBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    CCSprite *background;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Indicates game is running on iPad
        background = [CCSprite spriteWithFile:@"tiles_grad_bkgrnd.png"];
    } else {
        background = [CCSprite spriteWithFile:@"tiles_grad_bkgrndiPhone.png"];
    }
    
    [background setPosition:
     ccp(screenSize.width/2.0f, screenSize.height/2.0f)];
    [self addChild:background];
}

-(id)init { 
    self = [super init];
    if (self != nil) {
        srandom(time(NULL));
        self.isTouchEnabled = YES;
        [self createStaticBackground];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             // Indicates game is running on iPad
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
             addSpriteFramesWithFile:
             @"ScrollingCloudsTextureAtlas.plist"];
            scrollingBatchNode = [CCSpriteBatchNode 
                                  batchNodeWithFile:@"ScrollingCloudsTextureAtlas.png"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
             addSpriteFramesWithFile:
             @"ScrollingCloudsTextureAtlasiPhone.plist"];
            scrollingBatchNode = [CCSpriteBatchNode 
                                  batchNodeWithFile:@"ScrollingCloudsTextureAtlasiPhone.png"];
        }
        
        [self addChild:scrollingBatchNode];
        
        for (int x=0; x < 25; x++) {
            [self createCloud];
        }
        
        [self createVikingAndPlatform];
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];
}
@end

