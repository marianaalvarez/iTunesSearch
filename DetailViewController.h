//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Mariana Alvarez on 14/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
#import "Filme.h"
#import "Podcast.h"
#import "Musica.h"

@interface DetailViewController : UIViewController

@property Media *media;
@property Filme *filme;
@property Musica *musica;
@property Podcast *podcast;



@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end
