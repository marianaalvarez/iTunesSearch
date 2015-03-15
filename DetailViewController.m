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
   /* UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];*/
    //self.navigationItem.backBarButtonItem = backButton;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _media.imagem]];
    _nome.text = _media.nome;
    _tipo.text = _media.midia;
    _artista.text = _media.artista;
    _genero.text = _media.genero;
    _imagem.image = [UIImage imageWithData:imageData];
    
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
