#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"

@interface PuzzleLayer : CCLayer {
    b2World * world;
    GLESDebugDraw * debugDraw;
    b2Body *groundBody;
    b2MouseJoint *mouseJoint;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    b2Body *frozenVikingBody;
    b2Body *sensorBody;
    BOOL hasWon;
}

+ (id)scene;

@end
