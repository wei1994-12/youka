<template>
  <div class="index">
    <el-container>
      <el-aside width="200px"
        >  <el-row class="tac" style="height: 800px">
          <el-col :span="24">
            <el-menu
              default-active="/"
              class="el-menu-vertical-demo"
              router
              background-color="#545c64"
              text-color="#fff"
              active-text-color="#ffd04b"
            >
              <el-menu-item index="/home">
                <i class="el-icon-menu"></i>
                <span slot="title" >会员列表</span>
              </el-menu-item>
              <el-submenu index="order">
                <template slot="title">
                  <i class="el-icon-location"></i>
                  <span>菜单管理</span>
                </template>
                <el-menu-item-group>
                  <el-menu-item index="Sy">生椰家族</el-menu-item>
                  <el-menu-item index="Xr">夏日冰咖</el-menu-item>
                  <el-menu-item index="Rbl">瑞纳冰</el-menu-item>
                  <el-menu-item index="Ds">大师咖啡</el-menu-item>
                  <el-menu-item index="Tp">甜品小点</el-menu-item>
                  <el-menu-item index="Yq">元气满满</el-menu-item>
                  <el-menu-item index="Yz">颜值水杯</el-menu-item>
                  <el-menu-item index="Gd">糕点零食</el-menu-item>
                </el-menu-item-group>
              </el-submenu>
              <el-menu-item index="productlist">
                <i class="el-icon-document"></i>
                <span slot="title" >订单管理</span>
              </el-menu-item>
              <el-menu-item index="4">
                <i class="el-icon-setting"></i>
                <span slot="title">实时聊天</span>
              </el-menu-item>
            </el-menu>
          </el-col>
        </el-row>
      </el-aside>
      <el-container>
        <el-header>
          <div class="line"></div>
          <el-menu
            :default-active="activeIndex2"
            class="el-menu-demo"
            mode="horizontal"
           
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#ffd04b"
          >
            <el-menu-item  class="el-menu-demo"
      mode="horizontal" style="float:left">后台管理系统</el-menu-item>
            <el-menu-item class="hy">欢迎</el-menu-item>
            <el-menu-item class="tc"><a href="#" @click="tuichu()">退出</a></el-menu-item>
          </el-menu></el-header
        >
        <el-main >
          <el-table :data="p" border  style="width: 100%;height:500px">
            <el-table-column fixed prop="id" label="商品ID" width="80">
            </el-table-column>
            <el-table-column prop="category_name" label="名称" width="150">
            </el-table-column>
            <el-table-column prop="splb" label="商品类别" width="120">
            </el-table-column>
            <el-table-column prop="tp" label="图片" width="120">
            </el-table-column>
            <el-table-column prop="jg" label="价格" width="120">
            </el-table-column>
            <el-table-column prop="spxq" label="商品详情" width="120">
            </el-table-column>
            <el-table-column prop="zffs" label="XXXX" width="120">
            </el-table-column>
            
            <el-table-column fixed="right" label="查看详情" width="100">
              <template slot-scope="scope">
                <el-button
                  @click="handleClick(scope.row)"
                  type="text"
                  size="small"
                  >查看</el-button
                >
                <el-button type="text" size="small">编辑</el-button>
              </template>
            </el-table-column>
          </el-table></el-main
        >
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeIndex: "1",
      activeIndex2: "1",
      p:[],
    //       tableData:[{
    //   spid:0,
    //   mc:"",
    //   splb:"",
    //   tp:"" ,
    //   jg:"",
    //   spxq:"",
    //   zffs:""
      
    // },
    // ],
     
    };
  },
  
  mounted(){
    this.axios.get("/category").then((result)=>{
        console.log(result.data)
        this.p = result.data.results;
       
       
      })
  },
  methods: {

    
      
      
    
  },
};
</script>

<style scoped>
div.tac.el-row {
  background-color: #545c64;
}
.el-menu--horizontal > .el-menu-item {
  float: right;
  font-size: 20px;
}

</style>