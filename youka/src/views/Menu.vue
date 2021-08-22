<template>
  <div class="menu">
    <!-- 搜索框search -->
    <router-link to="/Searchbar">
    <div >
      <van-search v-model="value" placeholder="请输入搜索关键词" 
      
      />
      </div>
    </router-link>   
    
    <!-- 轮播图 Swipe -->
    <van-swipe :autoplay="3000"  class="my-swipe">
      <van-swipe-item
        class="my-swipe"
        :show-indicators="false"
        touchable
        v-for="(item, i) in imags"
        :key="i"
      >
        <router-link :to="`/details?id=${item.swid}`">
          <img
            :src="item.sli_site"
            alt=""
          />
        </router-link>
      </van-swipe-item>
    </van-swipe>
    <!-- NoticeBar 通知栏 -->
    <van-notice-bar
      left-icon="volume-o"
      :scrollable="false"
    >
      <van-swipe
        vertical
        class="notice-swipe"
        :autoplay="3000"
        :show-indicators="false"
      >
        <van-swipe-item>粉荔荔系列上新！精选岭南荔枝，甜润沁心~</van-swipe-item>
        <van-swipe-item>当季耶加雪啡新豆已从埃塞俄比亚包机空运至国内~</van-swipe-item>
      </van-swipe>
    </van-notice-bar>

    <!-- Sidebar 侧边导航 -->
    <van-sidebar
      v-model="activeKey"
      style="overflow-y: scroll; position:fixed; top: 285px; left:0px; right:0px; bottom:55px;"
    >
      <van-sidebar-item
        v-for="(item, i) in category"
        :key="i"
        :title="item.category_name"
      />
    </van-sidebar>

    <!-- 商品卡片内容 -->
    <div
      class="right-card"
      style="overflow-y: scroll; position:fixed; top: 285px; left:0px; right:0px; bottom:55px;"
    >
      <!-- 卡片 跳转到商品详情 -->
      <div
        v-for="(item, i) in goods"
        :key="i"
      >
        <router-link :to="`/details?id=${item.id}`">
          <van-card
            :price="item.goods_price.toFixed(2)"
            :title="item.goods_name"
            :thumb="item.goods_img"
          >
            <template #footer>
              <van-icon
                class="card-btn"
                name="add"
                size="20px"
                color="#333999"
              />
            </template>
          </van-card>
        </router-link>
      </div>
    </div>

    <!-- 底部导航 -->
    <van-tabbar
      v-model="active"
      active-color="rgb(8, 24, 235)"
      class="bottom-bar"
    >
      <van-tabbar-item icon="home-o">首页</van-tabbar-item>
      <van-tabbar-item icon="orders-o">菜单</van-tabbar-item>
      <van-tabbar-item icon="gift-o">积分</van-tabbar-item>
      <van-tabbar-item
        icon="shopping-cart-o"
        :badge="count"
      >购物车</van-tabbar-item>
      <van-tabbar-item icon="user-o">我的</van-tabbar-item>
    </van-tabbar>

  </div>
</template>

<script>
export default {
  // components: { Searchbar },
  data() {
    return {
      activeKey: 0,
      active: 1,
      category: [],
      imgs: [],
      value: "",
      isLoading: false,
      goods: [],
      count: this.$store.state.list.length,
      imags: []
    };

  },
  watch: {
    active(newval) {
      if (newval == 0) {
        this.$router.push('/');
      } else if (newval == 2) {
        this.$router.push('/fen');
      } else if (newval == 3) {
        this.$router.push('/cart');
      } else if (newval == 4) {
        this.$router.push('/me');
      }
    },
    activeKey(newval) {
      this.axios.get(`/goods?cid=${newval + 1}&page=1`)
        .then(result => {
          console.log(result);
          this.goods = result.data.results;
          // this.goods.forEach(item => {
          //   if (item.goods_img) {
          //     item.goods_img = require(`../assets/${item.goods_img}`)
          //   }
          // })
        })
    }
  },
  mounted() {
    //轮播图接口
    this.axios.get("/slideshow").then((result) => {
      // console.log(result)
      this.imags = result.data.results;
      console.log(this.imags)
    });
    // 侧边导航
    this.axios.get("/category").then((result) => {
      // console.log(result)
      this.category = result.data.results;

    });

    this.loadGoods(1, 1);

  },

  methods: {
    loadGoods(cid, page) {
      // this.$indicator.open('loading...')
      this.axios.get(`/goods?cid=${cid}&page=${page}`)
        .then(result => {
          // console.log(result);
          this.goods = result.data.results;
          // this.goods.forEach(item => {
          //   if (item.goods_img) {
          //     item.goods_img = require(`../assets/${item.goods_img}`)
          //   }
          // })
          // console.log(this.goods);
          // this.$indicator.close();
        })
    },

  },
};
</script>
<style  scoped>

.menu .my-swipe img {
  width: 100%;
}
.menu .van-grid-item__content {
  padding-top: 0px;
  padding-right: 0px;
  padding-bottom: 0px;
  padding-left: 0px;
}
.menu .notice-swipe {
  height: 40px;
  line-height: 40px;
}
.menu .search-icon {
  margin-left: 5px;
}
.menu .van-sidebar {
  width: 100px;
}
.menu .right-card {
  margin-left: 100px;
}
.menu .bottom-bar {
  border-top: 1px solid black;
}

.menu .van-card__price-integer {
  font-size: 16px;
  color: #ec5300;
  padding-bottom: 8px;
}
.menu .van-card__price {
  color: #ec5300;
  padding-bottom: 8px;
}
.menu .card-btn {
  position: relative;
  top: -28px;
}
.menu .van-card__title {
  font-weight: bold;
  font-size: 14px;
  padding-top: 10px;
}
.van-sidebar-item--select::before {
  background-color: rgb(229, 250, 250);
}
</style>
