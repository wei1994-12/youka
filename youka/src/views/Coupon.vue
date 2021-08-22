<template>
    <div class="coupon">
        <!-- 导航栏-->
        <van-nav-bar title="选择优惠"  left-arrow fixed @click-left="onClickLeft">
        </van-nav-bar>
        <!-- 中心 -->
        <div class="center">
            <div class="cheap-wai" v-for="(item,i) in 3" :key="i">
                <!-- 优惠券 -->
                <div class="cheap">
                    <div class="cheap-new">
                        <div class="cheap-jin">新人饮品抵用金</div>
                        <div class="cheap-time">有效期至2021-7-14</div>
                    </div>
                    <div>
                        <div class="cheap-money">可抵扣￥15</div>
                        <div class="btn-div"><button class="cheap-btn">立即使用</button></div>
                    </div>
                </div>
                <!-- 使用规则 -->
                <van-collapse v-model="activeNames" accordion>
                    <van-collapse-item title="使用规则" :name="i">本券一次使用一张限一件商品；本券不与其他优惠同享。</van-collapse-item>
                </van-collapse>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data(){
        return{
            activeNames: ['1'],
        }
    },
    methods:{
        onClickLeft() {
      this.$router.push('/me');
    },
    }
}
</script>


<style>
   .coupon{
       background-color: #f5f5f5;
       height: 800px;
   }
   .coupon .center{
       width: 95%;
       margin: 0 auto;
       position: relative;
       top:60px;
   }
   .coupon .center .cheap-wai{
       margin-bottom: 10px;
   }
    .coupon .center .cheap{
       background-color: white;  
       border-radius: 10px; 
       display: flex;
       justify-content:space-between;    
       padding-top: 20px;
       /* padding-bottom: 10px;           */
       /* margin-bottom: 10px; */
    }
    .coupon .center .cheap .cheap-new{
        padding-left: 15px;
        padding-top: 5px;           
    }
     .coupon .center .cheap  .cheap-new .cheap-jin{
        font-weight:500;
    }
    .coupon .center .cheap  .cheap-new .cheap-time{
        font-weight: lighter;
        font-size: 12px;
        line-height: 30px;
    }
    .coupon .center .cheap .cheap-money{
        padding-right: 15px;   
        color: tomato; 
        font-size: 18px;
    }
    .coupon .center .cheap .cheap-btn{
        width: 70px;
        height: 25px;
        border: 0;
        background-color: white;
        color: rgb(105, 95, 241);
        border-radius: 15px;
        border: 1px solid rgb(105, 95, 241);
        font-size: 14px;
    }
      .coupon .center .cheap .btn-div{
      padding-left: 13px;
    }
</style>

