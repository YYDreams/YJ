//
//  RMBaseGoodsModel.h
//  RMDart
//
//  Created by flowerflower on 2018/6/13.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseModel.h"

@interface RMBaseGoodsModel : BaseModel

/****************************商品的基本属性***********************************/


@property (nonatomic , copy) NSString              * spuId; //商品ID
@property (nonatomic , copy) NSString              * skuId; //规格组合ID

@property (nonatomic , copy) NSString              * spuName; //商品名称
@property (nonatomic , copy) NSString              * skuName; //规格组合名称
@property (nonatomic , copy) NSString              * customerRemarks; //用户备注
@property (nonatomic  ,copy) NSString              * price;  //价格
@property (nonatomic , copy) NSString             * originalPrice; //原价
@property (nonatomic , assign) NSInteger              skuTotal; //购买数量

@property (nonatomic , assign) NSInteger              amount; //数量

@property (nonatomic , assign) NSInteger              subTotal; //小计金额
@property (nonatomic , assign) NSInteger              realPay;//实付金额（除红包抵扣金额--均衡扣除）
@property (nonatomic , copy) NSString              * imageUrl; //商品大图地址

@property (nonatomic , copy) NSString              * stock;

@property (nonatomic , copy) NSString              * createTime; //加入购付车时间

//

@property (nonatomic , assign) NSInteger              status; // //状态  1：正常 2：库存不足 3：已下架
@property (nonatomic , copy) NSString              * remark;  //用户备注信息

@property(assign,nonatomic)BOOL selected; //用来标识状态(是否勾选)



@property(nonatomic,copy) NSString *commentContent;  //

@property(nonatomic,copy) NSString *commentId;  // 评论ID


@property(nonatomic,copy) NSString *content;  // <#注释#>
@end
