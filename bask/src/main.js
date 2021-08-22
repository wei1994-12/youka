import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import axios from 'axios'
// import axios from 'axios';
// Vue.prototype.axios= axios
// Vue.config.productionTip = false
axios.defaults.baseURL='https://api.wylsp.com'
Vue.prototype.axios=axios;
Vue.use(ElementUI);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')


