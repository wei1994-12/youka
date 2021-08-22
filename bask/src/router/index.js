import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import ProductList from '../views/ProductList.vue'
import Order from '../views/Order.vue'
import Sy from '../views/Sy.vue'
import Rbl from '../views/Rbl.vue'
import Tp from '../views/Tp.vue'
import Xr from '../views/Xr.vue'
import Yq from '../views/Yq.vue'
import Yz from '../views/Yz.vue'
import Ds from '../views/Ds.vue'
import Gd from '../views/Gd.vue'


Vue.use(VueRouter)

const routes = [
  {
    path:'/gd',
    name:'Gd',
    component:Gd
  },
  {
    path:'/xr',
    name:'Xr',
    component:Xr
  },
  {
    path:'/yz',
    name:'Yz',
    component:Yz
  },
  {
    path:'/yq',
    name:'Yq',
    component:Yq
  },
  {
    path:'/tp',
    name:'Tp',
    component:Tp
  },
  {
    path:'/ds',
    name:'Ds',
    component:Ds
  },
  {
    path:'/rbl',
    name:'Rbl',
    component:Rbl
  },
  {
    path:'/sy',
    name:'Sy',
    component:Sy
  },
  {
    path:'/order',
    name:'Order',
    component:Order
  },
  
  
  {
    path:'/productlist',
    name:'ProductList',
    component:ProductList
  },
  {
    path:"/login",
    name:'login',
    component:Login
  },
  {
    path: '/home',
    name: 'Home',
    component:Home,

  },
  
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  if (!sessionStorage.getItem('username')) {
     if (to.path !== '/login') {
       next('/login')
     }
   }
   next()
 })
export default router
