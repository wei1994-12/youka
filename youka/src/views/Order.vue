<template>
  <div class="wo">
    
    <!-- nav -->
    <van-nav-bar title="我的订单" left-text="返回" left-arrow @click-left="onClickLeft"/>
    <!-- 订单分类 -->
    <!-- <div class="order">
      <div
        v-for="(item, i) in arr"
        :key="i"
        :class="{ c_active: i == active }"
        @click="changeClass(i)"
      >
        {{ item }}
      </div>
    </div>   -->
    <div class="card" v-for="(item,i) in allorders" :key="i">
      <div class="shang">
        <div class="img"><img :src="item.order_img" alt="" /></div>
        <div class="ding">
          <h5>{{item.order_name}}</h5>
          <h6>{{item.order_wendu}}/{{item.order_sug}}</h6>
        </div>
        <div class="dan">x{{item.order_num}}</div>
      </div>
      <div class="dd">
        <div class="liu"><h6>{{item.pay_time}}</h6></div>
        <div class="heji"><h6>共{{item.order_num}}件商品 合计：￥{{item.money}}</h6></div>
      </div>
    </div>
    
  </div>
</template>
<script>
import {mapState} from "vuex"
export default {
  data() {
    return {
      // arr: ["全部", "立等可取", "预约订单"],
      active: 0,
      allorders:[]
    };
  },
  methods: {
    onClickLeft() {
            this.$router.go(-1);                       
    },
    changeClass(i) {
      this.active = i;
    },
  },
  mounted(){

     this.axios.get(`/allorders?uname=${this.uname}`).then(result=>{
            console.log(result);
            this.allorders=result.data.result;
        })   
  },
   computed:{
    ...mapState(["uname"]),
    //相当于:
    //uname(){ ... }
   },
};
</script>

<style scoped>
.wo .order {
  height: 46px;
  width: 95%;
  background-color: #6d86c4;
  border-radius: 30px;
  margin: 0 auto;
  text-align: center;
  line-height: 46px;
  font-size: 12px;
  display: flex;
}
.wo .order div {
  height: 40px;
  width: 33%;
  color: #fff;
}

.wo .order .c_active {
  border-radius: 30px;
  background-color: #fff;
  margin: auto 3px;
  color: black;
}
.wo .card .shang{
  display: flex;
  width: 95%;
  margin: 0 auto;
  position: relative;
}
.wo .card{
  width: 95%;
  background-color: rgb(245, 244, 244);  
  margin: 0 auto;
  padding-top: 5px;
  margin-top: 20px;
  padding-bottom: 15px;
  border-radius: 5px;
   
}
.wo .card .img {
  width: 25%;
  padding-top: 10px;
  padding-bottom: 8px;
  justify-content: space-between;
  padding-left: 5px;
}
.wo .card .img img {
  width: 100%;
  border-radius: 5px;  
}
.wo .card .ding {
  width: 70%;
  padding-top: 20px;
  margin-left: 15px;
}
.wo .card .dan {
  width: 15%;
  /* padding-left: 60px; */
  padding-top: 23px;
  /* margin-left: 100px; */
}
.wo .card .ding h6 {
  color: rgb(122, 114, 114);
  padding-top: 3px;
  font-size: 10px;
}
.wo .card .ding h5 {
  font-size: 16px;
}
.wo .dd {
  padding-top: 5px;
  width: 94%;
  margin: 0 auto;
  justify-content: space-between;
  position: relative;
  display: flex;
  background-color: rgb(245, 244, 244);  
}
.wo .dd .liu{
    width: 45%;
    font-size: 18px;
    color: rgb(110, 104, 104);
    padding-top: 3px;
}
.wo .dd .heji h6{
  font-size: 14px;
  font-weight: normal;
}
</style>
