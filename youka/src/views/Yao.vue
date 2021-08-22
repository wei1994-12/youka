<template>
  <div class="yao">
    <van-nav-bar
      title="送好友100元抵用金"
      left-text=""
      @click-left="onClickLeft"
      left-arrow
    />
    <div class="img">
      <img
        src="../assets/yao1.png"
        alt=""
      >
    </div>
    <div class="bu">
      <div class="text">
        <h4>——参与步骤——</h4>
      </div>
      <div class="tu">
        <div>
          <img
            src="../assets/yao2.png"
            alt=""
          >
          <h6>分享链接给好友</h6>
        </div>
        <div>
          <img
            src="../assets/yao3.png"
            alt=""
          >
          <h6>好友注册并获
            <br>得100元新人抵用金
          </h6>
        </div>
        <div>
          <img
            src="../assets/yao4.png"
            alt=""
          >
          <h6>好友完成首单</h6>
        </div>
        <div>
          <img
            src="../assets/yao5.png"
            alt=""
          >
          <h6>邀请达成获得奖励！</h6>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {};
  },
  methods: {
    onClickLeft() {
      this.$router.push('/')
    }
  },
};
</script>
<style scoped>
* {
  margin: 0;
  padding: 0;
}
.yao .img img {
  width: 100%;
  margin-top: 10px;
}
.yao .bu {
  width: 90%;
  height: 150px;
  background-color: white;
  margin: 0 auto;
  position: relative;
  margin-top: 10px;
}
.yao .bu .text {
  font-size: 20px;
  text-align: center;
  padding-top: 10px;
}
.yao .tu {
  display: flex;
  justify-content: space-between;
  position: relative;
  padding: 5%;
}
</style>