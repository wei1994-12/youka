<template>
  <div class="shouye">
    <!-- 轮播图 -->
    <van-swipe :autoplay="3000">
      <van-swipe-item class="my-swipe" :show-indicators="false" touchable>
        <img src="../assets/lb1.jpg" alt="" />
      </van-swipe-item>
      <van-swipe-item class="my-swipe" :show-indicators="false" touchable>
        <img src="../assets/lb2.jpg" alt="" />
      </van-swipe-item>
      <van-swipe-item class="my-swipe" :show-indicators="false" touchable>
        <img src="../assets/lb3.jpg" alt="" />
      </van-swipe-item>
    </van-swipe>
    <div class="center">
      <!-- 详情 -->
      <div class="cute">
        <div><router-link to="/menu"><img src="../assets/cute1.png" alt="" /></router-link>
        </div>
        <div><router-link to="/https://waimai.meituan.com/"><img src="../assets/cute2.png" alt="" /></router-link></div>
      </div>
      <!-- 会员 -->
      <div class="huiyuan">
        <div class="hui1">
          <h4 @click="yao">邀请有礼</h4>
          <h6 class="zt">立得20元</h6>
        </div>
        <div class="hui2">
          <h4>送礼品卡</h4>
          <h6 class="zt">传情达意</h6>
        </div>
      </div>
      <!-- 优惠券 -->
      <div class="tuijian">
        <div class="new">
          <h3>新人专享优惠</h3>
          <div  class="h4" @click="alljuan">查看新人全部券包</div> 
        </div>
        <div class="money">
          <div class="xin">
            <h4>￥20</h4>
            <h6>新人饮品抵用金</h6>
            <br />
            <h6>5天有效</h6>
          </div>
          <div class="ren">
            <h4>￥20</h4>
            <h6>新人解锁饮品抵用金</h6>
            <h6>下3单可以解锁</h6>
            <h6>15天有效</h6>
          </div>
        </div>
      </div>
      <!-- 推荐 -->
      <div class="ttp">
            <h3>推荐TOP</h3>
      </div>
      <div class="allcards">
        <div class="top">
            <div class="s-card" v-for="(item,i) in odd" :key="i">
                <router-link :to="`/details?id=${item.id}`">
                  <img :src="item.goods_img" alt="">
                  <div class="top-text">
                    <h4>{{item.goods_name}}</h4>
                    <h5>￥{{item.goods_price}}</h5>
                  </div>
                </router-link>
            </div>
        </div>
        <div class="top">
            <div class="s-card" v-for="(item,i) in single" :key="i">
                <router-link :to="`/details?id=${item.id}`">
                  <img :src="item.goods_img" alt="">
                  <div class="top-text">
                    <h4>{{item.goods_name}}</h4>
                    <h5>￥{{item.goods_price}}</h5>
                  </div>
                </router-link>
            </div>
        </div>
      </div>
      <!-- 底部导航 -->
    </div>
    <!-- 底部导航 -->
        <van-tabbar v-model="active" active-color="rgb(8, 24, 235)" class="bottom-bar">
            <van-tabbar-item icon="home-o">首页</van-tabbar-item>
            <van-tabbar-item icon="orders-o">菜单</van-tabbar-item>
            <van-tabbar-item icon="gift-o">积分</van-tabbar-item>            
            <van-tabbar-item icon="shopping-cart-o" :badge="count">购物车</van-tabbar-item>
            <van-tabbar-item icon="user-o">我的</van-tabbar-item>
        </van-tabbar>
  </div>
</template>
<script>
export default {
  data() {
    return {
        active:0,
        count:this.$store.state.list.length,
        single:[],
        odd:[],
        page:1, 
    };
  },
  methods: {
    yao(){
      this.$router.push('/yao')      
    },
    alljuan(){
      this.$router.push('/huiyuan')
    },
    loadGoods(){
       this.axios.get(`/single`)
      .then(result=>{
        console.log(result);
        this.single=result.data.results;
        console.log(this.single);
      })
      this.axios.get(`/odd`)
      .then(result=>{
        console.log(result);
        this.odd=result.data.results;
        console.log(this.odd);
      })
    },
  },
  watch:{
    active(newval){
      if(newval==1){
          this.$router.push('/menu');         
      }else if(newval==2){
          this.$router.push('/fen'); 
      }else if(newval==3){
          this.$router.push('/cart');         
      }else if(newval==4){
          this.$router.push('/me');         
      }
    }
  },
  mounted(){
    this.loadGoods();  
    this.axios.get("/coupon").then((result) => {
      // console.log(result)
      this.coupons = result.data.results;
    });   
  }
};
</script>
<style scoped>
* {
  margin: 0;
  padding: 0;
}
.shouye .my-swipe {
  height: 211px;
}
.shouye .my-swipe img {
  width: 100%;
}
.shouye {
  background-color: #ddd;
}
.shouye .cute {
  background-color: white;
  width: 90%;
  margin: 0 auto;
  display: flex;
  border-radius: 5px;
  justify-content: space-around;
  padding-top: 40px;
  padding-bottom: 10px;
}
.shouye .center {
  position: relative;
  top: -30px;
  margin-bottom: 25px;
}
.shouye .huiyuan {
  width: 90%;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  border-radius: 5px;
  margin-top: 10px;
}
.shouye .hui1 {
  width: 43%;
  border-radius: 5px;
  background-color: white;
  padding: 3%;
}
.shouye .hui2 {
  width: 43%;
  border-radius: 5px;
  background-color: white;
  padding: 3%;
}
.shouye .hui1 .zt {
  font-size: 10px;
  color: #fff;
  background-color: red;
  width: 40%;
}
.shouye .hui2 .zt {
  font-size: 10px;
  color: rgb(145, 141, 141);
}
.shouye .tuijian {
  background-color: rgb(238, 93, 93);
  width: 84%;
  /* height: 300px; */
  margin: 0 auto;
  justify-content: space-between;
  margin-top: 20px;
  border-radius: 5px;
  color: white;
  padding-top: 10px;
  padding-bottom: 10px;
  padding: 3%;
}
.shouye .tuijian .xin {
  background-color: rgb(241, 224, 198);
  height: 70px;
  width: 41%;
  color: rgb(179, 133, 66);
  padding: 3%;
  border-radius: 5px;
}
.shouye .tuijian .ren {
  background-color: rgb(241, 224, 198);
  height: 70px;
  width: 41%;
  color: rgb(179, 133, 66);
  padding: 3%;
  border-radius: 5px;
}
.shouye .tuijian .new {
  display: flex;
  justify-content: space-between;
}
.shouye .tuijian .new .h4{
  color: #fff;
}
.shouye .tuijian .money {
  display: flex;
  justify-content: space-between;
  margin-top: 6px;
}
.shouye .allcards{
   display: flex;
  justify-content: space-between;
  width: 96%;
  margin: 0 auto;
  /* text-align: center; */
}
.shouye .top{
    width: 90%;
    /* display: flex;
    justify-content: space-between; */
    /* margin: 0 auto; */
    background-color: rgb(232, 232, 243);
    /* margin-top: 20px; */
    overflow: hidden;
}
.shouye .ttp{
  color: tomato;
  font-size: 18px;
  padding-left: 20px;
  margin-top: 10px;
  margin-bottom: 10px;

}
.shouye .top .s-card{
  width: 94%;
  /* float: left; */
  margin-bottom: 10px;
  background-color: white;
  border-radius: 5px;
}
.shouye .top .s-card img{
  width: 100%;
  border-radius: 5px;
}

/* .shouye .top .s-card:nth-child(odd){
  margin-right: 4%;
} */
.shouye .top .top-text{
  /* display: flex;
  justify-content: space-between; */
  padding: 10px;
}
.shouye .top .top-text h5{
  color: tomato;
  font-size: 16px;
}

.shouye .top .top-text h4{
  color:black;
}
.shouye .bottom-bar{
  border-top: 1px solid black;
}
</style>