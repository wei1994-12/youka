
<template>
  <div class="main">
    <!-- 顶部导航 -->
    <van-nav-bar title="我的" />
    <!-- 登录注册 -->
    <div class="reg">
      <table></table>
      <van-row
        class="login"
        type="flex"
        align="center"
      >
        <van-col span="6">
          <van-uploader :after-read="afterRead">
            <van-image
              round
              width="4rem"
              height="4rem"
              :src=avatar
            />
          </van-uploader>
        </van-col>
        <div v-if="uname">{{uname}}</div>
        <div
          v-else
          style="display:flex "
        >
          <p @click="log">登录</p>
          <span>/</span>
          <p @click="reg">注册</p>
          <van-icon
            name="arrow"
            style="margin-top:5px"
          />
        </div>

      </van-row>
    </div>
    <!-- 用户功能区 -->

    <van-grid
      class="function"
      clickable
    >
      <van-grid-item
        class="order"
        icon="orders-o"
        text="我的订单"
        @click="ding"
      />
      <van-grid-item
        icon="pending-payment"
        text="咖啡钱包"
      />
      <van-grid-item
        icon="send-gift-o"
        text="优惠券"
        @click="youhui"
      />
      <van-grid-item
        icon="gift-card-o"
        text="礼品卡"
      />
      <van-grid-item
        icon="balance-o"
        text="账户余额"
        @click="balance"
      />
      <van-grid-item
        icon="discount"
        text="兑换优惠"
      />
      <van-grid-item
        icon="service-o"
        text="社区聊天"
        @click="help"
      />
      
        <van-grid-item
         to="/myself?uname"
          icon="user-o"
          text="个人中心"
        />
      

    </van-grid>

    <!-- 推荐 -->
    <h4>为你推荐</h4>
    <div class="advice">
      <div @click="advice">
        <van-image
          width="100%"
          src="/image/advice_1.png"
        />
      </div>
      <div @click="advice1">
        <van-image
          width="100%"
          src="/image/advice_2.png"
        />
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
import { mapState } from "vuex"
import { Toast } from 'vant';
export default {
  data() {
    return {
      active: 4,
      count: this.$store.state.list.length,
      avatar: 'https://img01.yzcdn.cn/vant/cat.jpeg',
      uid: ''
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
      } else if (newval == 3) {
        this.$router.push('/cart');
      }
    }
  },
  methods: {
    // 头像上传
    afterRead(file) {
      // 此时可以自行将文件上传至服务器
      console.log(file);
      let uid = this.uid;
      // let uid=sessionStorage.getItem('uid');
      const formData = new FormData();
      formData.append('uploadFile', file.file, this.uid + ".jpg");
      // const res = upload(FormData);
      console.log(formData);
      this.axios.post('/upload', formData).then(res => {
        console.log(res);
        this.avatar = res.data.img
        if (res.data.code == 201) {
          Toast.success('修改成功');
        } else {
          Toast.fail(res.data.msg);
        }
      })
        .catch(err => {
          console.error(err);
        })
      // this.userInfo.head_img = this.$axios.defaults.baseURL + res.data.data.url
      //   console.log(file.file.name)
      //   console.log(res)
    },
    ding() {
      this.$router.push('/order');
    },
    youhui() {
      this.$router.push('/coupon');
    },
    reg() {
      this.$router.push('/register');
    },
    log() {
      this.$router.push('/login');
    },
    help() {
      this.$router.push('/customer');
    },
    balance() {
      this.$router.push('/balance');
    },
    advice() {
      this.$router.push('/menu');
    },
    advice1() {
      this.$router.push('/huiyuan');
    }

  },
  computed: {
    ...mapState(["uname"]),
    //相当于:
    //uname(){ ... }
  },
  mounted() {
    console.log(this.uname)
    this.uid = sessionStorage.getItem('uid');
  }
}
</script>

<style scoped>
.mian {
  background-color: #f5f5f5 !important;
}
.login {
  font-size: 22px;
  font-weight: 900;
  margin: 0 auto;
  color: #f5f5f5;
  margin-top: 60px;
}
h4 {
  font-weight: normal;
  color: #646566;
  margin: 10px 0 10px 15px;
}
.reg {
  width: 100%;
  height: 150px;
  background-image: url("../assets/header.png");
  background-repeat: no-repeat;
  background-size: 100% 100%;
  /* padding-top: 50px; */
  border-bottom-right-radius: 25px;
  border-bottom-left-radius: 25px;
}
.function {
  border-radius: 5px !important;
  width: 90%;
  height: 172px;
  margin-left: 19px;
  margin-top: -20px;
  overflow: hidden;
  border: 1px solid #f5f5f5;
}
.order {
  border-top-left-radius: 5px;
}
.van-col--6 {
  /* margin-left: 20px; */
  text-align: center;
}
body {
  background: #000 !important;
}
.bottom-bar {
  border-top: 1px solid black;
}
.advice {
  width: 90%;
  margin: 0 auto;
}
.advice div {
  border-radius: 5px;
  overflow: hidden;
  margin-top: 5px;
}
</style>
