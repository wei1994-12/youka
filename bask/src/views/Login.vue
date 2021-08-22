<template>
  <div class="body">
    <div class="login">
      <h2>管理员登录</h2>
      <el-input
        prefix-icon="el-icon-user"
        placeholder="用户名"
        v-model="username"
        class="input" 
      ></el-input>
      <el-input
        prefix-icon="el-icon-unlock"
        type="password"
        placeholder="密码"
        v-model="upwd" 
        class="input"
      ></el-input>
      <el-button round @click="login" >登录</el-button>
      <div style="margin-top: 50px">
        <span style="color: white">欢迎登陆后台管理系统</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.body {
  width: 98%;
  height:98%;
  padding: 0;
  margin: 0;
  position: relative;
  position: absolute;
  background-image: url(../assets/dl.png);
  background-size: cover;
  background-repeat: no-repeat;
}
.login {
  padding: 80px 40px 40px 40px;
  background: linear-gradient(
    230deg,
    rgba(53, 57, 74, 0) 0%,
    rgb(0, 0, 0) 100%
  );
  width: 290px;
  height: 300px;
  position: absolute;
  top: 50%;
  left: 50%;
  margin: -150px 0 0 -145px;
  border: 1px solid black;
  box-shadow: -15px 15px 15px rgba(6, 17, 47, 0.7);
}
h2{
    color:white;
    font-weight: 400px;
}
button>span{
    color:turquoise;
}
.login > .input .el-input__inner{
  background-color: transparent;
  border: none;
}
.login > .el-button {
  width: 130px;
  border: 2px solid rgb(0, 174, 255);
  background-color: transparent;
  display:block;margin:0 auto;
}
</style>

<script>
export default {
    data(){
        return{
            username:'',
            upwd:'',
           
        }
    },
    methods:{

      login(){
        if(this.username=="wylsp" && this.upwd=="123456"){
          sessionStorage.setItem('username',this.username)
          this.$router.push("/home")
        }else{
          console.log("账号密码错误")
        }
         
      }
    }

}
</script>