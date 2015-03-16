//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Media.h"

@interface TableViewController () {
    NSDictionary *midias;
    NSArray *arrayPodcasts;
    NSArray *arrayMusic;
    NSArray *arrayMovies;
}

@end

@implementation TableViewController
@synthesize itunes;
@synthesize detailVC;

-(DetailViewController*)detailVC {
    if (!detailVC) {
        detailVC = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
        detailVC.title = @"Description";

    }
    return detailVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 60.f)];
    
    _texto = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 15.0f, 220.f, 30.f)];
    [_texto setBorderStyle:UITextBorderStyleRoundedRect];

    UIButton *botao = [[UIButton alloc]initWithFrame:CGRectMake(220.f, 15.0f, 100.f, 30.f)];
    [botao setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [botao setTitle:NSLocalizedString(@"botao", @"") forState:UIControlStateNormal];
    [botao addTarget:self action:@selector(pesquisa) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableview.tableHeaderView addSubview:_texto];
    [self.tableview.tableHeaderView addSubview:botao];
    
}
     
-(void)pesquisa{
    midias = [itunes buscarMidias:_texto.text];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array;
    switch (section) {
        case 0: {
            array = [itunes.categorias objectForKey:@"podcast"];
            break;
        }
        case 1: {
            array = [itunes.categorias objectForKey:@"music"];
            break;
        }
        case 2: {
            array = [itunes.categorias objectForKey:@"movie"];
            break;
        }
        default:
            break;
    }
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    arrayPodcasts = [[NSArray alloc]init];
    arrayMusic = [[NSArray alloc]init];
    arrayMovies = [[NSArray alloc]init];
    
    arrayPodcasts = [midias objectForKey:@"podcast"];
    arrayMusic = [midias objectForKey:@"music"];
    arrayMovies = [midias objectForKey:@"movie"];
    
    switch (indexPath.section) {
            
        case 0: {
            Podcast *podcast = [arrayPodcasts objectAtIndex:indexPath.row];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: podcast.imagem]];
            
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:podcast.midia];
            [celula.genero setText:podcast.genero];
            celula.imagem.image = [UIImage imageWithData: imageData];
            break;
        }
        case 1: {
            
            Musica *musica = [arrayMusic objectAtIndex:indexPath.row];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: musica.imagem]];

            [celula.nome setText:musica.nome];
            [celula.tipo setText:musica.midia];
            [celula.genero setText:musica.genero];
            [celula.artista setText:musica.artista];
            celula.imagem.image = [UIImage imageWithData: imageData];
            break;
        }
        case 2: {
            Filme *filme = [arrayMovies objectAtIndex:indexPath.row];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: filme.imagem]];
            
            [celula.nome setText:filme.nome];
            [celula.tipo setText:filme.midia];
            [celula.genero setText:filme.genero];
            [celula.artista setText:filme.artista];
            celula.imagem.image = [UIImage imageWithData: imageData];
            break;
        }
        default:
            break;
    }
    
    return celula;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:self.detailVC animated:YES];
    
    if (indexPath.section==0) {
        detailVC.podcast = [arrayPodcasts objectAtIndex:indexPath.row];
        detailVC.filme = nil;
        detailVC.musica = nil;
    }
    if (indexPath.section==1) {
        detailVC.musica = [arrayMusic objectAtIndex:indexPath.row];
        detailVC.filme = nil;
        detailVC.podcast = nil;
    }
    if (indexPath.section==2) {
        detailVC.filme = [arrayMovies objectAtIndex:indexPath.row];
        detailVC.podcast = nil;
        detailVC.musica = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UINavigationItem *navIten = self.navigationController.navigationBar.topItem;
    navIten.title = @"iTunesSearch";
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    
    UIImageView *imageViewForImage = [[UIImageView alloc]init];
    imageViewForImage.frame = CGRectMake(0, 0, 20, 20);
    
    UILabel *texto = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 15.0f, 220.f, 20.f)];
    
    if (section==0) {
        imageViewForImage.image = [UIImage imageNamed:@"end-26"];
        texto.text = @"Podcast";
    }
    if (section==1) {
        imageViewForImage.image = [UIImage imageNamed:@"music-26"];
        texto.text = @"Musica";
    }
    if (section==2) {
        imageViewForImage.image = [UIImage imageNamed:@"film-26"];
        texto.text = @"Filme";
    }
    
    imageViewForImage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:imageViewForImage];
    [headerView addSubview:texto];
    return headerView;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    switch (section) {
        case 0: title = @"Podcasts";
            break;
        case 1: title = @"Musicas";
            break;
        case 2: title = @"Filmes";
            break;
        default:
            break;
    }
    return title;
}*/

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
    
}

@end
