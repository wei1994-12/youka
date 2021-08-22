<template>
  <div class="payment">
    <!-- 确定订单导航栏-->
    <van-nav-bar
      title="确定订单"
      left-arrow
      fixed
      @click-left="onClickLeft"
    >
    </van-nav-bar>
    <!-- 等待下单 -->
    <div class="bgc">
      <div class="gold">
        <h4>金牌咖啡师正在等待你下单</h4>
      </div>
    </div>
    <!-- 中心 -->
    <div class="center">
      <!-- 定位 -->
      <div class="adress">
        <div>
          <van-icon
            name="location"
            size="20px"
          />
          <span>仁月天地店</span>
        </div>
        <div></div>
      </div>
      <!-- 买 -->
      <div class="buy">
        <div
          class="choosed"
          v-for="(e,i) in orders"
          :key="i"
        >
          <img
            :src="e.img"
            alt=""
          >
          <div class="text">
            <div class="title">{{e.title}}</div>
            <div class="like">{{e.wendu}}/{{e.sug}}</div>
            <div class="num">x{{e.number}}</div>
          </div>
          <div class="eve-sum">￥{{e.price*e.number}}</div>
        </div>
        <div class="coff">
          <div>咖啡钱包</div>
          <div> 无可用</div>
        </div>
        <div class="youhui">
          <div>优惠券</div>
          <div @click="quan">无可用</div>
        </div>
        <div class="total">
          <div class="hui">共优惠
            <span>￥0</span>
          </div>
          <div class="shi">实付
            <span>￥{{total}}</span>
          </div>
        </div>
      </div>
      <!-- 支付方式-->
      <div class="pay">
        <div>支付方式</div>
        <div>在线支付</div>
      </div>
      <!-- 备注 -->

      <van-cell
        class="bei"
        is-link
        title="备注特殊要求"
        @click="show = true"
      />
      <van-action-sheet
        v-model="show"
        title="订单备注"
      >
        <div class="content">
          <textarea
            name="data"
            rows="5"
            cols="30"
            placeholder="请备注内容"
          ></textarea>

          <van-button
            color="rgb(105, 95, 241)"
            size="large"
            round
          >输入内容</van-button>
        </div>
      </van-action-sheet>
    </div>
    <!-- 付钱 -->
    <div class="gong">
      <div>
        <div class="qian">￥{{total}}</div>
        <div class="you">共优惠￥0</div>
      </div>

      <div class="fu"><button @click="pay">去支付</button></div>
    </div>

  </div>
</template>
<script>
import { mapState } from "vuex"
import { Toast } from 'vant';
import moment from 'moment'
export default {
  data() {
    return {
      show: false,
      // order为用户选择支付的商品数组
      orders: [],
      total: 0,
      oncegoods: []
    }
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
    },
    // 使用优惠券
    quan() {
      this.$router.push('/coupon')
    },
    pay() {
      let now = moment().locale('zh-cn').format('YYYY年MM月DD日 HH:mm:ss');

      this.orders.forEach(item => {
        this.axios.post('/orders',
          `order_img=${item.img}&order_name=${item.title}&order_wendu=${item.wendu}&order_sug=${item.sug}&order_num=${item.number}&money=${item.number * item.price}&pay_time=${now}&uname=${this.uname}`).then(result => {
            console.log(result);
            if (result.data.code == 200) {//
              Toast.success('支付成功');
              let oid = sessionStorage.getItem('oid');
              let arr = oid.split(',');
              arr.forEach(item => {
                this.$store.state.list.splice(item, 1)
              })
            }

          })
      })

    }
  },
  mounted() {
    // 购物车去结算 
    // oid为购物者选中的商品项
    let oid = sessionStorage.getItem('oid');
    let arr = oid.split(',');
    // console.log(arr); 
    arr.forEach(item => {
      console.log(parseInt(item));
      this.orders.push(this.list[parseInt(item)]);
    })
    // console.log(this.order); 
    this.orders.forEach(item => {
      this.total += item.price * item.number;
    })
    console.log(this.uname)
  },
  computed: {
    ...mapState(["list"]),
    ...mapState(["uname"]),
    //相当于:
    //uname(){ ... }
  },
}
</script>

<style scoped>
.payment {
  background-color: #f5f5f5;
  padding-bottom: 20px;
}
.payment .bgc {
  padding-top: 50px;
}
.payment .bgc .gold h4 {
  text-align: center;
  height: 50px;
  line-height: 50px;
  /* color: #8498cc; */
}
.payment .center {
  width: 95%;
  margin: 0 auto;
}
/* 定位 */
.payment .center .adress {
  background-color: white;
  border-radius: 5px;
  padding-left: 10px;
  padding-top: 20px;
  padding-bottom: 20px;
}
/* 买 */
.payment .center .buy {
  background-color: white;
  margin-top: 10px;
  padding: 10px;
}
.payment .center .buy .choosed {
  display: flex;
  margin-bottom: 10px;
}
.payment .center .buy .choosed img {
  width: 50px;
  border-radius: 5px;
  margin-right: 10px;
}
.payment .center .buy .choosed .text {
  /* margin-right: 120px; */
  width: 240px;
}
.payment .center .buy .choosed .like {
  font-weight: lighter;
  font-size: 12px;
}
/* .payment .center .buy .choosed .eve-sum{
       color: tomato;
   } */
.payment .center .buy .coff,
.youhui {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}
.payment .center .buy .total {
  display: flex;
  margin-top: 10px;
  padding-left: 150px;
  padding-top: 10px;
}
.payment .center .buy .total .shi {
  margin-left: 20px;
}
.payment .center .buy .total .shi span {
  font-weight: bold;
}
.payment .center .buy .total .hui span {
  color: orangered;
}

/* 支付方式*/
.payment .center .pay {
  border-radius: 5px;
  margin-top: 10px;
  background-color: white;
  display: flex;
  justify-content: space-between;
  padding-top: 10px;
  padding-bottom: 10px;
  padding-left: 10px;
  padding-right: 10px;
}
/* 备注 */
.payment .center .content {
  padding: 20px 20px 20px;
  text-align: center;
}
.payment .center .content textarea {
  margin-bottom: 20px;
}
.payment .center .bei {
  padding: 10px;
  font-size: 16px;
}
.payment .gong {
  width: 100%;
  background-color: #f5f5f5;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  display: flex;
  justify-content: space-between;
  position: fixed;
  bottom: 0;
  padding-top: 20px;
  padding-bottom: 20px;
}
.payment .gong .qian {
  padding-left: 20px;
  font-size: 20px;
  font-weight: bold;
}
.payment .gong .you {
  padding-left: 20px;
  color: tomato;
}
.payment .gong .fu {
  padding-right: 20px;
  padding-top: 5px;
}
.payment .gong button {
  width: 100px;
  height: 40px;
  border-radius: 25px;
  border: 0;
  background-color: tomato;
  color: white;
  font-size: 20px;
}
</style>