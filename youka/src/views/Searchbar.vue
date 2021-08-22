<template>
  <div class="searc">
    <!-- 返回图标 -->
    <van-icon
      name="arrow-left"
      style="position:fixed; top: 20px; left:10px;right:0px; "
      size="25"
      color="#cccccc"
      @click="onClickLeft"
    />
    <!-- 搜索框 -->
    <input
      type="text"
      @input="searchA($event)"
      placeholder="请输入搜索关键词"
      style="position:fixed; top: 15px; left:40px;right:0px; "
      class="search"
    >
    <div >
      <!-- 卡片 搜索商品跳转到商品详情 -->
      <div v-if="searchReult.length>0" style="overflow-y: scroll; position:fixed; top: 55px; left:0px; right:0px; bottom:55px;">
        <div
          v-for="(item, i) in searchReult"
          :key="i"
        >
          <router-link :to="`/details?id=${item.id}`">
            <van-card
              :price="item.goods_price.toFixed(2)"
              :title="item.goods_name"
              :thumb="item.goods_img"
              :desc="item.googs_ds"
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
      <!-- 热门推荐 -->
      <div v-else >
        <van-divider dashed >热门推荐</van-divider>
        <div style="overflow-y: scroll; position:fixed; top: 80px; left:0px; right:0px; bottom:0px;">
        <div 
          v-for="(item, i) in rec"
          :key="i"
        >
          <router-link :to="`/details?id=${item.id}`">
            <van-card 
              :price="item.goods_price.toFixed(2)"
              :title="item.goods_name"
              :thumb="item.goods_img"
              :desc="item.googs_ds"
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
      </div>
    </div>

  </div>
</template>
<script>
import { Toast } from 'vant';

export default {
  data() {
    return {
      sear: [],
      searchReult: [],
      rec:[]
    };
  },
  methods: {
    onSearch(val) {
      Toast(val);
    },
    searchA(e) {
      const inputValue = e.target.value
      if (inputValue.length>0) {
        this.searchReult = this.sear.filter((item) => {
          if (item.goods_name.includes(inputValue)) {
            return item;
          }
        })
      }

    },
    onClickLeft() {
      this.$router.go(-1);
    },
  },
  mounted() {
    //搜索接口
    this.axios.get("/Searchbar").then((result) => {
      console.log(result)
      this.sear = result.data.results;
      // console.log(this.imags
    });
    //热门菜单接口
    this.axios.get("/recommend").then((result) => {
      console.log(result)
      this.rec = result.data.results;
      // console.log(this.imags
    });
  }
};
</script>
<style  scoped>
.van-icon::before {
  width: 20px;
}
.container {
  height: 70px;
  width: 800px;
  margin: 100px auto 0 auto;
}
.parent {
  position: relative;
}
.search {
  width: 300px;
  height: 35px;
  border-radius: 18px;
  outline: none;
  border: 1px solid #ccc;
  padding-left: 20px;
  position: absolute;
}
.van-card__price {
  font-size: 16px;
  color: #ec5300;
  padding-bottom: 8px;
}
.menu .van-card__title {
  font-weight: bold;
  font-size: 14px;
  padding-top: 10px;
  margin-left: 15px;
}
.van-card {
  font-size: 15px;
}
.van-divider {
  border-color: green;
}
.van-card__desc{
  margin-top: 10px;
  margin-left: 20px;
}
.van-card__title{
  font-size: 18px;
  height: 25px;
  margin-left: 20px;
  font-weight:bold;
  line-height:30px;
}
.van-card__price{
  padding-bottom:0;
  margin-left: 20px;
}
.searc .card-btn {
  position: relative;
  top: -20px;
  right: 10px;
}
.van-divider[data-v-23bd6f21]{
  margin-top: 55px;
}
</style>