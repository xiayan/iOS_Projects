//  EnemyRobot.h
//  SpaceViking
//
#import <Foundation/Foundation.h>
#import "GameCharacter.h"
@interface EnemyRobot : GameCharacter {
    CCAnimation *robotWalkingAnim;
    
    CCAnimation *raisePhaserAnim;
    CCAnimation *shootPhaserAnim;
    CCAnimation *lowerPhaserAnim;
    
    CCAnimation *torsoHitAnim;
    CCAnimation *headHitAnim;
    CCAnimation *robotDeathAnim;
    
    BOOL isVikingWithinBoundingBox;
    BOOL isVikingWithinSight;
    
    GameCharacter *vikingCharacter;
    id <GameplayLayerDelegate> delegate;
    CCLabelBMFont *myDebugLabel;
    
    ALuint walkingSound;
}
@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;
@property (nonatomic, retain) CCAnimation *robotWalkingAnim;
@property (nonatomic, retain) CCAnimation *raisePhaserAnim;
@property (nonatomic, retain) CCAnimation *shootPhaserAnim;
@property (nonatomic, retain) CCAnimation *lowerPhaserAnim;
@property (nonatomic, retain) CCAnimation *torsoHitAnim;
@property (nonatomic, retain) CCAnimation *headHitAnim;
@property (nonatomic, retain) CCAnimation *robotDeathAnim;
@property (nonatomic,assign) CCLabelBMFont *myDebugLabel;
-(void)initAnimations;
@end
