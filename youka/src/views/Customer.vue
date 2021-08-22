<template>
  <div class="home">
    <header>
      <router-link to="/me">返回</router-link>
      社区群聊天室
    </header>
    <div class="chat-box">
      <div
        class="msg-box"
        ref="msg-box"
      >
        <div
          v-for="(i, index) in list"
          :key="index"
          class="msg"
          :style="i.userId == userId ? 'flex-direction:row-reverse' : ''"
        >
          <div class="user-head">
            <div class="head">
              <img
                src="../../public/image/10.jpg"
                alt=""
              />
            </div>
          </div>
          <div class="user-msg">
            <p :style="i.userId == userId ? ' float: right;' : ''">
              {{ i.userId }}
            </p>
            <span
              :style="
                i.userId == userId
                  ? ' float: right; margin-top: 28px; margin-right: -56px;'
                  : ''
              "
              :class="i.userId == userId ? 'right' : 'left'"
            >{{ i.content }}</span>
          </div>
        </div>
      </div>
    </div>
    <div class="input-box">
      <input
        type="text"
        ref="sendMsg"
        v-model="contentText"
        @keyup.enter="sendText()"
      />
      <div
        class="btn"
        :class="{ ['btn-active']: contentText }"
        @click="sendText()"
      >
        发送
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      ws: null,
      count: 0,
      userId: null, //当前用户ID
      list: [], //聊天记录的数组
      contentText: "", //input输入的值
      username: "",
    };
  },
  created() {
    this.getUserID();
  },
  mounted() {
    this.initWebSocket();
  },
  methods: {
    //根据时间戳作为当前用户ID
    getUserID() {
      let name = (this.username = sessionStorage.getItem("uname"));
      this.userId = name;
    },


    //滚动条到底部
    scrollBottm() {
      let el = this.$refs["msg-box"];
      el.scrollTop = el.scrollHeight;
    },
    //发送聊天信息
    sendText() {
      let _this = this;
      _this.$refs["sendMsg"].focus();
      if (!_this.contentText) {
        return;
      }
      let params = {
        userId: _this.userId,
        msg: _this.contentText,
      };
      _this.ws.send(JSON.stringify(params)); //调用WebSocket send()发送信息的方法
      _this.contentText = "";
      setTimeout(() => {
        _this.scrollBottm();
      }, 500);
      this.contentText = "";
    },
    //进入页面创建websocket连接
    initWebSocket() {
      let _this = this;
      //判断页面有没有存在websocket连接
      if (window.WebSocket) {
        // 119.29.117.40是我本地IP地址 此处的 :8181 端口号 要与后端配置的一致
        let ws = new WebSocket("ws://api.wylsp.com:9999/");
        _this.ws = ws;
        ws.onopen = function (e) {
          console.log(e);
          console.log("服务器连接成功");
        };
        ws.onclose = function (e) {
          console.log(e);
          console.log("服务器连接关闭");
        };
        ws.onerror = function () {
          console.log("服务器连接出错");
        };
        ws.onmessage = function (e) {
          //接收服务器返回的数据
          let resData = JSON.parse(e.data);
          if (resData.funName == "userCount") {
            _this.count = resData.users;
            _this.list = resData.chat;
            console.log(resData.chat);
          } else {
            _this.list = [
              ..._this.list,
              { userId: resData.userId, content: resData.msg },
            ];
          }
        };
      }
    },
  },
  watch: {
    list: function () {
      this.$nextTick(() => {
        let el = this.$refs["msg-box"];
        el.scrollTop = el.scrollHeight;
        document.body.scrollTop = document.body.scrollHeight;
        console.log(document.body.scrollTop);
      });
    }
  }
};
</script>
<style scoped>
.home {
  margin: 0 auto;
  background: #fafafa;
  position: absolute;
  height: 100%;
  width: 100%;
}
.home img {
  border-radius: 50%;
  width: 50px;
  height: 50px;
}

header {
  position: fixed;
  width: 100%;
  height: 3rem;
  background: #f5f5f5;

  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: bold;
  color: #5d5d5d;
  font-size: 1rem;
}
.home a {
  position: absolute;
  left: 16px;
  top: 14px;
  width: 70px;
  background: #f5f5f5;
}

.msg-box {
  position: absolute;
  height: calc(100% - 6.5rem);
  width: 100%;
  margin-top: 3rem;
  overflow-y: scroll;
}
.msg {
  width: 95%;
  min-height: 2.5rem;
  margin: 1rem 0.5rem;
  position: relative;
  display: flex;
  justify-content: flex-start !important;
}
.user-msg {
  width: 80%;
  word-break: break-all;
  position: relative;
  z-index: 5;
}
.user-msg span {
  display: inline-block;
  padding: 0.5rem 0.7rem;
  border-radius: 0.5rem;
  margin-top: 0.2rem;
  font-size: 0.88rem;
}
.user-msg .left {
  background: white;
  animation: toLeft 0.5s ease both 1;
}
.user-msg .right {
  background: #53a8ff;
  color: white;
  animation: toright 0.5s ease both 1;
}

.input-box {
  padding: 0 0.5rem;
  position: absolute;
  bottom: 0;
  width: 95%;
  height: 3.5rem;
  background: #fafafa;
  box-shadow: 0 0 5px #ccc;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.input-box input {
  height: 2.3rem;
  display: inline-block;
  width: 100%;
  padding: 0.5rem;
  border: none;
  border-radius: 0.2rem;
  font-size: 0.88rem;
}
.btn {
  height: 2.3rem;
  min-width: 4rem;
  background: #e0e0e0;
  padding: 0.5rem;
  font-size: 0.88rem;
  color: white;
  text-align: center;
  border-radius: 0.2rem;
  margin-left: 0.5rem;
  transition: 0.5s;
}
.btn-active {
  background: #409eff;
}
</style>