<template>
  <div class="cart">
    <!-- 上方蓝色背景 -->
    <div class="bgc">
      <img
        src="../assets/bgc.png"
        alt=""
      >
    </div>
    <!-- 中间内容 -->
    <div class="center">
      <!-- 购物车 -->
      <div
        class="order"
        v-if="show"
      >
        <!-- 购物车列表 -->
        <div class="order_title">饮品与小食订单</div>
        <div class="order_form">
          <van-checkbox-group
            v-model="result"
            ref="checkboxGroup"
          >
            <div
              v-for="(e,i) in this.$store.state.list"
              :key="i"
            >

              <van-checkbox
                :name="i"
                class="check"
                label-disabled
                v-model="checked"
              >

                <!-- 滑动删除 -->
                <van-swipe-cell>
                  <div class="order_specis">
                    <div class="order_img"><img
                        :src="e.img"
                        alt=""
                      ></div>
                    <div class="order_choose">
                      <div class="order_title">{{e.title}}</div>
                      <div class="order_love">{{e.wendu}}/{{e.sug}}</div>
                      <div class="order_price">￥{{e.price}}</div>
                    </div>
                    <div class="order-button">
                      <button
                        class="minus"
                        @click="jian(i)"
                      >-</button>
                      <span>{{e.number}}</span>
                      <button
                        class="add"
                        @click="jia(i)"
                      >+</button>
                    </div>
                  </div>
                  <template #right>
                    <van-button
                      square
                      type="danger"
                      text="删除"
                      class="del-btn"
                      @click="del(i)"
                    />
                  </template>
                </van-swipe-cell>
              </van-checkbox>
            </div>

          </van-checkbox-group>

          <!-- 全选 -->
          <div class="all">
            <van-button
              type="primary"
              @click="checkAll"
              size="small"
            >全选</van-button>
            <!-- <van-button type="info" @click="del" size="small">删除</van-button> -->
            <div class="compu">合计￥{{total}}</div>
            <van-button
              round
              type="warning"
              class="payment"
              @click="pay"
            >去结算</van-button>
          </div>
        </div>
      </div>
      <!-- 空购物车 -->
      <div
        v-else
        class="null"
      >
        <div class="null-img"><img
            src="../assets/null.png"
            alt=""
          ></div>
        <div class="lonely">你的购物车有点寂寞</div>
        <router-link to="/menu"><button>去喝一杯</button></router-link>
      </div>
      <!-- 为你搭配 -->
      <div class="match">
        <div class="match_tit">
          <div class="square"></div>
          <div>为你搭配</div>
        </div>
        <!-- <div>
                   <van-icon  name="replay" />
                   <span>换一批</span>
               </div> -->
      </div>
      <!-- 搭配图片 -->
      <div class="allpic">
        <div
          class="card"
          v-for="(item,i) in cakes"
          :key="i"
        >
          <img
            :src="item.goods_img"
            alt=""
          >
          <h4>{{item.goods_name}}</h4>
          <div class="bot">
            <span>￥{{item.goods_price}}</span>
            <button>+</button>
          </div>
        </div>
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
      <van-tabbar-item
        icon="shopping-cart-o"
        :badge="count"
      >购物车</van-tabbar-item>
      <van-tabbar-item icon="user-o">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>
<script>
import { Dialog, Toast } from 'vant';
import { mapState } from "vuex"
import { mapMutations } from 'vuex'
export default {
  data() {
    return {
      result: [],
      show: true,
      active: 3,
      count: this.$store.state.list.length,
      n: 1,
      data: [],
      checked: false,
      total: 0,
      oid: [],
      cakes: [],

    }
  },
  watch: {
    active(newval) {
      if (newval == 0) {
        this.$router.push('/');
      } else if (newval == 1) {
        this.$router.push('/menu');
      } else if (newval == 2) {
        this.$router.push('/fen');
      } else if (newval == 4) {
        this.$router.push('/me');
      }
    },
    // 选中框一改变，总价跟着改变
    result() {
      // console.log(this.result)       
      let sum = 0;
      this.result.forEach(item => {
        sum += this.$store.state.list[item].price * this.$store.state.list[item].number
      })
      this.total = sum;
      console.log(this.result)

    }

  },
  methods: {
    checkAll() {
      this.$refs.checkboxGroup.toggleAll(true);
    },
    // 减少所选商品数量
    jian(i) {
      this.$store.commit("jian", i)

      this.result.forEach(item => {
        if (parseInt(item) == i) {
          this.total -= this.$store.state.list[i].price
        }
      })
    },
    // 增加所选商品数量
    jia(i) {
      this.$store.commit("jia", i)
      this.result.forEach(item => {
        if (parseInt(item) == i) {
          this.total += this.$store.state.list[i].price
        }
      })

    },

    // 删除购物车列表
    // del(){
    //     this.result.forEach(item=>{        
    //     //   this.total-=this.$store.state.list[item].price * this.$store.state.list[item].number 
    //         this.$store.commit("delete",item); 
    //         this.count=this.$store.state.list.length                   
    //         // console.log(this.$store.state.list)
    //     })    
    //      console.log(this.result)                                           
    // },
    del(i) {
      console.log(i);
      if (this.result[i] == i) {
        this.total -= this.$store.state.list[i].price * this.$store.state.list[i].number
      }
      this.$store.commit("delete", i);
      console.log(this.list);
      this.count = this.$store.state.list.length;
      if (this.count == 0) {
        this.show = false;
      }
    },
    pay() {
      if (this.result.length != 0) {
        this.$router.push('/payment');
      } else {
        Toast('请选择至少一件商品');
      }
      console.log(this.result);
      sessionStorage.setItem('oid', this.result);
      //   this.result.forEach(item=>{
      //      this.$store.state.list.splice(item,1) 
      //   })      
    },
  },

  mounted() {
    if (this.count == 0) {
      this.show = false;
    };
    this.axios.get(`/cakes`).then(result => {
      console.log(result);
      this.cakes = result.data.results;
    })

  },
  computed: {
    ...mapState(["list"]),
    //相当于:
    //list(){ ... }
  },

}
</script>
<style scoped>
/* 搭配图片css */
.cart .center .allpic {
  width: 95%;
  margin: 0 auto;
  /* justify-content:space-between;  */
  margin-top: 10px;
}
.cart .center .allpic .card {
  width: 32%;
  /* height: 150px; */
  background-color: white;
  border-radius: 5px;
  padding-bottom: 10px;
  float: left;
  margin-left: 1%;
  margin-bottom: 10px;
}
.cart .center .allpic .card img {
  width: 100%;
  border-radius: 5px;
}
.cart .center .allpic .card h4 {
  padding-top: 5px;
  padding-bottom: 5px;
  font-weight: normal;
  padding-left: 3px;
}
.cart .center .allpic .card span {
  color: orangered;
  padding-left: 3px;
}

.cart .center .allpic .card button {
  width: 20px;
  height: 20px;
  border: 0;
  border-radius: 50%;
  background-color: rgb(105, 95, 241);
  color: #ffffff;
  margin-left: 40px;
}

.cart {
  background-color: #f5f5f5;
}
.cart .bgc img {
  width: 100%;
}
.cart .center {
  position: relative;
  top: -20px;
}
.cart .order .order_form {
  width: 92%;
  margin: 0 auto;
  border-radius: 5px;
  background-color: white;
  padding-left: 3%;
  padding-top: 10px;
  padding-bottom: 10px;
}
.cart .order .order_form .check {
  margin-bottom: 10px;
}
.cart .order .order_choose {
  width: 120px;
}
.cart .order .order_title {
  width: 92%;
  margin: 0 auto;
  height: 40px;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  background-color: white;
  padding-left: 3%;
  margin-bottom: 1px;
  line-height: 40px;
}
.cart .order .order_form .order_specis img {
  width: 100px;
  border-radius: 5px;
}
.cart .order .order_form .order_specis {
  display: flex;
}

.cart .order .order_form .order_specis .order_choose .order_title {
  font-weight: bold;
  line-height: 20px;
  height: 20px;
  padding-left: 10px;
  padding-top: 5px;
}
.cart .order .order_form .order_specis .order_choose .order_love {
  font-weight: lighter;
  font-size: 12px;
  padding-left: 10px;
  margin-top: 20px;
}
.cart .order .order_form .order_specis .order_choose .order_price {
  font-weight: bold;
  color: tomato;
  padding-left: 10px;
  margin-top: 15px;
}
.cart .order .order_form .order_specis .order-button {
  margin-left: 20px;
  margin-top: 75px;
}
.cart .order .order_form .order_specis .order-button button {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 0;
  font-size: 18px;
}
.cart .order .order_form .order_specis .order-button .minus {
  color: rgb(105, 95, 241);
  border: 1px solid rgb(105, 95, 241);
  background-color: white;
  margin-right: 7px;
}
.cart .order .order_form .order_specis .order-button .add {
  background-color: rgb(105, 95, 241);
  border: 1px solid rgb(105, 95, 241);
  color: white;
  margin-left: 7px;
}
.cart .order .order_form .all {
  display: flex;
}
.cart .order .order_form .all .compu {
  line-height: 35px;
  margin-left: 5px;
  width: 50%;
}
.cart .order .order_form .all .payment {
  font-weight: light;
  height: 35px;
  width: 30%;
}
.cart .center .match {
  display: flex;
  justify-content: space-between;
  width: 95%;
  margin: 0 auto;
  margin-top: 10px;
}
.cart .center .match .square {
  width: 5px;
  /* height: 6px; */
  background-color: rgb(105, 95, 241);
  padding-bottom: 10px;
  margin-right: 5px;
}
.cart .center .match .match_tit {
  display: flex;
}
.cart .center .null {
  width: 95%;
  text-align: center;
}
.cart .center .null .null-img {
  padding-top: 100px;
}
.cart .center .null .lonely {
  font-size: 14px;
  font-weight: light;
}
.cart .center .null button {
  width: 150px;
  height: 40px;
  border-radius: 20px;
  border: 0;
  background-color: #6d86c4;
  margin-top: 20px;
  margin-bottom: 20px;
  color: white;
}
.cart .bottom-bar {
  border-top: 1px solid black;
}
/* 滑动删除 */
.cart .del-btn {
  height: 100%;
}
</style>