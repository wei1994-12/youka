<template>
  <div>
    <!-- 顶部导航 -->
    <van-nav-bar
      class="nav"
      title="注册"
      left-text="返回"
      right-text="登录"
      left-arrow
      @click-left="onClickLeft"
      @click-right="onClickRight"
    />
    <!-- 注册表单 -->
    <van-form @submit="onSubmit">
      <van-field
        v-model="username"
        name="username"
        label="用户名"
        placeholder="用户名"
        :rules="[{ required: true, message: '请填写用户名' },
        {
          required:true,
          message:'单词字符6~12位',
          pattern:/^[\u4e00-\u9fa5\w]{6,12}$/,
          trigger:'onBlur'
        }]"
      />
      <!-- 输入密码 -->
      <van-field
        v-model="password"
        type="password"
        name="password"
        label="密码"
        placeholder="密码"
        :rules="[{ required: true, message: '请填写密码' },
        {
          required:true,
          message:'数字字母6~8位',
          pattern:/^\w{6,8}$/,
          trigger:'onBlur'
        }]"
      />
      <!-- 确认密码 -->
      <van-field
        v-model="password2"
        type="password"
        label="确认密码"
        name="确认密码"
        placeholder="确认密码"
        :rules="[{ required: true, message: '请填写密码' },
        {
          required:true,
          message:'两次密码不一致',
          validator:checkpwd,
          trigger:'onBlur'
        }]"
      />
      <!--性别  -->
      <van-field
        name="sex"
        label="性别"
      >
        <template #input>
          <van-radio-group
            v-model="sex"
            checked-color="#6d86c4"
            direction="horizontal"
          >
            <van-radio name="1">男</van-radio>
            <van-radio name="0">女</van-radio>
          </van-radio-group>
        </template>
      </van-field>
      <!-- 输入手机号，调起手机号键盘 -->
      <van-field
        v-model="tel"
        type="tel"
        name="tel"
        label="手机号"
        placeholder="请输入手机号"
        :rules="[{ required: true, message: '请填写密码' },
        {
          required:true,
          message:'手机号格式错误',
          pattern:/^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/,
          trigger:'onBlur'
        }]"
      />

      <div style="margin: 16px;">
        <van-button
          round
          block
          color="#6d86c4"
          native-type="submit"
        >注册</van-button>
      </div>
    </van-form>
  </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data() {
    return {
      tel: '',
      username: '',
      number: '',
      password: '',
      password2: '',
      sex: '1' //性别
    };
  },
  methods: {
    checkpwd(value) {
      //  console.log(value);
      if (value == this.password) {
        return true;
      } else {
        return false;
      }
    },
    onClickLeft() {
      this.$router.push('/me')
    },
    onClickRight() {
      this.$router.push('/login')
    },
    onSubmit(values) {
      // console.log('submit', values);
      //发送psot请求
      this.axios.post('/register',
        `uname=${values.username}&upwd=${values.password}&sex=${values.sex}&uphone=${values.tel}`).then(result => {
          console.log(result);
          if (result.data.code == 200) {//注册成功
            Toast.success('注册成功');
            this.$router.push('/login')
          } else if (result.data.code == 201) {//注册失败
            Toast.fail('该用户已存在，请从新输入用户名');
          }
        })
    }
  }
}
</script>
<style scoped>
.van-nav-bar__text {
  color: #6d86c4;
}
</style>

