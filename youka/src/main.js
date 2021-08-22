import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

// import  VueResource  from 'vue-resource'
// import Searchbar from './components/Searchbar'
// Vue.use(VueResource)

// 配置vant-ui
import Vant from 'vant'
import 'vant/lib/index.css'
Vue.use(Vant)

// 配置axios
import axios from 'axios'
axios.defaults.baseURL="https://api.wylsp.com"
Vue.prototype.axios=axios

// 引入momentjs
import moment from 'moment'
Vue.prototype.moment = moment

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
