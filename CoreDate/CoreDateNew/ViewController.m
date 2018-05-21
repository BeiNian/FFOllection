//
//  ViewController.m
//  CoreData
//
//  Created by cts on 2018/5/18.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSManagedObjectContext * _context;
    NSMutableArray * _dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.rowHeight = 160;
    
    [self createSqlite];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    NSLog(@"首次启动 数据 =%zd 个",resArray.count);
}
 

- (IBAction)insertClicked:(UIButton *)sender {
    [self insertData];
}
- (IBAction)delegateClick:(UIButton *)sender {
    [self delegateData];
}
- (IBAction)updateClicked:(UIButton *)sender {
    [self updateData];
}
- (IBAction)readClicked:(UIButton *)sender {
    [self readData];
}
- (IBAction)sortClicked:(UIButton *)sender {
    [self sortData];
}


#pragma mark -- 数据处理
// 排序
- (void)sortData {
    //创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    //实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
    NSSortDescriptor *numberSort = [NSSortDescriptor sortDescriptorWithKey:@"number"ascending:YES];
    request.sortDescriptors = @[ageSort,numberSort];
    
    //发送请求
    NSError *error = nil;
    NSArray *resArray = [_context executeFetchRequest:request error:&error];
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    if (error == nil) {
        [self alertViewWithMessage:@"按照age和number排序"];
    }else{
        NSLog(@"排序失败, %@", error);
    }
    
    
}

// 查询
- (void)readData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sex = %@",@"美女"];
    request.predicate = predicate;
    // 请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    [self alertViewWithMessage:@"查询所有的美女"];
}

//更新，修改
- (void)updateData{
    // 创建查询请求sex
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sex = %@",@"帅哥"];
    request.predicate = predicate;
    //发送请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    //修改
    for (Student *stu in resArray) {
        stu.name = @"且行且珍惜_iOS";
    }
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    // 保存
    NSError *error;
    if ([_context save:&error]) {
        [self alertViewWithMessage:@"更新所有帅哥的的名字为“且行且珍惜_iOS”"];
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
    
}

- (void)delegateData {
    // 创建删除请求
    NSFetchRequest *delegateRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //删除条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age < %d",18];
    delegateRequest.predicate = predicate;
    
    // 返回需要删除的对象数组
    NSArray * deleArray = [_context executeFetchRequest:delegateRequest error:nil];
    //从数据库中删除
    for (Student *stu in deleArray) {
        [_context deleteObject:stu];
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
     NSArray *resArray = [_context executeFetchRequest:request error:nil];
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
}

- (void)insertData {
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    Student * student = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Student"
                         inManagedObjectContext:_context];
    
    //  2.根据表Student中的键值，给NSManagedObject对象赋值
    student.name = [NSString stringWithFormat:@"Mr-%d",arc4random()%100];
    student.age = arc4random()%20;
    student.sex = arc4random()%2 == 0 ?  @"美女" : @"帅哥" ;
    student.height = arc4random()%180;
    student.number = arc4random()%100;
    student.width = arc4random()%180; 
    
    //查询所有数据的请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    //   3.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error]) {
        [self alertViewWithMessage:@"数据插入到数据库成功"];
    }else{
        [self alertViewWithMessage:[NSString stringWithFormat:@"数据插入到数据库失败, %@",error]];
    }
}

#pragma mark - 创建
//创建数据库
- (void)createSqlite{
    //1、创建模型对象
    //获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //2、创建持久化存储助理：数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //请求自动轻量级迁移
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
   
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
//    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    if (![store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:options error:&error]) {
         NSLog(@"failed to add persistent store with type to persistent store coordinator");
    }
    
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3、创建上下文 保存信息 操作数据库
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context = context;
}

#pragma mark - alert 
- (void)alertViewWithMessage:(NSString *)message{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        
        [NSThread sleepForTimeInterval:0.5];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
        
    }];
}
#pragma mark -- UITableDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * celll = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    Student * student = _dataSource[indexPath.row];
    ;
    celll.imageView.image = [UIImage imageNamed:([student.sex isEqualToString:@"美女"] == YES ? @"mei.jpeg" : @"luo.jpg")];
    celll.textLabel.text = [NSString stringWithFormat:@" age = %d \n number = %d \n name = %@ \n sex = %@ \n width = %d "  ,student.age, student.number, student.name, student.sex, student.width];
    celll.textLabel.numberOfLines = 0;
    
    return celll;
}
 

@end
