#import "Cart.h"

@implementation Cart
@synthesize wheelL;
@synthesize wheelR;
@synthesize wheelLBody;
@synthesize wheelRBody;

- (void)createBodyAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = 
    b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape shape;
    // Comment out this line
    //shape.SetAsBox(self.contentSize.width/2/PTM_RATIO, 
    //    self.contentSize.height/2/PTM_RATIO);     
    // Add your code from Vertex Helper here, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2(77.5f / 100.0, 37.0f / 100.0),
        b2Vec2(-78.5f / 100.0, 38.0f / 100.0),
        b2Vec2(-60.5f / 100.0, -37.0f / 100.0),
        b2Vec2(56.5f / 100.0, -38.0f / 100.0)
    };
    // Then call this
    shape.Set(verts, num);
    fixtureDef.shape = &shape;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);  
    
    b2PolygonShape sensorShape;
    sensorShape.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO,
                         b2Vec2(0, -self.contentSize.height/PTM_RATIO), 0);
    fixtureDef.shape = &sensorShape;
    fixtureDef.density = 0.0;
    fixtureDef.isSensor = true;
    body->CreateFixture(&fixtureDef);

}
- (b2Body *)createWheelWithSprite:(Box2DSprite*)sprite 
                           offset:(b2Vec2)offset {
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;        
    bodyDef.position = body->GetWorldPoint(offset);
    b2Body * wheelBody = world->CreateBody(&bodyDef);
    wheelBody->SetUserData(sprite);
    sprite.body = wheelBody;
    
    b2CircleShape circleShape;    
    circleShape.m_radius = sprite.contentSize.width/2/PTM_RATIO;        
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &circleShape;
    fixtureDef.friction = 1.0;
    fixtureDef.restitution = 0.2;
    fixtureDef.density = 10.0;   
    wheelBody->CreateFixture(&fixtureDef); 
    
    return wheelBody;
}
- (void)createWheels {    
    wheelL = [Box2DSprite spriteWithSpriteFrameName:@"Wheel.png"];
    wheelL.gameObjectType = kCartType;
    wheelLBody = [self createWheelWithSprite:wheelL 
                                      offset:b2Vec2(-63.0/100.0, -48.0/100.0)];
    
    wheelR = [Box2DSprite spriteWithSpriteFrameName:@"Wheel.png"];
    wheelR.gameObjectType = kCartType;
    wheelRBody = [self createWheelWithSprite:wheelR 
                                      offset:b2Vec2(63.0/100.0, -48.0/100.0)];
    
    b2RevoluteJointDef revJointDef;
    revJointDef.Initialize(body, wheelLBody, 
                           wheelLBody->GetWorldCenter());
    
    revJointDef.enableMotor = true;
    revJointDef.maxMotorTorque = 1000;
    revJointDef.motorSpeed = 0;
    wheelLJoint = (b2RevoluteJoint *) world->CreateJoint(&revJointDef);
    
    revJointDef.Initialize(body, wheelRBody, 
                           wheelRBody->GetWorldCenter());
    revJointDef.enableMotor = true;
    revJointDef.maxMotorTorque = 1000;
    revJointDef.motorSpeed = 0;

    wheelRJoint = (b2RevoluteJoint *) world->CreateJoint(&revJointDef);   
    
    
}
- (void)setMotorSpeed:(float32)motorSpeed {
    if (characterState != kStateTakingDamage) {
        wheelLJoint->SetMotorSpeed(motorSpeed);
        wheelRJoint->SetMotorSpeed(motorSpeed);
    } else {
        wheelLJoint->SetMotorSpeed(0.2 * motorSpeed);
        wheelRJoint->SetMotorSpeed(0.2 * motorSpeed);
    }
}

- (void) updateStateWithDeltaTime:(ccTime)deltaTime 
             andListOfGameObjects:(CCArray *)listOfGameObjects {
    float32 minAngle = CC_DEGREES_TO_RADIANS(-20);
    float32 maxAngle = CC_DEGREES_TO_RADIANS(20);
    double desiredAngle = self.body->GetAngle();
    if (self.body->GetAngle() > maxAngle) {
        desiredAngle = maxAngle;
    } else if (self.body->GetAngle() < minAngle) {
        desiredAngle = minAngle;
    }
    
    float32 diff = desiredAngle - self.body->GetAngle();
    if (diff != 0) { 
        body->SetAngularVelocity(0);        
        float32 diff = desiredAngle - self.body->GetAngle();
        float angimp = self.body->GetInertia() * diff;
        self.body->ApplyAngularImpulse(angimp * 2);
    }  
}


- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if ((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache 
                                sharedSpriteFrameCache] spriteFrameByName:@"Cart.png"]];
        gameObjectType = kCartType;
        characterHealth = 100.0f;
        [self createBodyAtLocation:location];
        [self createWheels];
    }
    return self;
}

- (void)playJumpEffect {    
    int soundToPlay = random() % 4;
    if (soundToPlay == 0) {
        PLAYSOUNDEFFECT(VIKING_JUMPING_1);
    } else if (soundToPlay == 1) {
        PLAYSOUNDEFFECT(VIKING_JUMPING_2);
    } else if (soundToPlay == 2) {
        PLAYSOUNDEFFECT(VIKING_JUMPING_3);
    } else {
        PLAYSOUNDEFFECT(VIKING_JUMPING_4);
    }
}

- (float32)fullMass {
    return body->GetMass() + wheelLBody->GetMass() + 
    wheelRBody->GetMass();
}

- (void)jump {
    [self playJumpEffect];
    b2Vec2 impulse = b2Vec2([self fullMass]*1.0, [self fullMass]*5.0);
    b2Vec2 impulsePoint = 
    body->GetWorldPoint(b2Vec2(5.0/100.0, -15.0/100.0));
    body->ApplyLinearImpulse(impulse, impulsePoint);     
}


@end
