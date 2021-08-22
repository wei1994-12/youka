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
  user: 'root',        //数据库用户的用户名
  password: '',        //数据库用户密码
  database: 'moumou',    //数据库名称
  connectionLimit: 20, //最大连接数
  charset: 'utf8'      //数据库服务器的编码方式
});

// 创建服务器对象
const server = express();

server.use(bodyParser.urlencoded({
  extended: false
}));


// 加载CORS模块
const cors = require('cors');

// 使用CORS中间件
server.use(cors({
  origin: ['http://localhost:8080', 'http://127.0.0.1:8080']
}));


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
  let sql = "SELECT id,goods_name,goods_price,goods_img FROM goods_details WHERE id=?";

  // 执行SQL查询
  pool.query(sql, [id], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});


server.get('/isExist', (req, res) => {
  let goods_id= req.query.goods_id;
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT * FROM cart where goods_id=?';
  // 执行SQL语句
  pool.query(sql,[goods_id],(error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});


server.post("/cart",(req,res)=>{
	var obj=req.body;
	var sql="insert into cart(goods_id,goods_name,goods_price,goods_img,goods_count) values(?,?,?,?,?)";
	pool.query(sql,[obj.goods_id,obj.goods_name,obj.goods_price,obj.goods_img,obj.goods_count],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send("1");
		}else{
			res.send("0");
		}
	});

});

// 指定服务器对象监听的端口号
server.listen(3000, () => {
  console.log('server is running...');
});