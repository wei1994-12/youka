<template>
  <div class="details">
    <!-- 导航栏 -->
    <van-nav-bar
      title="商品详情"
      left-arrow
      fixed
      @click-left="onClickLeft"
    >
      <van-icon
        name="share-o"
        slot="right"
      />
    </van-nav-bar>
    <!-- 导航图 -->
    <img
      :src="goods.goods_img"
      alt=""
      class="top-img"
    >
    <!-- <van-swipe class="my-swipe" :show-indicators="false" 
        touchable>
            <van-swipe-item> <img :src="`../../public/img/${goods.goods_img}`"  alt=""></van-swipe-item>
        </van-swipe> -->
    <!-- 商品规格 -->
    <div class="specis">
      <!-- 饮品名字 +收藏 -->
      <div class="name-love">
        <span class="name">{{goods.goods_name}}</span>
        <div
          class="love"
          @click="like"
        >
          <van-icon
            name="like-o"
            size="20"
            v-if="show"
          ></van-icon>
          <van-icon
            name="like"
            size="20"
            v-else
            color="orangered"
          ></van-icon>
          <div
            class="join"
            :style="{color:color}"
          >加入定制</div>
        </div>
      </div>
      <!-- 温度 -->
      <div class="temperature">
        <span class="title">温度</span>
        <button
          v-for="(item,i) in wendu"
          :key="i"
          @click="changeWendu(i)"
          :class="{c_active1:i==active1}"
        >{{item}}</button>
        <!-- <button class="hot">热</button> -->
      </div>
      <!-- 糖度 -->
      <div class="sugar">
        <span class="title">糖度</span>
        <button
          v-for="(item,i) in tang"
          :key="i"
          @click="changeTang(i)"
          :class="{c_active2:i==active2}"
        >{{item}}</button>
      </div>
    </div>
    <!-- 商品详情 -->
    <div class="product-details">
      <div class="tit">商品详情</div>
      <img
        src="../assets/details1.png"
        alt=""
      >
      <img
        src="../assets/details2.png"
        alt=""
      >
      <img
        src="../assets/details3.png"
        alt=""
      >
      <img
        src="../assets/details4.png"
        alt=""
      >
    </div>
    <!-- 价格说明 -->
    <div class="priceintro">
      <div>价格说明</div>
      <div>
        1.面价：面价为商品的标示价格，是哞哞饮品的建议零售价格，在菜单中标示为黑色或者划线价格，非原价。<br>
        2.促销价：促销价为商品的促销价格，在菜单中标示为红色价格，是当前哞哞饮品给予消费者的优惠价格。
        促销价是以面价为基数进行折扣或者满减二获得的优惠价格。
      </div>
    </div>
    <!-- 底部加入购物车等 -->
    <div class="bottom-cart">
      <div class="price">
        <div class="pri">￥{{goods.goods_price}}</div>
        <div class="price-detail">{{goods.goods_name}}￥{{goods.goods_price}}
          +{{this.wendu[this.active1]}}+{{this.tang[this.active2]}}</div>
      </div>
      <div class="number">
        <button
          class="minus"
          @click="minus"
        >-</button>
        <span>{{n}}</span>
        <button
          class="add"
          @click="add"
        >+</button>
      </div>
    </div>

    <van-goods-action class="cart">
      <van-goods-action-icon
        icon="chat-o"
        text="客服"
      />
      <van-goods-action-icon
        icon="cart-o"
        text="购物车"
        @click="allcart"
      />
      <van-goods-action-icon
        icon="star"
        text="全部收藏"
        color="#ff5000"
        @click="alllike"
      />
      <!-- <router-link to="/menu"> -->
      <van-goods-action-button
        type="warning"
        text="加入购物车"
        @click="join(goods)"
      />
      <!-- </router-link> -->

      <van-goods-action-button
        type="danger"
        text="立即购买"
        @click="buy"
      />
    </van-goods-action>

  </div>
</template>
<script>
// import {mapState} from "vuex"
// import { mapMutations } from 'vuex'
// import {mapActions} from "vuex"

export default {
  computed: {
    // ...mapState(["count"])
  },
  data() {
    return {
      wendu: ['冰', '热'],
      active1: 0,
      tang: ['不加糖', '半塘', '标准糖'],
      active2: 0,
      n: 1,
      goods: {},
      show: true,
      color: 'rgb(88, 84, 84)'
    }
  },
  mounted() {
    let id = this.$route.query.id;
    // console.log('从列表页传过来的id，如果是undefined，那就是没传：'+id);
    this.axios.get(`/detail?id=${id}`).then(result => {
      console.log(result);
      this.goods = result.data.result;
      if (this.goods.love == 1) {
        this.show = false;
      }
      // this.goods.goods_img=require(`../assets/${this.goods.goods_img}`)                        
    })
  },
  methods: {
    // 全部收藏
    alllike() {
      this.$router.push('/likes');
    },
    // 收藏
    like() {
      this.show = !this.show;
      if (this.show == true) {
        this.color = "rgb(88, 84, 84)"
      } else {
        this.color = "orangered"
        let id = this.$route.query.id;
        this.axios.put('/xiugai', `id=${id}`).then(res => {
          console.log(res);
        });
      }


    },
    onClickLeft() {
      this.$router.go(-1);
    },
    allcart() {
      this.$router.push('/cart');
    },
    changeWendu(i) {
      this.active1 = i;
    },
    changeTang(i) {
      this.active2 = i;
    },
    minus() {
      if (this.n > 1) {
        this.n--;
      }
    },
    add() {
      this.n++;
    },
    // 加入购物车
    join(goods) {
      //     setTimeout(()=>{
      //        this.$router.push("/cart")
      //    },500)
      let obj1 = { 'n': this.n };
      let obj2 = { 'tem': this.wendu[this.active1] }
      let obj3 = { 'sug': this.tang[this.active2] }
      var obj = { ...obj1, ...obj2, ...obj3 }
      this.goods = { ...this.goods, ...obj }
      // console.log(this.goods);
      this.$store.commit("join", this.goods)
      this.$router.push("/menu")
    },
    buy() {
      // onceid为立即购买的商品id
      let onceid = this.goods.id;
      console.log(onceid);
      sessionStorage.setItem('onceid', onceid)
      sessionStorage.setItem('wen', this.wendu[this.active1])
      sessionStorage.setItem('tang', this.tang[this.active2])
      sessionStorage.setItem('num', this.n)
      this.$router.push('/once');
    }
  },

}
</script>
<style scoped>
* {
  margin: 0;
  padding: 0;
}
.details img {
  width: 100%;
}
.details {
  background-color: #ddd;
  padding-bottom: 110px;
}

.details .specis {
  width: 92%;
  /* height: 150px; */
  border-radius: 5px;
  background-color: white;
  margin: 0 auto;
  margin-top: 5px;
  overflow: hidden;
  padding-left: 4%;
  padding-top: 4%;
}
.details .specis .name {
  line-height: 48px;
  font-weight: bold;
}
.details .specis .love {
  float: right;
  text-align: center;
  margin-right: 10%;
}
.details .specis .love .join {
  font-size: 8px;
  line-height: 8px;
}
.details .specis .temperature,
.sugar {
  font-size: 12px;
}
.details .specis button {
  width: 85px;
  height: 30px;
  border-radius: 20px;
  outline: none;
  border: 0;
  margin-left: 12px;
}

.details .specis .sugar .none {
  margin-left: 5%;
  margin-right: 3%;
}
.details .specis .sugar .half {
  margin-right: 3%;
}
.details .specis .title {
  line-height: 28px;
}
.details .specis .nameLove {
  margin-bottom: 15px;
}
.details .specis .temperature,
.sugar {
  margin-bottom: 15px;
}

.details .product-details {
  width: 87%;
  /* height: 150px; */
  border-radius: 5px;
  background-color: white;
  margin: 0 auto;
  margin-top: 10px;
  padding-left: 4%;
  padding-right: 4%;
}
.details .product-details .tit {
  padding-top: 10px;
  margin-bottom: 10px;
}
.details .priceintro {
  width: 87%;
  border-radius: 5px;
  background-color: white;
  margin: 0 auto;
  margin-top: 10px;
  padding-left: 4%;
  padding-right: 4%;
  padding-top: 15px;
  font-size: 12px;
  font-weight: lighter;
  padding-bottom: 15px;
}
.details .bottom-cart {
  overflow: hidden;
  height: 70px;
  width: 90%;
  margin: 0 auto;
  background-color: white;
  margin-top: 10px;
  padding-left: 5%;
  padding-right: 5%;
  padding-top: 15px;
}
.details .bottom-cart .price {
  float: left;
}
.details .bottom-cart .number {
  float: right;
  padding-top: 5px;
}
.details .bottom-cart .price .pri {
  font-size: 16px;
  color: orangered;
}
.details .bottom-cart .price .price-detail {
  font-size: 12px;
  line-height: 12px;
}
.details .bottom-cart .number button {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 0;
  font-size: 18px;
}
.details .bottom-cart .number .minus {
  color: rgb(105, 95, 241);
  border: 1px solid rgb(105, 95, 241);
  background-color: white;
  margin-right: 7px;
}
.details .bottom-cart .number .add {
  background-color: rgb(105, 95, 241);
  border: 1px solid rgb(105, 95, 241);
  color: white;
  margin-left: 7px;
}
.details .bottom-cart {
  position: fixed;
  bottom: 25px;
}
.details .cart {
  width: 94%;
  text-align: center;
  padding-left: 2%;
  padding-right: 4%;
  padding-bottom: 10px;
}
/* 修改温度按钮样式 */
.details .specis .temperature .c_active1 {
  border: 1px solid rgb(105, 95, 241);
  color: rgb(105, 95, 241);
}
.details .specis .sugar .c_active2 {
  border: 1px solid rgb(105, 95, 241);
  color: rgb(105, 95, 241);
}
</style>