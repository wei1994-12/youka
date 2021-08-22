<template>
  <div
    class="check"
    style="background-color: #eee"
  >
    <van-nav-bar
      left-arrow
      fixed
      :placeholder="true"
      @click-left="onClickLeft"
    >
      <template #title>
        <p style="font-size: 23px">签到日历</p>
      </template>
    </van-nav-bar>
    <div class="check-header">
      <table></table>
      <van-icon
        name="question-o"
        style="margin-left: 93%; margin-top: 10px"
      />
      <div class="d">
        <p style="color: #ffffff; font-size: 25px; text-align: center">{{score}}</p>
        <br />
        <p style="color: #ffffff; text-align: center; font-size: 12px">
          积分资产
        </p>
      </div>
    </div>
    <div class="check-body">
      <div class="check-d">
        <div>
          <van-cell
            title="连续签到7天可得120积分"
            title-style="font-weight:800"
          >
            <!-- 使用 right-icon 插槽来自定义右侧图标 -->
            <template #right-icon>
              <a href="javascript:;">签到规则</a>
            </template>
          </van-cell>
        </div>
        <div class="check-a">
          <van-steps
            inactive-icon="location-o"
            :active="active"
            active-icon="fire-o"
            active-color="#fe1943"
            class="check-f"
            finish-icon="fire-o"
          >
            <van-step>第1天</van-step>
            <van-step>第2天</van-step>
            <van-step>第3天</van-step>
            <van-step>第4天</van-step>
            <van-step>第5天</van-step>
            <van-step>第6天</van-step>
            <van-step>第7天</van-step>
          </van-steps>
        </div>
        <div class="check-button">
          <van-button
            v-if="status==1"
            round
            color="linear-gradient(to right, #ff6034, #ee0a24)"
            size="large"
            @click='qiandao'
          >立即签到</van-button>
          <van-button
            v-else
            round
            color="linear-gradient(to right, rgb(53,56,61), rgb(65,70,76))"
            disabled
            size="large"
          >已经签到</van-button>
        </div>
      </div>
    </div>
    <div class="check-jf">
      <van-grid
        clickable
        :column-num="2"
      >
        <van-grid-item
          icon="star"
          to=""
        >
          <template #text>
            <p style="font-size: 14px; font-weight: 500; margin-top: 5px">
              积分任务
            </p>
            <p style="font-size: 12px; opacity: 0.4; margin-top: 5px">
              做任务赚积分
            </p>
          </template>
        </van-grid-item>
        <van-grid-item
          icon="label-o"
          url="javascript:;"
        >
          <template #text>
            <p style="font-size: 14px; font-weight: 500; margin-top: 5px">
              积分明细
            </p>
            <p style="font-size: 12px; opacity: 0.4; margin-top: 5px">
              查看积分明细
            </p>
          </template>
        </van-grid-item>
      </van-grid>
    </div>
  </div>
</template>
<script>
import Vue from "vue";
export default {
  data() {
    return {
      active: 0,
      status: 1,
      score: 2999
    };
  },
  methods: {
    qiandao() {
      let uid = sessionStorage.getItem('uid');
      console.log(uid);
      this.axios.put('/ss', `uid=${uid}`).then(res => {
        console.log(res);
        if (res.data.code == 200) {
          this.status = 0;
          this.active = this.active + 1;
        }


        this.score += 10;
        sessionStorage.setItem("score", this.score);
        console.log(sessionStorage.getItem('score'));

      });
    },
    onClickLeft() {
      this.$router.go(-1);
    }
  },
  mounted() {
    let uid = sessionStorage.getItem('uid');
    this.axios.get(`/sign?uid=${uid}`).then(res => {
      console.log(res);
      this.active = res.data.result.sign;
      this.status = res.data.result.status;
    })

  },
};
</script>

<style  scoped>
.van-step--horizontal .van-step__icon {
  font-size: 14px;
}
.check .check-button {
  width: 60%;
  margin: 20px auto 0;
}
.check .van-button--large {
  height: 47px;
}
.check .check-jf {
  margin-top: 170px;
}
.check .check-header {
  width: 100%;
  height: 150px;
  background-image: linear-gradient(#ee0a24, #ff6034);
  border-radius: 0 0 15% 15%;
}
.check .check-header .d {
  width: 30%;
  margin: 10px auto 0;
}
.check .check-d {
  width: 94%;
  height: 200px;
  background-color: #ffffff;
  position: absolute;
  top: 160px;
  left: 3%;
}
.check .check-a {
  margin: 0 auto;
}
.swatch {
  width: 25px;
  height: 25px;
  background: #cccccc;
  border-radius: 50%;
  position: relative;
}
.swatch:after {
  content: "";
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  border-radius: 50%;
  border: 2px solid #ff6034;
}
.van-button--large {
  height: 75px;
}
</style>