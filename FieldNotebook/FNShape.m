//
//  FNShape.m
//  FieldNotebook
//
//  Created by Ryan Worl on 3/23/13.
//  Copyright (c) 2013 Ryan Worl. All rights reserved.
//

#import "FNShape.h"
#import "FNPoint.h"

#define kPointArray @"points"
#define kTitleKey  @"title"
#define kSubtitleKey  @"subtitle"

@implementation FNShape

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize color = _color;
@synthesize photoURL = _photoURL;

- (id)initWithPoints:(NSMutableArray *)p
{
    self = [super init];
    
    self.points = p;
    self.title = @"Shape";
    
    [self makeOverlay];
    
    return self;
}

- (void)makeOverlay
{
    CLLocationCoordinate2D pz[self.points.count + 1];
    int i = 0;
    for (; i < self.points.count; i++) {
        FNPoint* point = self.points[i];
        point.parent = self;
        pz[i] = point.coordinate;
    }
    
    self.overlay = [MKPolygon polygonWithCoordinates:pz count:self.points.count];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    for (FNPoint* p in self.points) {
        p.title = _title;
    }
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    for (FNPoint* p in self.points) {
        p.subtitle = _subtitle;
    }
}

- (UIColor *)color
{
    if (!_color) {
        return [UIColor orangeColor];
    }
    
    return _color;
}

- (NSString *)humanType
{
    return @"Shape";
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.points forKey:kPointArray];
    [encoder encodeObject:self.title forKey:kTitleKey];
    [encoder encodeObject:self.subtitle forKey:kSubtitleKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    NSString* subtitle = [decoder decodeObjectForKey:kSubtitleKey];
    NSArray* points = [decoder decodeObjectForKey:kPointArray];
    
    self = [self initWithPoints:points];
    
    self.title = title;
    self.subtitle = subtitle;
    
    return self;
}


@end
