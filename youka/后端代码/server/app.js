// 加载Express模块
const express = require('express');

// 加载MySQL模块
const mysql = require('mysql');

// 加载bodyParser模块
const bodyParser = require('body-parser');

// 加载MD5模块
const md5 = require('md5');

// 创建MySQL连接池
const pool = mysql.createPool({
  host: '127.0.0.1',   //MySQL服务器地址
  port: 3306,          //MySQL服务器端口号
  user: 'moumou',        //数据库用户的用户名
  password: '123456',        //数据库用户密码
  database: 'moumou',    //数据库名称
  connectionLimit: 20, //最大连接数
  charset: 'utf8'      //数据库服务器的编码方式
});

// 创建服务器对象
const server = express();

server.use(bodyParser.urlencoded({
  extended: false
}));

//托管静态资源目录
server.use(express.static('./public/image'));
// 加载CORS模块
const cors = require('cors');

// 使用CORS中间件
server.use(cors({
  origin: ['http://localhost:8080', 'http://127.0.0.1:8080','https://moumou.wylsp.com','https://admin.wylsp.com']
}));

///用户注册接口
server.post('/register', (req, res) => {
  //console.log(md5('12345678'));
  // 获取用户名和密码信息
  let uname = req.body.uname;
  let upwd= req.body.upwd;
  let sex= req.body.sex;
  let uphone= req.body.uphone;  
  //以username为条件进行查找操作，以保证用户名的唯一性
  let sql = 'SELECT COUNT(uid) AS count FROM users WHERE uname=?';
  pool.query(sql, [uname], (error, results) => {
    if (error) throw error;
    let count = results[0].count;
    if (count == 0) {
      // 将用户的相关信息插入到数据表
      sql = 'INSERT users(uname,upwd,sex,uphone) VALUES(?,MD5(?),?,?)';
      pool.query(sql, [uname, upwd,sex,uphone], (error, results) => {
        if (error) throw error;
        res.send({ message: 'ok', code: 200 });
      })
    } else {
      res.send({ message: 'user exists', code: 201 });
    }
  });
});
server.post('/del',(req,res)=>{
    //获取用户名和密码信息
    let id = req.body.id;
    // SQL语句
    let sql = 'delete  from  goods_details where id = ? ';
    pool.query(sql, [id], (error, results) => {
    if (error) throw error;
    if(results.affectedRows==1){ //登录失败
        res.send({message:'ok',code:200,result:results[0]});
    } else { //登录成功
        res.send({message:'login failed',code:201});
    }
    });
})

//用户登录接口
server.post('/login', (req, res) => {
//获取用户名和密码信息
let uname = req.body.uname;
let upwd = req.body.upwd;
// SQL语句
let sql = 'SELECT uid,uname FROM users WHERE uname=? AND upwd=MD5(?)';
pool.query(sql, [uname, upwd], (error, results) => {
if (error) throw error;
if(results.length==0){ //登录失败
res.send({message:'login failed',code:201});
} else { //登录成功
res.send({message:'ok',code:200,result:results[0]});
}
});

});

// 查询用户接口
server.get('/user', (req, res) => {
  let uname= req.query.uname;
  // SQL查询
  let sql ="SELECT uname,sex,uphone,adress,uphoto FROM users WHERE uname=?";

  // 执行SQL查询
  pool.query(sql, [uname], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});


//*****************头像上传********************//
//引入uuid
const uuid=require('uuid');
//引入multer中间件
const multer=require('multer');
//指定目录和文件名
obj=multer.diskStorage({
  destination:function(req,file,cb){//指定目录
    cb(null,'public/image');
  },
  filename:function(req,file,cb){//指定文件名
    let name=file.originalname;
    let ext=name.substr(name.lastIndexOf('.'));
    cb(null,uuid.v4()+ext);
  }
})
const uploadTools=multer({storge:obj})
//文件上传请求
server.post('/upload',uploadTools.array('uploadFile'),(req,res)=>{
  console.log(req.body);
  console.log(req.files);
  let imgname=`/image/${res.files[0].filename}`;
  let uid = parseInt(req.files[0].originalname);
  if(req.files){
    pool.query('update users set uphoto=? where uid=?',[imgname,uid],(err,result)=>{
      console.log(result);
      if(err){
        if(err.sqlState=='23000'){
          res.send({
            code:403,
            msg:'上传失败，请再试一次'
          })
        }
        next(err);
        return;
      }
      if(!result.affectedRows){
        res.send({
          code:405,
          msg:'上传失败'
        })
      }else{
        res.send({
          code:201,
          msg:'上传成功',
          img:imgname
        })
      }
      
    })
  }else{
    res.send({code:500,msg:'上传失败'})
  }
})
//************************************ *//

// 获取商品所有信息
server.get('/searchbar', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM goods_details ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});
server.get('/single', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM goods_details where id%2=1 ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});
server.get('/odd', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM goods_details where id%2=0 ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 获取商品所有信息
server.get('/cakes', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM goods_details where category_id=5';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 获取热门所有信息
server.get('/recommend', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM goods_details WHERE category_id=9';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 分类接口
server.get('/category', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT id,category_name FROM goods_category ORDER BY id';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});


// 商品分页显示
server.get('/goods', (req, res) => {
  // 获取客户端传递的cid参数
  let cid = req.query.cid;

  // 获取客户端传递的page参数
  let page = req.query.page? req.query.page : 1;

  // 存储每页显示的记录数
  let pagesize = 20;

  // 通过公式来计算从第几条记录开始返回
  let offset = (page - 1) * pagesize;

  // 用于存储获取到的总记录数
  let rowcount;

  // 获取指定分类下的文章总数
  let sql = 'SELECT COUNT(id) AS count FROM goods_details WHERE category_id=?';

  pool.query(sql, [cid], (error, results) => {
    if (error) throw error;
    // 将获取到总记录数赋给rowcount变量
    rowcount = results[0].count;
    /**************************************************/
    // 根据总记录数和每页显示的记录数来计算总页数
    let pagecount = Math.ceil(rowcount / pagesize);

    // 查询SQL语句
    sql = 'SELECT id,goods_name,goods_price,goods_img FROM goods_details WHERE category_id=? LIMIT ?,?';
    // 执行SQL
    pool.query(sql, [cid, offset, pagesize], (error, results) => {
      if (error) throw error;
      res.send({ message: 'ok', code: 200, results: results, pagecount: pagecount });
    });

    /**************************************************/
  });

});


// 获取商品详情
server.get('/detail', (req, res) => {
  //获取地址栏中的id参数
  let id = req.query.id;

  // SQL查询
  let sql = "SELECT id,goods_name,goods_price,goods_img,love FROM goods_details WHERE id=?";

  // 执行SQL查询
  pool.query(sql, [id], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});

// 获取积分商品详情
server.get('/jscorecards', (req, res) => {
  //获取地址栏中的id参数
  let scid = req.query.scid;

  // SQL查询
  let sql = "SELECT scid,sc_name,sc_surplus,sc_img,sc_time FROM scorecard WHERE scid=?";

  // 执行SQL查询
  pool.query(sql, [scid], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});
// 获取签到接口
server.get('/sign', (req, res) => {
  //获取地址栏中的id参数
  let uid = req.query.uid;

  // SQL查询
  let sql = "SELECT sign,signtime,status FROM users WHERE uid=?";

  // 执行SQL查询
  pool.query(sql, [uid], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});

///订单接口
server.post('/orders',(req,res) => {
  let order_img=req.body.order_img;  
  let order_name=req.body.order_name;
  let order_wendu=req.body.order_wendu;
  let order_sug=req.body.order_sug;
  let order_num=req.body.order_num;
  let money=req.body.money;
   let pay_time=req.body.pay_time;
   let uname=req.body.uname;
      sql = 'INSERT orders(order_img,order_name,order_wendu,order_sug,order_num,money,pay_time,uname) VALUES(?,?,?,?,?,?,?,?)';
      pool.query(sql, [order_img,order_name,order_wendu,order_sug,order_num,money,pay_time,uname], (error,results) => {
        if (error) throw error;
        res.send({ message: 'ok', code: 200 });
      })
});


// 获取所有订单详情
server.get('/all', (req, res) => {
    
  // SQL查询
  let sql = "SELECT * FROM orders order by order_id";

  // 执行SQL查询
  pool.query(sql, (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results});
  });

});
// 获取订单详情
server.get('/allorders', (req, res) => {
  let uname= req.query.uname;  
  // SQL查询
  let sql = "SELECT uname,order_img,order_name,order_wendu,order_sug,pay_time,money,order_num FROM orders WHERE uname=?";

  // 执行SQL查询
  pool.query(sql, [uname], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results});
  });

});

//修改商品信息
server.put("/update",(req,res)=>{
	var obj=req.body;
	var sql="update goods_details set goods_name=?,goods_price=?,goods_img=? where id=?";
	pool.query(sql,[obj.goods_name,obj.goods_price,obj.goods_img,obj.id],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send("1");
		}else{
			res.send("0");
		}
	});
});

// 获取轮播图的接口
server.get('/slideshow', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM slideshow ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});
// 获取积分商品的接口
server.get('/scorecard', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM scorecard ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 获取会员的接口
server.get('/huser', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT uid,uphone,uphoto,sex,uname,nickname,adress FROM users ';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});


// 领取优惠券接口
server.get('/coupon', (req, res) => {
  // SQL查询
  let sql = "SELECT yid,ytitle,pri,day,isling,btn FROM coupon ORDER BY yid";

  // 执行SQL查询
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 卡包接口
server.post("/kabao",(req,res)=>{
	 let uid = req.body.uid;
    let mon= req.body.mon;
    let ktitle= req.body.ktitle;
     let kday= req.body.kday;
    let lasttime= req.body.lasttime; 
    let sql="insert kabao(uid,mon,ktitle,kday,lasttime) values(?,?,?,?,?)";
  pool.query(sql,[uid,mon,ktitle,kday,lasttime],(err,result)=>{
		if(err) throw err;
	    res.send({ message: 'ok', code: 200 });
	});
});

server.put('/ss',(req,res,next)=>{
  //3.1获取流传递的数据
  let uid=req.body.uid;
//   console.log(obj);
  //3.2验证各项数据是否为空
  //循环获取每个属性

  //3.3执行SQL命令
  pool.query('update users set status=0 where uid=?',[uid],(err,result)=>{
    if(err){
	  next(err);
	  return;
	}
	console.log(result);
	//结果是对象，判断对象下的affectedRows属性，如果是0说明修改失败，否则修改成功
	if(result.affectedRows===0){
	  res.send({code:201,msg:'修改失败'});
	}else{
	  res.send({code:200,msg:'修改成功'});
	}
  });
});

// 修改商品信息接口
server.put('/xiugai',(req,res,next)=>{
  //3.1获取流传递的数据
  let id=req.body.id;
  //3.2验证各项数据是否为空
  //循环获取每个属性

  //3.3执行SQL命令
  pool.query('update goods_details set love=1 where id=?',[id],(err,result)=>{
    if(err){
	  next(err);
	  return;
	}
	console.log(result);
	//结果是对象，判断对象下的affectedRows属性，如果是0说明修改失败，否则修改成功
	if(result.affectedRows===0){
	  res.send({code:201,msg:'修改失败'});
	}else{
	  res.send({code:200,msg:'修改成功'});
	}
  });
});


// 查询收藏接口
server.get('/loves', (req, res) => {
  // SQL查询
  let sql ="SELECT * FROM goods_details WHERE love=1";

  // 执行SQL查询
  pool.query(sql, (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results });
  });

});


// 指定服务器对象监听的端口号
server.listen(3000, () => {
  console.log('server is running...');
});