<template>
  <div class="jifen">
    <van-nav-bar
      title="积分商城"
      left-text=""
      @click-left="onClickLeft"
      left-arrow
    />
    <router-link :to="`/sign`">
    <van-swipe>
      <van-swipe-item
        class="my-swipe"
        :show-indicators="false"
        touchable
      >
        <img src="/image/qd.png" />
      </van-swipe-item>
    </van-swipe>
    </router-link>
    <van-notice-bar
      scrollable
      speed=50
      text="
      1.全场积分兑换商品免运费（仅限市内）    
      
      2.若没有你心仪的商品，可致电我司反馈,我司会根据客户需求按实际情况上架到平台
      "
    />
    <!-- 积分商城表 -->
    <div style="overflow-y: scroll; position:fixed; top: 300px; left:0px; right:0px; bottom:55px;">
      <div
        class="sp"
        v-for="(item,index) in scr"
        :key="index"
      >
        <van-card
          :title="item.sc_name"
          :thumb="item.sc_img"
        >
          <template #tags>
            <van-tag
            class="tag"
              type="danger"
            >积分：{{item.sc_surplus}}</van-tag>
            <br><br>
            <van-tag
            class="tag2"
              type="danger"
            >数量：{{item.sc_num}}</van-tag>
          </template>
        </van-card>

        
        <router-link :to="`/jscorecards?scid=${item.scid}`">
        <div class="category"><button
            @click="isShow = true"
            class="btn"
          >立即兑换</button>
         
        </div>
         </router-link>
      </div>
    </div>
    <!-- 底部导航 -->
    <van-tabbar
      v-model="active"
      active-color="rgb(8, 24, 235)"
      class="bottom-bar"
    >
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
      active: 2,
      scr: [],
      count:this.$store.state.list.length
    }
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
    }, 
    loadGoods(scid, page) {
      this.axios.get(`/scorecard?scid=${scid}&page=${page}`)
          .then(result => {
          console.log(result);
          this.scr = result.data.results;
        })
    },

  },
  watch: {
    active(newval) {
      if (newval == 1) {
        this.$router.push('/menu');
      } else if (newval == 0) {
        this.$router.push('/');
      } else if (newval == 3) {
        this.$router.push('/cart');
      } else if (newval == 4) {
        this.$router.push('/me');
      }
    }
  },
  mounted() {
   this.loadGoods(1, 1);
  },
  
};
</script>
<style scoped>
.jifen .my-swipe img {
  width: 100%;
}
.fade1-enter {
  opacity: 0;
}
.fade1-enter-active {
  animation: fade-in 1.5s;
}

.fade1-leave-active {
  animation: fade-out 1.5s;
}
@keyframes fade-in {
  from {
    opacity: 0;
  }
}
@keyframes fade-out {
  to {
    opacity: 0;
  }
}
.van-overlay {
  background-color: rgb(0 0 0 / 0%);
}

.van-card {
  padding: 15px 0;
  width: 270px;
  padding-left: 10px;
}
.jifen .sp {
  display: flex;
  background-color: #fafafa;
  top: 10px;
}

.jifen .sp .category {
  padding-top: 30px;
}
.jifen .sp button {
  margin-top: 40px;
  height: 30px;
  width: 90px;
  background-color: rgb(167, 202, 241);
  border-radius: 20px;
  color: #fff;
  border: 0;
}
.van-card__num {
  margin-right: 150px;
}
.van-card__title{
  font-size: 16px;
  font-weight:bold;
  margin-left: 10px;
}
.tag{
  margin-top: 10px;
  height: 25px;
  width: 80px;
  font-size: 14px;
  margin-left: 10px;
  color: red;
}
.van-tag--danger{
  background-color: #fafafa;
}
.tag2{
  height: 25px;
  width: 80px;
  font-size: 14px;
  margin-left: 10px;
  color: black;
}
.jifen .bottom-bar{
  border-top: 1px solid black;
}
</style>