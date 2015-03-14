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
    
    _arrayPodcasts = [[NSMutableArray alloc] init];
    _arrayMovies = [[NSMutableArray alloc] init];
    _arrayMusic = [[NSMutableArray alloc] init];
    
    [self buscaMusicas:termo];
    [self buscaPodcasts:termo];
    [self buscaFilmes:termo];
    
    _categorias = [NSMutableDictionary dictionaryWithDictionary:@{@"podcast": _arrayPodcasts,
                                                                  @"movie": _arrayMovies,
                                                                  @"music": _arrayMusic,
                                                                  }];
    
    NSLog(@"Passando Aqui");
    
    return _categorias;
}

-(void)buscaPodcasts:(NSString*)termo {
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    for (NSDictionary *item in resultados) {
        Media *podcast = [[Media alloc] init];
        [podcast setNome:[item objectForKey:@"trackName"]];
        [podcast setArtista:[item objectForKey:@"artistName"]];
        [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
        [podcast setMidia:[item objectForKey:@"kind"]];
        [_arrayPodcasts addObject:podcast];
        
    }
}

-(void)buscaMusicas:(NSString*)termo {
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    for (NSDictionary *item in resultados) {
        Media *music = [[Media alloc] init];
        [music setNome:[item objectForKey:@"trackName"]];
        [music setArtista:[item objectForKey:@"artistName"]];
        [music setGenero:[item objectForKey:@"primaryGenreName"]];
        [music setMidia:[item objectForKey:@"kind"]];
        [_arrayMusic addObject:music];
    }

}

-(void)buscaFilmes:(NSString*)termo {
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    for (NSDictionary *item in resultados) {
        Media *movie = [[Media alloc] init];
        [movie setNome:[item objectForKey:@"trackName"]];
        [movie setArtista:[item objectForKey:@"artistName"]];
        [movie setGenero:[item objectForKey:@"primaryGenreName"]];
        [movie setMidia:[item objectForKey:@"kind"]];
        [_arrayMovies addObject:movie];

    }
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
