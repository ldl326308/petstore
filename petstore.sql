drop database petstore;
create database petstore;
use petstore;


#类型表
create table if not exists `category`
(
	category_id int primary key auto_increment comment'类型表id',
	category_name varchar(20) not null
);

insert into category(category_name) values('藏獒'),('二哈'),('牧羊犬');
select * from category;


# 用户表
create table if not exists `user`
(
   user_id int primary key auto_increment comment'用户id',
   user_name varchar(20) not null comment'用户名',
   user_first_name varchar(20) not null comment'姓',
   user_last_name varchar(20) not null comment'名字',
   user_email varchar(20) not null comment'邮箱',
   user_password varchar(20) not null comment'用户密码',
   user_phone varchar(20) not null comment'电话',
   user_status int default(0) comment'状态'
);

	insert into `user`(user_name,user_first_name,user_last_name,user_email,user_password,user_phone,user_status) 
		values('ldx','刘','小明','32699308@qq.com','lxpassword','13728270987',0);
		
		select * from `user`;

#标签
create table if not exists `tag`
(
	tag_id int primary key auto_increment comment'标签id',
	tag_name varchar(20) not null comment'标签名称'
);

 insert into `tag`(tag_name) values('中型'),('小型'),('大型');
 select * from `tag`;


# 响应接口
create table if not exists `api_response`
(
	api_response_code int primary key auto_increment comment'响应接口id',
	api_response_type varchar(20) comment'响应类型',
	api_response_message varchar(50) comment'响应信息'
);


#宠物表
create table if not exists `pet`
(
	pet_id int primary key auto_increment comment'宠物id',
	category_id int comment'类别id',
	pet_name varchar(20) not null comment'宠物名称',
	pet_photo_urls varchar(50) comment'宠物图片路径',
	tag_id int comment'标签',
	pet_status ENUM('可用','待售','出售'),
	foreign key(category_id) references category(category_id),
	foreign key(tag_id) references tag(tag_id)
);

 insert into `pet`(category_id,pet_name,pet_photo_urls,tag_id,pet_status) values (1,'大黄狗','imges/3993.jpg',2,'可用');
 select * from `pet` where pet_status = '可用';


# 订单表
create table if not exists `order`
(
	order_id int primary key auto_increment comment'订单表id',
	pet_id int comment'宠物',
	order_quantity int comment'数量',
	order_ship_date datetime comment'发货日期',
	order_status ENUM('放置','批准','交付'),
	order_complete int default(0) comment'是否完成',
	foreign key(pet_id) references pet(pet_id)
);

insert into `order`(pet_id,order_quantity,order_ship_date,order_status,order_complete) values(1,2,'2018-10-30','批准',0);
select * from `order`;





