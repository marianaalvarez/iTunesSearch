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
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    _itunes = [iTunesManager sharedInstance];
    midias = [_itunes buscarMidias:@"Apple"];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 80.f)];
    
    _texto = [[UITextField alloc]initWithFrame:CGRectMake(1.0f, 40.0f, 220.f, 30.f)];
    [_texto setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIButton *botao = [[UIButton alloc]initWithFrame:CGRectMake(220.f, 40.0f, 100.f, 30.f)];
    [botao setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [botao setTitle:NSLocalizedString(@"botao", @"") forState:UIControlStateNormal];
    [botao addTarget:self action:@selector(pesquisa) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableview.tableHeaderView addSubview:_texto];
    [self.tableview.tableHeaderView addSubview:botao];
    
}
     
-(void)pesquisa{
    midias = [_itunes buscarMidias:_texto.text];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:NSLocalizedString(@"Filmes", @"")];
    [celula.genero setText:filme.genero];
    [celula.artista setText:filme.artista];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    static NSString *CellIdentifier = @"SectionHeader";
//    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (headerView == nil){
//        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
//    }
//    
//    UITextField *texto = [[UITextField alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 100.f, 30.f)];
//    [headerView addSubview:texto];
//    return headerView;
//}


@end
