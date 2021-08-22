import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Details from '../views/Details.vue'
import Register from '../views/Register.vue'
import Cart from '../views/Cart.vue'
import Payment from '../views/Payment.vue'
import Coupon from '../views/Coupon.vue'
import Order from '../views/Order.vue'
import Shouye from '../views/Shouye.vue'
import Me from '../views/Me.vue'
import Fen from '../views/Fen.vue'
import Huiyuan from '../views/Huiyuan.vue'
import Menu from '../views/Menu.vue'
import Login from '../views/Login.vue'
import Searchbar from '../views/Searchbar.vue'
import Myself from '../views/Myself.vue'
import Yao from '../views/Yao.vue'
import Customer from '../views/Customer.vue'
import Balance from '../views/Balance.vue'
import Once from '../views/Once.vue'
import Jscorecards from '../views/Jscorecards.vue'
import Sign from '../views/Sign.vue'
import Likes from '../views/Likes.vue'



Vue.use(VueRouter)

const routes = [
  {
    path: '/likes',
    name: 'Likes',
    component:Likes
  },
  {
    path: '/sign',
    name: 'Sign',
    component: Sign
  },
  {
    path: '/jscorecards',
    name: 'Jscorecards',
    component: Jscorecards
  },
  {
    path: '/once',
    name: 'Once',
    component: Once
  },
  {
    path: '/balance',
    name: 'Balance',
    component: Balance
  },
  {
    path: '/customer',
    name: 'Customer',
    component: Customer
  },
  {
    path: '/yao',
    name: 'Yao',
    component: Yao
  },
  {
    path: '/myself',
    name: 'Myself',
    component: Myself
  },
  {
    path: '/searchbar',
    name: 'Searchbar',
    component: Searchbar
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/menu',
    name: 'Menu',
    component: Menu
  },
  {
    path: '/huiyuan',
    name: 'Huiyuan',
    component: Huiyuan
  },
  {
    path: '/fen',
    name: 'Fen',
    component: Fen
  },
  {
    path: '/me',
    name: 'Me',
    component: Me
  },
  {
    path: '/',
    name: 'Shouye',
    component: Shouye
  },
  {
    path: '/order',
    name: 'Order',
    component: Order
  },
  {
    path: '/coupon',
    name: 'Coupon',
    component: Coupon
  },

  {
    path: '/payment',
    name: 'Payment',
    component: Payment
  },
  {
    path: '/cart',
    name: 'Cart',
    component: Cart
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/details',
    name: 'Details',
    component: Details
  },
  
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes
})
router.beforeEach((to, from, next) => {
    if (!sessionStorage.getItem('username')) {
       if (to.path !== '/login') {
         next('/login')
       }
     }
     next()
   })
// router.beforeEach(async (to, from, next) => {
//     if (to.matched.some(record => record.meta.requiresAuth) && to.meta.requiresAuth) {
//       let sStorage = sessionStorage.getItem('token');
//       console.log(sStorage)
//       if (sStorage) {
//         next();
//       } else {
//         alert('请先登录');
//         next({
//           path: '/login', // 未登录则跳转至login页面
//           redirect: '/' // 登陆成功后回到当前页面，这里传值给login页面，to.fullPath为当前点击的页面
//         });
//       }
//     } else {
//       next();
//     }
//   });
 
export default router
