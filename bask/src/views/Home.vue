<template>
  <div class="index">
    <el-container>
      <el-aside width="200px"
        ><el-row class="tac" style="position:fixed;height:830px;width:221px">
          <el-col :span="24">
            <el-menu
              router
              default-active="/"
              class="el-menu-vertical-demo"
              background-color="#545c64"
              text-color="#fff"
              active-text-color="#ffd04b"
            >
              <el-menu-item index="/home">
                <i class="el-icon-menu"></i>
                <span slot="title">会员列表</span>
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
                <span slot="title">订单管理</span>
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
            <el-menu-item
              class="el-menu-demo"
              mode="horizontal"
              style="float: left"
              >后台管理系统</el-menu-item
            >
            <el-menu-item class="hy">欢迎:wylsp</el-menu-item>
            <el-menu-item class="tc"
              ><a href="#" @click="tuichu">退出</a></el-menu-item
            >
          </el-menu></el-header
        >
        <el-main>
          <el-table :data="hy" border  style="overflow-y: scroll; position:fixed; top: 75px; left:255px; right:0px; bottom:55px;" >
            <el-table-column fixed prop="uid" label="会员编号" width="150">
            </el-table-column>
            <el-table-column label="性别" width="120">
              <template slot-scope="scope">
                <span style="margin-left: 10px">{{
                  scope.row.sex == 1 ? "男" : "女"
                }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="uphone" label="电话" width="120">
            </el-table-column>
            <el-table-column  label="头像" width="120">
               <template slot-scope="scope">
                 <img style="width: 100px;height: 100px;" :src="scope.row.uphoto" alt="">
               </template>
            </el-table-column>
            <el-table-column prop="adress" label="地址" width="200">
            </el-table-column>
            <el-table-column prop="nickname" label="别名" width="120">
            </el-table-column>
            
           
          </el-table>
        </el-main>
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
      dh: [],
      wid: "",
      goods: [],
      hy: [],
    };
  },
  mounted() {
    this.axios.get("/category").then((result) => {
      this.dh = result.data.results;
    });
    this.axios.get("/huser").then((result) => {
      this.hy = result.data.results;
      console.log(this.hy)
    });
  },
  methods: {
        tuichu(){
          this.$router.push("/login");
        sessionStorage.removeItem("username");
        },
    productlist: function () {
      this.$router.push("/productlist");
    },

    aa(newval) {
      this.axios.get(`/goods?cid=${newval + 1}&page=1`).then((result) => {
        this.goods = result.data.results;
        console.log(goods);
      });
    },
    handleClick(row) {
      console.log(row);
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