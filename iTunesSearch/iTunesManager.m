//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Media.h"
#import "Filme.h"
#import "Musica.h"
#import "Podcast.h"

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
        NSString *pattern = [NSString stringWithFormat:@"\\b%@\\b", termo];
        if ([self validateString:[item objectForKey:@"trackName"] withPattern:pattern]) {
            Podcast *podcast = [[Podcast alloc] init];
            [podcast setNome:[item objectForKey:@"trackName"]];
            [podcast setArtista:[item objectForKey:@"artistName"]];
            [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
            [podcast setMidia:[item objectForKey:@"kind"]];
            [podcast setImagem:[item objectForKey:@"artworkUrl100"]];
            [podcast setCollecao:[item objectForKey:@"collectionName"]];
            [podcast setImagemMidia:@"end-26"];
            [_arrayPodcasts addObject:podcast];
        }
        
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
        NSString *pattern = [NSString stringWithFormat:@"\\b%@\\b", termo];
        if ([self validateString:[item objectForKey:@"trackName"] withPattern:pattern]) {
            Musica *music = [[Musica alloc] init];
            [music setNome:[item objectForKey:@"trackName"]];
            [music setArtista:[item objectForKey:@"artistName"]];
            [music setGenero:[item objectForKey:@"primaryGenreName"]];
            [music setMidia:[item objectForKey:@"kind"]];
            [music setImagem:[item objectForKey:@"artworkUrl100"]];
            [music setCollecao:[item objectForKey:@"collectionName"]];
            [music setImagemMidia:@"music-26"];
            [_arrayMusic addObject:music];
        }
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
        NSString *pattern = [NSString stringWithFormat:@"\\b%@\\b", termo];
        if ([self validateString:[item objectForKey:@"trackName"] withPattern:pattern]) {
            Filme *movie = [[Filme alloc] init];
            [movie setNome:[item objectForKey:@"trackName"]];
            [movie setArtista:[item objectForKey:@"artistName"]];
            [movie setGenero:[item objectForKey:@"primaryGenreName"]];
            [movie setMidia:[item objectForKey:@"kind"]];
            [movie setImagem:[item objectForKey:@"artworkUrl100"]];
            [movie setCountry:[item objectForKey:@"country"]];
            [movie setImagemMidia:@"film-26"];
            [_arrayMovies addObject:movie];
        }

    }
}

- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
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
