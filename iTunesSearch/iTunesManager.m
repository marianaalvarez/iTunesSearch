//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Media.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSDictionary *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    termo = [termo stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *medias = [[NSMutableArray alloc] init];
    _arrayPodcasts = [[NSMutableArray alloc] init];
    _arrayMovies = [[NSMutableArray alloc] init];
    _arrayMusic = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *item in resultados) {
        if ([[item objectForKey:@"kind"] isEqualToString: @"podcast"]) {
            Media *media = [[Media alloc] init];
            [media setNome:[item objectForKey:@"trackName"]];
            [media setArtista:[item objectForKey:@"artistName"]];
            [media setGenero:[item objectForKey:@"primaryGenreName"]];
            [media setMidia:[item objectForKey:@"kind"]];
            [medias addObject:media];
            [_arrayPodcasts addObject:media];
            
        }
        if ([[item objectForKey:@"kind"] isEqualToString: @"song"]) {
            Media *media = [[Media alloc] init];
            [media setNome:[item objectForKey:@"trackName"]];
            [media setArtista:[item objectForKey:@"artistName"]];
            [media setGenero:[item objectForKey:@"primaryGenreName"]];
            [media setMidia:[item objectForKey:@"kind"]];
            [medias addObject:media];
            [_arrayMusic addObject:media];
            
        }
        if ([[item objectForKey:@"kind"] isEqualToString: @"featured-movie"]) {
            Media *media = [[Media alloc] init];
            [media setNome:[item objectForKey:@"trackName"]];
            [media setArtista:[item objectForKey:@"artistName"]];
            [media setGenero:[item objectForKey:@"primaryGenreName"]];
            [media setMidia:[item objectForKey:@"kind"]];
            [medias addObject:media];
            [_arrayMovies addObject:media];
            
        }
        
    }
    
    _categorias = [NSMutableDictionary dictionaryWithDictionary:@{@"podcast": _arrayPodcasts,
                                                                  @"movie": _arrayMovies,
                                                                  @"music": _arrayMusic,
                                                                  }];
    
    NSLog(@"Passando Aqui");
    
    return _categorias;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
