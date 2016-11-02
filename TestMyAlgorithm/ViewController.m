//
//  ViewController.m
//  TestMyAlgorithm
//
//  Created by 龙培 on 16/10/21.
//  Copyright © 2016年 龙培. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self loadMySecondTestMethod];
    
}

#pragma mark - 方法调用一

- (void)loadMyFirstTestMethod
{
    //倒序输出字符
    NSString *value = [self reverseStringWithOriginString:@"MYP is a very clever girl~ WQL love her"];
    NSLog(@"value:%@",value);
    

    
    //求各个位数的和，直到返回1位数
    NSInteger i = [self backValueWithOrigin:99993];
    NSLog(@"i:%ld",i);
    

    
    //按序返回数组中非0元素，0排在数组末尾
    NSMutableArray *originArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"4",@"3",@"0",@"2",@"0",@"9",@"11",@"0", nil];
    NSArray *zeroArray = [self moveTheArrayElementZeroWithOriginArray:originArray];
    NSLog(@"zeroArray:%@",zeroArray);
    
    
    //十进制转成十六进制
    NSString *hexString = [self convertNumberToHexWithOrigin:456789];
    NSLog(@"hexString:%@",hexString);
    
    
    
    //判断一个数字是否为HappyNumber
    [self getHappyNumberWithOrigin:4567];
    [self getHappyNumberWithOrigin:5659];
    
    
    //股票的买入和售出
    NSInteger maxProfit = [self getMaxProfitWithPriceArray:@[@"2",@"7",@"1",@"15",@"4",@"1",@"11",@"6"]];
    
    NSLog(@"maxProfit:%ld",maxProfit);


    //判断是否为UglyNumber
    [self checkUglyNumberWithOrigin:1080];
    
    //上台阶
    NSInteger ways = [self upStairsWithTotal:18];
    NSLog(@"Ways:%ld",ways);
    
}

#pragma mark - 方法调用二

- (void)loadMySecondTestMethod
{
    //读出所有的数字
    NSString *lastString = [self readTheNumberWithIndex:6];
    NSLog(@"----------readString:%@-----------",lastString);
    
    
    
    //找出100以内的所有质数
    [self listAllPrimeLessThanNumber:100];
    
    
    //比较两个版本
    [self compareVersionNumberOne:@"1.13" withNumberTwo:@"1.2"];
    
    
    
    //倒序排数字
    NSInteger revergeValue = [self revergeIntegerWithOrigin:-10234400];
    NSLog(@"RevergeValue:%ld ",revergeValue);
    

}

#pragma mark - 倒序排数字

/*--------------------------------------------------------------------------------------*/
//倒序输出数字  123 -> 321

- (NSInteger)revergeIntegerWithOrigin:(NSInteger)origin
{
    //是否为正数
    BOOL isPositive = YES;
    
    if (origin < 0) {
        
        isPositive = NO;
    }
    
    //取绝对值
    NSInteger absOrigin = labs(origin);
    
    //转成字符串
    NSString *originString = [NSString stringWithFormat:@"%ld",absOrigin];
    
    //分割字符串为单个元素
    NSMutableArray *originArray = [NSMutableArray array];
    
    for (int i = 0; i < originString.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        NSString *letter = [originString substringWithRange:range];
        
        [originArray addObject:letter];
    }
    
    
    //新的字符串
    NSMutableString *newString = [NSMutableString string];
    
    for (NSInteger j = originArray.count-1 ; j >= 0 ; j--) {
        
        NSString *valueString = [originArray objectAtIndex:j];
        
        if (newString.length == 0  && [valueString isEqualToString:@"0"]) {
            
            //如果第一个数字为0，则不做处理
            
        }else{
            
            //倒序添加
            [newString appendString:valueString];
        }
        
        
    }
    
    
    //处理符号
    if (isPositive) {
        
        return [newString integerValue];
    }else{
        
        
        return [[NSString stringWithFormat:@"-%@",newString] integerValue];
    }
    
    
}



#pragma mark - 比较版本数字
/*--------------------------------------------------------------------------------------*/
//比较两个版本数字的大小
//2.5 是二级版本的第5次发布
//0.1 < 1.1 < 1.3 <13.3

- (void)compareVersionNumberOne:(NSString*)oneVersion withNumberTwo:(NSString*)twoVersion
{
    NSInteger oneEdition = [self editionOfTheString:oneVersion];
    NSInteger twoEdition = [self editionOfTheString:twoVersion];
    
    if (oneEdition > twoEdition) {
        
        NSLog(@"Compare Restult: %@ > %@",oneVersion,twoVersion);

    }else if (oneEdition < twoEdition){
        
        NSLog(@"Compare Result: %@ < %@",oneVersion,twoVersion);

    }else{
    
        NSInteger oneIndex = [self indexOfTheString:oneVersion];
        NSInteger twoIndex = [self indexOfTheString:twoVersion];
        
        
        if (oneIndex > twoIndex) {
            
            NSLog(@"Compare Restult: %@ > %@",oneVersion,twoVersion);

        }else if (oneIndex < twoIndex){
            
            NSLog(@"Compare Result: %@ < %@",oneVersion,twoVersion);

        }else{
            
            NSLog(@"Compare Result: %@ = %@",oneVersion,twoVersion);

        }
        
        
    }
    
    
    
}

- (NSInteger)editionOfTheString:(NSString*)origin
{
    NSArray *editionArray = [origin componentsSeparatedByString:@"."];
    
    NSString *editionString = @"0";
    
    if (editionArray.count > 0) {
        
        editionString = [editionArray firstObject];
    }
    
    NSInteger edition = [editionString integerValue];
    
    return edition;
    
}

- (NSInteger)indexOfTheString:(NSString*)origin
{
    NSArray *indexArray = [origin componentsSeparatedByString:@"."];
    
    NSString *indexString = @"0";
    
    if (indexArray.count > 0) {
        
        indexString = [indexArray lastObject];
    }
    
    NSInteger index = [indexString integerValue];
    
    return index;
    
}


#pragma mark - 找出所有小于n的质数

/*--------------------------------------------------------------------------------------*/
//找出小于n的所有质数（只能被1和自身整除的整数叫质数）

- (void)listAllPrimeLessThanNumber:(NSInteger)n
{

    //初始化质数数组
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"2", nil];
    
    //调用递归方法
    NSArray *primeArr = [self loadPrimeWithCurrentNumber:3 withNeedNumber:n withAlreadyPrimeArray:array];
    
    NSLog(@"primeArray:%@",primeArr);

    
}


- (NSArray*)loadPrimeWithCurrentNumber:(NSInteger)number withNeedNumber:(NSInteger)total withAlreadyPrimeArray:(NSMutableArray*)primeArray
{
    if (number == total) {
        
        //如果已经执行到了目标number，则返回质数数组
        return primeArray;
        
    }else{
    

        
        //从已有的质数数组中分别拿出来元素，依次除
        for (NSString *primeString in primeArray) {
            
            NSInteger beforePrime = [primeString integerValue];
            
            //取到质数
            NSInteger primeRemain = number%beforePrime;
            
            
            //当number = p*q时，number = q*p就不必要了。
            //假设number = p*q,p<√n,那么q>√n。所以如果number可以被别的数整除，则这个数一定是不大于√n的。所以除数只需要循环到小于等于√n即可。
            
            if (beforePrime*beforePrime > number) {
                
                
                //将质数添加到质数数组中
                [primeArray addObject:[NSString stringWithFormat:@"%ld",number]];
                
                //判断下一个是不是质数
                return [self loadPrimeWithCurrentNumber:number+1 withNeedNumber:total withAlreadyPrimeArray:primeArray];
            }
            
            
            if (primeRemain == 0) {
                
                //被整除了，判断下一个是不是质数
                return [self loadPrimeWithCurrentNumber:number+1 withNeedNumber:total withAlreadyPrimeArray:primeArray];
            }
            
            
        }
        
        
        return primeArray;

    }
}

#pragma mark - 读数字

/*--------------------------------------------------------------------------------------*/
//初始值为1，接下来开始数数。
//1     （请跟我读：1个1 -> 11）
//11     （请跟我读：2个1 -> 21）
//21      （请跟我读：1个2，1个1 -> 1211）
//1211     （请跟我读：1个1，1个2，2个1 -> 111221 ）
//111221     （请跟我读：3个1，2个2，1个1 -> 312211）
//312211     （不读了，少侠自己去悟吧...）


//读数字
- (NSString *)readTheNumberWithIndex:(NSInteger)index
{
    if (index == 1) {
        return @"1";
        
    }else if (index == 2){
        
        return @"11";
        
    }else{
        
        return [self loadReadStringWithOrigin:@"11" withCurrentIndex:2 withTotal:index];
    }
}

//处理数字的方法
//origin：当前的字符串  currentIndex：当前的执行index   total：需要执行的总次数
- (NSString*)loadReadStringWithOrigin:(NSString*)origin withCurrentIndex:(NSInteger)currentIndex withTotal:(NSInteger)total
{
    
    if (currentIndex == total) {
        
        return origin;
        
    }else{
        
        //初始值数组
        NSMutableArray *originNumberArr = [NSMutableArray array];
        
        //获取字符串的长度
        NSInteger originLength = origin.length;
        
        for (int i = 0; i<originLength; i++) {
            
            //依次取出字母
            NSRange range = NSMakeRange(i, 1);
            
            NSString *subString = [origin substringWithRange:range];
            
            //将字母添加到数组中
            [originNumberArr addObject:subString];
        }
        
        //新的数字数组
        NSMutableArray *newNumberArray = [NSMutableArray array];
        
        //上一个值
        NSInteger lastValue = [[originNumberArr firstObject]integerValue];
        
        //上一个值出现的次数
        NSInteger lastTime = 0;
        
        for (int j = 0; j< originNumberArr.count; j++) {
            
            //取出数组中的元素
            NSString *numberString = [originNumberArr objectAtIndex:j];
            
            //元素的值
            NSInteger value = [numberString integerValue];
            
            if (value == lastValue) {
                
                //如果数组的当前值和上一个值相同，则次数加一，继续执行。
                lastTime += 1;
                
            }else{
                
                //如果数组的当前值和上一个值不同，则添加到数组中
                [newNumberArray addObject:[NSString stringWithFormat:@"%ld%ld",lastTime,lastValue]];
                
                //刷新上一个值为当前值。
                lastValue = value;
                
                //当前值出现的次数为1
                lastTime = 1;
                
            }
            
            if (j == originNumberArr.count-1) {
                
                //如果数组最后一个元素了，不管什么结果，都要添加到数组中
                [newNumberArray addObject:[NSString stringWithFormat:@"%ld%ld",lastTime,lastValue]];
                
            }

            
            
        }

        //初始化可变字符串
        NSMutableString *newOriginString = [NSMutableString string];

        
        //将数组中的元素，取出来组成新的字符串即可
        for (NSString *string in newNumberArray) {
            
            [newOriginString appendString:string];
            
        }
        
        
        //还没执行到目标index，递归执行。
        return [self loadReadStringWithOrigin:newOriginString withCurrentIndex:currentIndex+1 withTotal:total];
        
        
        
    }
}


#pragma mark - 上n层台阶

/*--------------------------------------------------------------------------------------*/
//上n个台阶，每次可以上1或者2个台阶，问共有多少种走法？
//关键的问题是怎么走：n个，若我第一次走1个，则剩下n－1个台阶；若我第一次走2个，则剩下n－2个台阶。
//所以n个台阶的走法，就是n－1个台阶的走法加上n－2个台阶的走法。
//故 f(n) = f(n-1)+f(n-2)

- (NSInteger)upStairsWithTotal:(NSInteger)total
{
    
    if (total == 1) {
        
        //一层台阶 则返回1
        return 1;
        
    }else if (total == 2){
        
        //两层台阶 则返回2
        return 2;
        
    }else{
        
        //三层及以上，开始调函数
        return [self upTheStairWithCurrentIndex:3 withCurrentValue:3 withLastValue:2 withTotal:total];
    }
    
    
}

//current 当前第几层台阶
//currentValue 当前台阶的走法
//lastValue 上一层台阶的走法
//totoal 总共多少层台阶
- (NSInteger)upTheStairWithCurrentIndex:(NSInteger)current withCurrentValue:(NSInteger)currentValue   withLastValue:(NSInteger)lastValue withTotal:(NSInteger)total
{
    if (current == total) {
        
        //如果当前到达的台阶就是总台阶，则将走法返回
        return currentValue;
        
    }else{
    
        //还没到最高台阶
        //下一层台阶的表示：当前台阶的走法＋上一层台阶的走法
        return [self upTheStairWithCurrentIndex:current+1 withCurrentValue:currentValue+lastValue withLastValue:currentValue withTotal:total];
    }
}


#pragma mark - Ugly数字
/*--------------------------------------------------------------------------------------*/
//分解输入的值，如果质数仅含2，3，5，则为UglyNumber
//6，10为Ugly   14＝2*7，包含7，不是UglyNumber

- (void)checkUglyNumberWithOrigin:(NSInteger)origin
{
    
    NSInteger divideTwo = [self divideValue:2 forOrigin:origin];
    
    NSInteger divideThree = [self divideValue:3 forOrigin:divideTwo];
    
    NSInteger divideFive = [self divideValue:5 forOrigin:divideThree];
    
    if (divideFive == 1) {
        
        NSLog(@"Ugly");
    }else{
        NSLog(@"NO Ugly");
    }
    
}

//将初始值除以divide，直到不能整除为止，并返回不能整除的值
- (NSInteger)divideValue:(NSInteger)divide forOrigin:(NSInteger)origin
{
    
    NSInteger divideValue = origin/divide;
    
    //余数
    NSInteger remain = origin%divide;
    
    if (remain == 0) {
        
        //被divide整除了，继续执行
        return [self divideValue:divide forOrigin:divideValue];
        
        
    }else{
        
        //不能被divide整除，返回该值
        return origin;
    }
    
    
}


#pragma mark - 股票抛售

/*--------------------------------------------------------------------------------------*/
//给一个股票价格数组，数组中为整型数字，你可以选一天买入股票，可以后面的某天售出，问你能赚的最大利润
//例如[8,2,5,7,1,3] 最大利润是7-2 = 5,不是8-2 = 6，因为你8块买入，2块卖出，是亏的。
//例如[12,9,5,4,2,1] 无论哪天买入都吃亏，不买入。最大利润为0

- (NSInteger)getMaxProfitWithPriceArray:(NSArray*)priceArray
{

    NSMutableArray *maxProfitArray = [NSMutableArray array];
    
    
    for (NSInteger i = 0; i< priceArray.count; i++) {
        
        //循环获取，某天买入后，以后每天售出的利润 数组，例第一天买入，第2，3，4，5，6天卖出的利润。
        NSMutableArray *indexProfitArray = [self getProfitPriceArray:priceArray withIndex:i];
        
        //获取某天买入，后来售出的最大利润
        NSInteger indexMaxProfit = [self loadMaxValueInPriceArray:indexProfitArray];
        
        [maxProfitArray addObject:[NSString stringWithFormat:@"%ld",indexMaxProfit]];
        
    }
    
    //获取所有买入后售出的最大利润
    NSInteger allMaxProfit = [self loadMaxValueInPriceArray:maxProfitArray];
    
    
    if (allMaxProfit > 0) {
        
        //返回利润
        return allMaxProfit;
    }
    
    return 0;
    
}



//获取当前某天买入，对应的利润数组
- (NSMutableArray*)getProfitPriceArray:(NSArray*)array withIndex:(NSInteger)index
{
    NSMutableArray *profitArray = [NSMutableArray array];
    
    //当前的买入价格
    NSInteger currentValue = [[array objectAtIndex:index] integerValue];
    
    for (NSInteger i = index; i< array.count; i++) {
        
        
        NSInteger profit ;
        
        if (i+1 >= array.count) {
        
            //如果买的是最后一天，没有利润，没法卖出
            profit = 0;
        }else{
            
            //获取第二天、第三天等的价格
            NSInteger rightValue = [[array objectAtIndex:i+1] integerValue];
            
            //第二天、第三天...售出的话，对应的利润值
            profit = rightValue-currentValue;

        }
        
        //当前买入后，各天卖出的利润
        [profitArray addObject:[NSString stringWithFormat:@"%ld",profit]];
        
    }
    
    return profitArray;
}


//获取价格数组中的最大值
- (NSInteger)loadMaxValueInPriceArray:(NSArray*)array
{
    
    NSInteger maxValue = [[array objectAtIndex:0] integerValue];
    
    for (int i = 0; i<array.count; i++) {
        
        NSString *string = array[i];
        
        NSInteger value = [string integerValue];
        
        if (value > maxValue) {
            
            maxValue = value;
            
        }
    }
    
    
    return maxValue;

}

#pragma mark - HappyNumber

/*--------------------------------------------------------------------------------------*/
//判断是否为HappyNumber，输入一个数，将该数的各个位数进行平方，然后求和，再取各个位数进行平方，再求和，直到为1（此时平方求和不再改变），则为HappyNumber。如果结果是某些无限循环的非1的值，则不是HappyNumber。

//例如：5659
//5*5+6*6+5*5+9*9 = 167
//1*1+6*6+7*7 = 86
//8*8+6*6 = 100
//1*1+0*0+0*0 = 1
//所以5659是HappyNumber


//输入初始值，判断是否为HappyNumber
- (void)getHappyNumberWithOrigin:(NSInteger)origin
{
    NSMutableArray *array = [NSMutableArray array];
    
    BOOL isHappy = [self circleDealHappyNumberWithOrigin:origin withValueArray:array];
    
    NSLog(@"IsHappyNumber:%@",isHappy?@"YES":@"NO");

}

//循环处理数字，这里有个数组，很关键，用来判断是否开始循环了
- (BOOL)circleDealHappyNumberWithOrigin:(NSInteger)origin withValueArray:(NSMutableArray*)array
{
    //循环平方后求和
    NSInteger value = [self loadAllNumberWithOrigin:origin];
    
    
    if (value == 1) {
        
        //是HappyNumber
        return YES;
        
    }else{
        
        //判断数组中是否包含了该Value
        BOOL isContain = NO;
        
        for (NSString *valueString in array) {
            
            //循环取值
            NSInteger elementValue = [valueString integerValue];
            
            if (value == elementValue) {
                
                //数组中包含该值了
                isContain = YES;
                
                break;
            }
        }
        
        
        if (isContain) {
            
            //数组中包含，这里又出现了，证明开始循环了，不要再继续了
            return NO;
            
        }else{
        
            //数组中未包含，则添加到数组中
            [array addObject:[NSString stringWithFormat:@"%ld",value]];
            
            //继续循环判断新的值
            return [self circleDealHappyNumberWithOrigin:value withValueArray:array];
        }
        
    }
    
    return NO;
    
}

//所有的位数，值进行平方，然后相加
- (NSInteger)loadAllNumberWithOrigin:(NSInteger)origin
{
    //除以10
    NSInteger divideTen = origin/10;
    
    if (divideTen > 0) {
        
        //大于10，取余数
        NSInteger remain = origin%10;
        
        //余数平凡，剩下的继续取余数
        return remain*remain + [self loadAllNumberWithOrigin:divideTen];
        
    }else{
    
        //小于10，直接返回该值的平方
        return origin*origin;
    }
    
}

#pragma mark - 十进制转十六进制

/*--------------------------------------------------------------------------------------*/
//输入十进制的数字，返回十六进制的值。
//例如输入257，返回101.


- (NSString*)convertNumberToHexWithOrigin:(NSInteger)origin
{
    
    //将初始值除以16
    NSInteger divideValue = origin/16;
    
    
    if (divideValue > 0) {
        
        //初始值大于16时，取余数
        NSInteger remainValue = origin%16;
        
        //将余数转成16进制的值
        NSString *remainString = [self hexStringForValue:remainValue];
        
        //递归添加余数，注意位置，余数代表的值较小（比如16的0次方）再次处理得到的余数代表的值较大（比如16的1次方）
        return [NSString stringWithFormat:@"%@%@",[self convertNumberToHexWithOrigin:divideValue],remainString];

        
        
    }else{
    
        //如果初始值小于16，则直接处理，并返回
        NSString *hexString = [self hexStringForValue:origin];
        
        return hexString;
    }
    
}

- (NSString *)hexStringForValue:(NSInteger)origin
{
    NSString *hexString ;
    
    if (origin == 10) {
        
        hexString = @"a";
    }else if (origin == 11){
        
        hexString = @"b";
    }else if (origin == 12){
        
        hexString = @"c";
    }else if (origin == 13){
        
        hexString = @"d";
    }else if (origin == 14){
        
        hexString = @"e";
    }else if (origin == 15){
        
        hexString = @"f";
        
    }else{
        
        hexString = [NSString stringWithFormat:@"%ld",origin];
    }

    
    return hexString;
}

#pragma mark - 移动数组中的0元素

/*--------------------------------------------------------------------------------------*/
//移动数组中的元素，将0移动到数组的末尾，其它元素按照原顺序排列到数组前面，不允许copy一个新的数组，执行次数要少。
//例如[0,1,0,5,2,0,3]   ->   [1,5,2,3,0,0,0]

- (NSArray*)moveTheArrayElementZeroWithOriginArray:(NSMutableArray*)array
{
    //需要执行的次数
    NSInteger circleTime = array.count;
    
    for (NSInteger i = array.count-1; i >0 ; i--) {
        
        //需要执行的次数减一
        circleTime -= 1;
        
        //取到当前index的对象
        NSString *value = array[i];
        
        //当前index的值
        NSInteger intValue = [value integerValue];
        
        
        if (intValue == 0) {
            
            //如果值为0，则什么都不做
            
        }else{
        
            //如果不为0，那么在数组的第一个元素插入当前的值
            [array insertObject:value atIndex:0];

            //移除数组中当前的值，因为该值已经位于数组首位了。数组元素的总个数加了1，所以原值的index也加了1.
            [array removeObjectAtIndex:i+1];
            
            //因为数组发生了变化，原来位于该index的值已经被移动到数组首位了，需要再次判断该index的元素，所以i要加1
            i += 1;
            
        }
        
        //当执行完毕，则返回数组
        if (circleTime == 0 ) {
            return array;
        }
        
        
    }
    
    return array;
    
}



#pragma mark - 依次拿石头

/*--------------------------------------------------------------------------------------*/
//一堆石头有n个，我和小明依次拿，我先拿，每次可以拿掉1-3个，谁拿到最后一个，谁赢。多少个就一定赢？多少个一定输？


- (void)bringStoneWithTotal:(NSInteger)number
{
    //为什么是4？因为[1,3]区间，总是可以加出来4，如果我拿1个，小明拿3个，以此类推，被四整除，我肯定拿不到最后一个。
    if (number%4 == 0) {
        
        NSLog(@"输");
    }else{
    
        NSLog(@"赢");
    }
}




#pragma mark - 替换数字

/*--------------------------------------------------------------------------------------*/

//输出数字，但是数字是3的倍数输出F，5的倍数输出B，既是3的倍数又是5的倍数，输出FB

- (void)printStringToInteger:(NSInteger)n
{
    for (int i = 1; i<n; i++) {
    
        if (i%15 == 0) {
            
            NSLog(@"FB");
            
        }else if (i%5 == 0) {
            
            NSLog(@"B");
        
        }else if (i%3 == 0) {
            
            NSLog(@"F");
            
        }else{
            
            NSLog(@"%d",i);
        }
        
        
        
    }
}

#pragma mark - 倒序输字符

/*--------------------------------------------------------------------------------------*/
//将字符串中的字母倒序输出来，hello－olleh

- (NSString*)reverseStringWithOriginString:(NSString*)originString
{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    //获取字符串的长度
    NSInteger originLength = originString.length;
    
    for (int i = 0; i<originLength; i++) {
        
        //依次取出字母
        NSRange range = NSMakeRange(i, 1);
        
        NSString *subString = [originString substringWithRange:range];
        
        //字母按原顺序添加到数组中
        [arr addObject:subString];
    }
    
    
    //初始化可变字符串
    NSMutableString *lastString = [NSMutableString string];
    
   
    //将数组中的字母，倒序取出来即可
    for (NSInteger j = originLength-1; j >= 0; j--) {
        
        NSString *letterString = arr[j];
        
        [lastString appendString:letterString];
        
    }
    
    return lastString;
}

#pragma mark - 数字的位数相加

/*--------------------------------------------------------------------------------------*/

/*
 比如66665来说，
 66665 ： 6+6+6+6+5  ＝ 29，
 29：2+9 ＝ 11
 11:1+1 ＝2，只有一位数，不处理。返回2.
 */
- (NSInteger)backValueWithOrigin:(NSInteger)origin
{

    //如果只有一位，返回之
    if (origin > 0 && origin< 10) {
        return origin;
    }
    
    //进行各个位数值相加
    NSInteger dealValue = [self backRemainTotalValue:origin];
    
    
    
    if (dealValue > 0 && dealValue<10) {
    
        //如果只有一位，返回之
        return dealValue;
        
    }else{
        
        //如果有多位，递归调用
        return [self backValueWithOrigin:dealValue];
    }
    
}

//得到当前值的各位数相加的值
- (NSInteger)backRemainTotalValue:(NSInteger)origin
{
    //拿到值，除10
    NSInteger divideTen = origin/10;
    
    if (divideTen> 0) {
        
        //如果大于10，就取该数的余数
        NSInteger remainTen = origin%10;
        
        //用余数加上除10的余数，递归调用
        return remainTen+[self backRemainTotalValue:divideTen];

    }else{
    
        //如果值小于10，返回该值
        return origin;
    }
    
  
}

/*--------------------------------------------------------------------------------------*/



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
