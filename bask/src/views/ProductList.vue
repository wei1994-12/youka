<template>
  <div class="index">
    <el-container>
      <el-aside width="200px"
  ><el-row class="tac" style="position:fixed;height:830px;width:221px">
          <el-col :span="24">
            <el-menu
              default-active="2"
              class="el-menu-vertical-demo"
             router
              background-color="#545c64"
              text-color="#fff"
              active-text-color="#ffd04b"
            >
              <el-menu-item index="/home">
                <i class="el-icon-menu"></i>
                <span slot="title" @click="index">会员列表</span>
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
              <el-menu-item index="productList">
                <i class="el-icon-document"></i>
                <span slot="title" >订单管理</span>
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
            <el-menu-item class="hy">欢迎:wylsp</el-menu-item>
            <el-menu-item class="tc"><a href="#" @click="tuichu">退出</a></el-menu-item>
          </el-menu></el-header
        >
        <el-main>
          <el-table :data="dd" border style="overflow-y: scroll; position:fixed; top: 75px; left:255px; right:0px; bottom:55px;">
            <el-table-column fixed prop="order_id" label="订单ID" width="80">
            </el-table-column>
            <el-table-column  label="图片" width="150">
               <template slot-scope="scope">
                 <img :src="scope.row.order_img" alt="">
               </template>
            </el-table-column>
            <el-table-column prop="order_name" label="商品名称" width="180">
            </el-table-column>
            <el-table-column prop="uname" label="客户ID" width="120">
            </el-table-column>
            
            <el-table-column prop="order_sug" label="甜度" width="120">
            </el-table-column>
            <el-table-column prop="pay_time" label="下单时间" width="200">
            </el-table-column>
            <el-table-column prop="money" label="总金额" width="120">
            </el-table-column>
            <el-table-column  label="支付状态" width="120">
              <template slot-scope="scope">
                <span style="margin-left: 10px">{{
                  scope.row.status == 2  ? "未支付" : "已支付"
                }}</span>
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
      dd:[]
     
    };
  },
  mounted(){
    this.axios.get("/all").then((result) => {
      this.dd = result.data.result;
      console.log(this.dd)
    });
  },
  methods: {
      tuichu(){
          this.$router.push("/login");
        sessionStorage.removeItem("username");
        },
   
    index:function(){
      this.$router.push('/')
      },
    
     
      
    
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