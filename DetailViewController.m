//
//  DetailViewController.m
//  iTunesSearch
//
//  Created by Mariana Alvarez on 14/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UINavigationItem *navIten = self.navigationController.navigationBar.topItem;
    navIten.title = @"Back";
    
    if (_filme != nil) {
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _filme.imagem]];
        _nome.text = _filme.nome;
        _tipo.text = _filme.midia;
        _artista.text = _filme.artista;
        _genero.text = _filme.genero;
        _imagem.image = [UIImage imageWithData:imageData];
        _label.text = _filme.country;
        
        
    } else if (_musica != nil) {
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _musica.imagem]];
        _nome.text = _musica.nome;
        _tipo.text = _musica.midia;
        _artista.text = _musica.artista;
        _genero.text = _musica.genero;
        _imagem.image = [UIImage imageWithData:imageData];
        _label.text = _musica.collecao;
        
    } else if (_podcast != nil) {
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _podcast.imagem]];
        _nome.text = _podcast.nome;
        _tipo.text = _podcast.midia;
        _artista.text = _podcast.artista;
        _genero.text = _podcast.genero;
        _imagem.image = [UIImage imageWithData:imageData];
        _label.text = _musica.collecao;
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
