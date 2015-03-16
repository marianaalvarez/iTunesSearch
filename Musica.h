//
//  Musica.h
//  iTunesSearch
//
//  Created by Mariana Alvarez on 15/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Musica : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *midia;
@property (nonatomic, strong) NSString *imagem;
@property (nonatomic, strong) NSString *imagemMidia;
@property (nonatomic, strong) NSString *collecao;
@property  NSInteger *trackTimeMillis;

@end
