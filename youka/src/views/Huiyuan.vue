<template>
    <div class="huiyuan">
        <van-nav-bar
          title="福利中心"
          left-text="" 
          left-arrow
          @click-left="onClickLeft"/>
        <!-- 优惠券 -->
        <div class="hb" v-for="(item,i) in coupons" :key="i">
           <div class="img"><img src="../assets/hong1.png" alt=""></div>
            <div class="bao">
                <h2>{{item.ytitle}}</h2>
                <h4>￥{{item.pri}}</h4>
                <h6>领取时间:2021-7-21</h6>
            </div>
            <div class="btn"><button @click="ling(i)">立即领取</button></div>
        </div>

        <div class="kabao">
            <div class="qu">
                <h4>优惠券领取情况</h4>
            </div>
            <div class="kong">
                <h5>卡包空空如也，快来领取优惠券吧~</h5>
            </div>
        </div>
    </div>
</template>
<script>
import {mapState} from "vuex"
import { Toast } from 'vant';
import { setTimeout } from 'timers';
export default {
  data() {
    return {
        coupons:[],
        
    };
  },
  methods: {
    onClickLeft() {
       this.$router.go(-1);  
    },
    loadCoupon(){
      this.axios.get("/coupon").then((result) => {
      console.log(result)
       this.coupons = result.data.results;
      });    
    },
    ling(i){
        Toast.success('领取成功');
        let hb=document.getElementsByClassName("hb")[i]
        console.log(hb);
        hb.lastChild.firstChild.innerHTML="已领取";
         let uid=sessionStorage.getItem('uid');
            console.log(uid)                   
        this.axios.post(`/kabao/?uid=${uid}&mon=20`).then((result) => {
            console.log(result)          
        //    console.log(this.coupons[i].pri,this.coupons[i].ytitle)
        // this.coupons = result.data.results;
       });      
    },
  },
   mounted(){
    this.loadCoupon();
  },
   computed:{
    ...mapState(["uid"]),
    //相当于:
    //uname(){ ... }
   },
};
</script>
<style>
* {
  margin: 0;
  padding: 0;
} 
.huiyuan{
    background-color: rgb(232, 232, 243);
}

.huiyuan .hb {
    display: flex; 
    justify-content: space-between; 
    width: 95%;  
    border-radius: 5px;
    margin: 0 auto;
    background-color: rgb(255, 255, 255);
    padding-top: 20px;
    padding-bottom: 20px;
    margin-top: 20px;
    position: relative;
    top:10px;
} 
.huiyuan .hb .img{
    padding-left: 10px;
    padding-right: 10px;
}
.huiyuan .hb .btn{
    padding-top: 10px;
    padding-right: 10px;
}
.huiyuan .hb button{
    margin-top: 35px;
    height: 30px;
    width: 90px;
    background-color: rgb(105, 95, 241);
    border-radius: 20px;
    color:#fff;
    border: 0;
}
.huiyuan .hb .bao{
    width: 200px;
    position: relative;
    left: -10px;
    padding-top: 4px;
}
.huiyuan .hb .bao h4{
    color: rgb(211, 105, 73);
}
.huiyuan .hb .bao h2{
    font-size: 18px;
}
.huiyuan .hb .bao h6{
    color: rgb(158, 153, 152);
}
.huiyuan .kabao{
    width: 95%;  
    height: 120px;
    border-radius: 5px;
    margin: 0 auto;
    background-color: white;
    padding-top: 20px;
    padding-bottom: 20px;
    margin-top: 20px;
    top:10px;
}
.huiyuan .kabao .qu{
    margin-left: 10px;
}
.huiyuan .kabao h4{
    color: rgb(224, 142, 142);
}
.huiyuan .kabao h5{
    color: rgb(129, 141, 155);
}
.huiyuan .kabao .kong{
    margin-top: 20px;
    margin-left: 30px;
}
.huiyuan .hb .c_active{
    background-color: rgb(145, 143, 143);
}
</style>