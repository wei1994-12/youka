import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import { Toast } from 'vant';
import router from '@/router/index.js'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    list:JSON.parse(localStorage.getItem("list"))||[],
    uname:sessionStorage.getItem('uname'),
    uid:sessionStorage.getItem('uid'),    
   

  },
  mutations: {
    
    setUname(state,uname){
        state.uname=uname;
    },
    setUid(state,uid){
      state.uid=uid;
   },
    // 加入购物车
    join(state,goods)
    {
        var obj = {
            id: goods.id,
            title: goods.goods_name,
            img: goods.goods_img,
            price: goods.goods_price,
            number: goods.n,
            sug:goods.sug,
            wendu:goods.tem
        }
        var index = state.list.findIndex((v) => {
            return goods.id == v.id
        })
        if (index == -1) {
            state.list.push(obj)
            localStorage.setItem("list", JSON.stringify(state.list))
        }
        else {
            state.list[index].number++;
            localStorage.setItem("list", JSON.stringify(state.list))
        } 
    },
    
    // 删除
    delete(state, i) {
      state.list.splice(i,1);
      localStorage.setItem("list", JSON.stringify(state.list))
    },

    // 增加数量
    jia(state, i) {
      state.list[i].number++;
      localStorage.setItem("list", JSON.stringify(state.list))
    },
    // 减少数量
    jian(state,i)
    {
        state.list[i].number--;
        localStorage.setItem("list", JSON.stringify(state.list))
        if (state.list[i].number<=0)
        {
          Toast('至少购买一件')
            // if(confirm("是否移除购物车"))
            // {
            //     state.list.splice(i,1)
            //     localStorage.setItem("list", JSON.stringify(state.list))
            // }
            // else
            // {
                state.list[i].number=1
                localStorage.setItem("list", JSON.stringify(state.list))
            // }
        }
    },
   
  },
  actions: {
    vlogin(context, form){
         //发送post请求
        axios.post('/login',`uname=${form.uname}&upwd=${form.upwd}`).then(
          result=>{
            sessionStorage.setItem('username',this.username)
            // console.log(result);
            // console.log(form.uname)
            if(result.data.code==200){
              Toast.success('登陆成功');

              context.commit("setUname",result.data.result.uname);
              context.commit("setUid",result.data.result.uid);              
              //把uname存入sessionStorage
              sessionStorage.setItem('uname',result.data.result.uname);
              sessionStorage.setItem('uid',result.data.result.uid);
                    
              router.push('/me');              
            }else if(result.data.code==201){
              Toast.fail('用户名或密码错误');
            }
          }
        )
      },
    },
  modules: {
  }
})
