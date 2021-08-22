<template>
<div>
    <!-- nav -->
    <van-nav-bar
    title="登录"
    left-text="返回"
    right-text="注册"
    left-arrow
    @click-left="onClickLeft"
    @click-right="onClickRight"
    />
    <!-- 登录 -->
        <van-form @submit="onSubmit">
    <van-field
        v-model="username"
        name="用户名"
        label="用户名"
        placeholder="用户名"
        :rules="[{ required: true, message: '请填写用户名' },
        {
          required:true,
          message:'单词字符6~12位',
          pattern:/^([\u4e00-\u9fa50-9a-zA-Z]){6,12}$/,
          trigger:'onBlur'
        }]"
    />
    <van-field
        v-model="password"
        type="password"
        name="密码"
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
    <div style="margin: 16px;">
        <van-button round block color="#6d86c4" native-type="submit" >登录</van-button>
    </div>
    </van-form>
</div>
</template>
<script>
import {mapActions} from "vuex"
import { Toast } from 'vant';
export default {
  data() {
    return {
      username: '',
      password: '',
      usernameState:'',
      pwdState:''
    };
  },
  methods: {
    onClickLeft() {
      this.$router.push('/me')
    },
    onClickRight() {
     this.$router.push('/register')
    },
    //验证表单
    onSubmit() {
      // console.log('submit', values);
      //  console.log(this.username)
        //发送post请求
        // this.axios.post('/login',`uname=${this.username}&upwd=${this.password}`).then(
        //   result=>{
        //     console.log(result);
        //     if(result.data.code==200){
        //       Toast.success('登陆成功');
        //       this.$router.push('/shouye');
        //     }else if(result.data.code==201){
        //       Toast.fail('用户名或密码错误');
        //     }
        //   }
        // )
     this.vlogin({ 
       uname:this.username,
       upwd:this.password})
    },
    ...mapActions(["vlogin"]),
  },
}
</script>