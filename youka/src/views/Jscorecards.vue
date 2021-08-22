<template>
  <div class="jscorecards">
    <van-nav-bar
      :title="goods.sc_name"
      left-text="返回"
      left-arrow
      @click-left="onClickLeft"
    />
    <div style="overflow-y: scroll; position:fixed; top: 35px; left:0px; right:0px; bottom:55px;">
      <van-swipe>
        <van-swipe-item
          class="my-swipe"
          :show-indicators="false"
          touchable
        >
          <img :src="goods.sc_img" />
        </van-swipe-item>
      </van-swipe>
      <van-panel
        :title="goods.sc_name"
        default="123"
        status="每月限兑换一次"
      >
        <div> &nbsp;&nbsp;&nbsp;领用有效期：</div>
        <span>&nbsp;&nbsp;&nbsp;{{goods.sc_time}}</span><br>
        <span>&nbsp;&nbsp;1、哞哞饮品积分商城可直接用个人账户积分来兑换物品，使用积分兑换产品，即从账户上扣除相应的积分。<br>
          &nbsp;&nbsp;2、物品兑换成功后，哞哞饮品将在5个工作日内安排发货。实物礼品将安排第三方快递发货。<br>
          &nbsp;&nbsp;3、所有积分商城消耗的积分，并不影响账户等级。<br>
          &nbsp;&nbsp;4、积分兑换产品属回馈活动，非质量问题恕不退换。<br>
          &nbsp;&nbsp;5、如用户所获得的积分被平台发现是通过非正常手段获得，则该用户的积分商城订单将被视为无效订单；该用户账号也会进行封禁处理。<br>
          &nbsp;&nbsp;6、客服专线：0515-83119119（周一~周五9:00~17:00）</span>
      </van-panel>
    </div>
    <van-dialog
      v-model="show"
      title="已支付"
    >
    <img :src="goods.sc_img" class="jimg"/>
    </van-dialog>
    <van-submit-bar
      @submit="onSubmit"
      v-if="zhifu==true"
      :price="goods.sc_surplus*100"
      button-text="立即支付"
      label="支付积分："
      currency=""
      decimal-length=""
    />
    <van-submit-bar
      button-color="green"
      disabled
      v-else
      button-text="已支付"
      label="支付积分："
      currency=""
      decimal-length=""
    />
  </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data() {
    return {
      goods: {},
      zhifu: true,
      show: false
    }
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
    },
    onClickRight() {
      Toast('按钮');
    },
    onSubmit() {
      let score=sessionStorage.getItem("score")
      console.log(score);
      this.zhifu = false
      this.show=true
    },
    

  },
  mounted() {
    let scid = this.$route.query.scid;
    // console.log('从列表页传过来的id，如果是undefined，那就是没传：'+id);
    this.axios.get(`/jscorecards?scid=${scid}`).then(result => {
      console.log(result);
      this.goods = result.data.result;
      // this.goods.goods_img=require(`../assets/${this.goods.goods_img}`)                        
    })
  },


};
</script>
<style scoped>
.my-swipe img {
  height: 370px;
}
.van-submit-bar__button--danger {
  width: 180px;
}
.van-submit-bar__text {
  text-align: left;
  font-size: 18px;
}
.jimg {
  width: 340px;
  height: 340px;
}
</style>