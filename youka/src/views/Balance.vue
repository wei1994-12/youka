<template>
<div>
    <!-- nav -->
    <van-nav-bar
    title="账户余额"
    left-text="返回"
    left-arrow
    @click-left="onClickLeft"
    />
    <!-- main -->
    <van-row class="main">
        <van-col span="24" align="center">
            <div class="main_1">
            <p>{{yu}}</p>
            <span>总余额(元)</span>
            </div>
        </van-col>
    </van-row>
    <van-row >
        <van-col span="12" align="center" justify="center" >
            <div>
                <p>{{yu}}</p>
                <span>可用余额(元)</span>
            </div>
        </van-col>
        <van-col span="12" align="center" justify="center">
            <div>
                <p>0</p>
                <span>冻结余额(元)</span>
            </div>
  </van-col>
    </van-row>
    <van-button class="button" type="primary" block color="#7ca7d2" @click="add">一键充值</van-button>
</div>    
</template>
<script>
export default {
    data(){
        return{
            yu:100
        }
    },
    methods:{
        onClickLeft() {
        this.$router.push('./me')
    },
    add(){
        this.yu+=100;
    }
    }
}
</script>
<style scoped>
    .van-col--24 {
    width: 100%;
    height: 140px;
    background-color: #23467a;
    color:#fff;
        }
    .van-col--24 p{
        font-size: 40px;
        margin-top: 40px;
    }    
   
    .van-col--12 div{
    border: 1px solid #23467a;
    height: 50px;
    background-color: #2d5387;
    color: #fff;
    }
    .van-col--12 p{
       margin-top: 10px; 
    }
    .button{
        margin: 40px auto 0 auto;
        width: 95%;
    }
</style>
