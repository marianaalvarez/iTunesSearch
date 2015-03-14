//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */

@property NSMutableDictionary *categorias;
@property NSMutableArray *arrayMovies;
@property NSMutableArray *arrayPodcasts;
@property NSMutableArray *arrayMusic;

+ (iTunesManager*)sharedInstance;

- (NSDictionary *)buscarMidias:(NSString *)termo;

@end
