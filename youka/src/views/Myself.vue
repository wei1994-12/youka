<template>
  <div class="me">
    <van-nav-bar
      title="个人资料"
      left-text=""
      @click-left="onClickLeft"
      left-arrow
    />
    <div class="xin">
      <van-cell
        title="头像"
        is-link
        value=""
      />
      <van-cell
        title="用户名"
        is-link
        :value="uname"
      />
      <van-cell
        title="性别"
        is-link
        :value="users.sex==1?'男':'女'"
      />
      <van-cell
        title="绑定手机"
        is-link
        :value="users.uphone"
      />
      <van-cell
        title="收货地址"
        is-link
        value="xx省xx市xx区"
      />
      <van-cell
        title="绑定微信"
        is-link
        value="已绑定"
      />
      <van-cell
        title="协议与说明"
        is-link
        value=""
      />
    </div>
    <div class="btn">
      <button @click="tc">
        退出登录</button>
    </div>
  </div>
</template>
<script>
import { mapState } from "vuex"
export default {
  data() {
    return {
      users: {},
    };
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
    },
    tc() {
      this.$router.push("/login");
      sessionStorage.removeItem("username");
    }
  },
  computed: {
    ...mapState(["uname"]),
    //相当于:
    //uname(){ ... }
  },
  mounted() {
    let uname = this.$route.query.uname;
    this.axios.get(`/user?uname=${this.uname}`).then(result => {
      console.log(result);
      this.users = result.data.result;
      console.log(this.users);

    })
  }
};
</script>
<style >
* {
  margin: 0;
  padding: 0;
}
.me {
  background-color: rgb(232, 232, 243);
}
.me .xin {
  margin-top: 20px;
  padding: 3%;
  border-radius: 3px;
}
.me button {
  background-color: rgb(103, 143, 196);
  width: 95%;
  height: 40px;
  border-radius: 50px;
  color: white;
  border: 0;
  margin-left: 10px;
  margin-top: 160px;
}
</style>