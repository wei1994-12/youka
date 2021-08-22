<template>
	<div>
		
		<!-- vant搜索 -->
		<van-search  autofocus show-action shape="round" type="text"
			placeholder="请输入内容"
			v-model="keywords"
			@focus="onFoucs"
            @blur="onBlur"
            @input="onInput"
			ref="getValue">
			<!-- 聚焦框 -->
        	<dl class="focus-wrapper" v-if="showHotWords">
            <dt>热门搜索</dt>
            <dd v-for="(item, index) in hotWords" :key="index"><nuxt-link to="/2">{{item}}</nuxt-link></dd>
        	</dl>
			<!-- 输入关键词框 -->
        	<dl class="key-words" v-if="showSearchList">
            	<dd v-for="(item, index) in focusData" :key="index"><nuxt-link to="/1">{{item}}</nuxt-link></dd>
        	</dl>
        	<!-- 热门搜索 -->
        	<dl class="hot-keywords">
            	<dd v-for="(item,index) in searchData" :key="index"><nuxt-link to="/2">{{item}}</nuxt-link></dd>
        	</dl>
			<!-- 后退 -->
			<template #left>
				<van-icon @click="back" style="margin-right: 5px;" size="22px" name="arrow-left" />
			</template>
			
			<template #action>
				<van-button  
				size="small" 
				type="danger" 
				style="border-radius: 5px; font-size: 14px;"
				@click="search"
				>搜索</van-button>
			</template>
			
		</van-search>
		
		
	</div>
</template>

<script>
import Vue from 'vue';
import { RadioGroup, Radio, CellGroup, Cell } from 'vant';

Vue.use(Radio);
Vue.use(RadioGroup);
Vue.use(CellGroup);
Vue.use(Cell);


	export default{
		data(){
			return{
				// 关键字
      			keywords: "",
				list:[], //所有数据
				saveList:[], //搜索记录的数据
				showList:[], //搜索提示的数据
				// 获取焦点状态
				isFocus: false,
				// 热门搜索
				hotWords: ['北京动物园', '故宫博物院', '故宫', '北京欢乐谷', '八达岭长城'],
				// 聚焦框数据
				focusData: ['火锅','火锅自助餐','火锅','火锅串串'],
				// 搜索框数据
        		searchData: ['北京动物园','故宫博物院','故宫','北京欢乐谷','八达岭长城','欢乐水魔方','水上乐园','十渡蹦极俱乐部']
			}
		},
		computed: {
			// 获取焦点时，热门搜索框出现，输入关键词 热门搜索框隐藏
			showHotWords() {
				return this.isFocus && this.search.length === 0
			},
			// 获取焦点时，输入关键词，热门搜索隐藏，搜索列表显示
			showSearchList() {
				return this.isFocus && this.search;
			}
   		},
		mounted() {
			
		},
		methods:{
			
			//   返回上一步
    		back() {
      		this.$router.go(-1);
    		},
			onDel(){ //删除
				this.$dialog.confirm({
				  title: '确定要清空搜索记录吗'
				})
				.then(() => {
				    this.saveList = []
					localStorage.saveList = JSON.stringify(this.saveList)
				})
				.catch(() => {
				    
				});
			},
			search(){
               alert(`搜索${this.keywords}相关的内容`);
             },
			 // 获取焦点
			onFoucs() {
				this.isFocus = true;
			},
			// 失去焦点
			onBlur() {
				setTimeout(() => {
				this.isFocus = false;
				}, 200)
			},
			// 监听input事件
			onInput() {
				console.log('input')
			}
		}
	}
</script>

<style lang="scss" scoped>
.header-search {
    position: relative;
    padding-left: 154px;
    /* 搜索框样式 */
    .search-wrap {
        display: flex;
        .search-input {
            width: 462px;
            height: 40px;
            /deep/ .el-input__inner {
                border-top-right-radius: 0!important;
                border-bottom-right-radius: 0!important;
                border-right: none;
                border-color: #13D1BE;
            }

        }
        .search-button {
            width: 88px;
            height: 40px;
            background: #13D1BE;
            border-color: #13D1BE;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    }
    /* 热搜词样式 */
    .hot-keywords {
        padding: 10px 0;
        display: flex;
        dd {
            padding: 0 6px;
            a {
                color: #999;
            }
        }
    }
    /* tag样式 */
    .search-tag {
        padding-top: 30px;
        color: #222;
        display: flex;
        dd {
            font-weight: 700;
            font-size: 16px;
            margin-right: 20px;
            cursor: pointer;
            position: relative;
        }
    }
    /* 聚焦框样式 */
    .focus-wrapper {
        position: absolute;
        z-index: 1000;
        width: 462px;
        box-sizing: border-box;
        padding: 10px 10px;
        background-color: #f8f8f8;
        border: 1px solid #E5E5E5;
        border-top: none;
        box-shadow: 0 3px 5px 0 rgba(0,0,0,.1);
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        dt {
            margin-bottom: 10px;
        }
        dd {
            display: inline-block;
            margin-right: 10px;
            line-height: 20px;
            a {
                color: #999;
                &:hover {
                    color: #31BBAC;
                }
            }

        }
    }
    /* 搜索关键词样式 */
    .key-words {
        position: absolute;
        z-index: 1000;
        width: 462px;
        box-sizing: border-box;
        padding: 10px 10px;
        background-color: #f8f8f8;
        border: 1px solid #E5E5E5;
        border-top: none;
        box-shadow: 0 3px 5px 0 rgba(0,0,0,.1);
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        dd {
            color: #999;
            line-height: 30px;
            a {
                color: #333;
                &:hover {
                    color: #31BBAC;
                }
            }
        }
    }
}
</style>
<style lang="scss" scoped>
.header-search {
    position: relative;
    padding-left: 154px;
    /* 搜索框样式 */
    .search-wrap {
        display: flex;
        .search-input {
            width: 462px;
            height: 40px;
            /deep/ .el-input__inner {
                border-top-right-radius: 0!important;
                border-bottom-right-radius: 0!important;
                border-right: none;
                border-color: #13D1BE;
            }

        }
        .search-button {
            width: 88px;
            height: 40px;
            background: #13D1BE;
            border-color: #13D1BE;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    }
    /* 热搜词样式 */
    .hot-keywords {
        padding: 10px 0;
        display: flex;
        dd {
            padding: 0 6px;
            a {
                color: #999;
            }
        }
    }
    /* tag样式 */
    .search-tag {
        padding-top: 30px;
        color: #222;
        display: flex;
        dd {
            font-weight: 700;
            font-size: 16px;
            margin-right: 20px;
            cursor: pointer;
            position: relative;
        }
    }
    /* 聚焦框样式 */
    .focus-wrapper {
        position: absolute;
        z-index: 1000;
        width: 462px;
        box-sizing: border-box;
        padding: 10px 10px;
        background-color: #f8f8f8;
        border: 1px solid #E5E5E5;
        border-top: none;
        box-shadow: 0 3px 5px 0 rgba(0,0,0,.1);
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        dt {
            margin-bottom: 10px;
        }
        dd {
            display: inline-block;
            margin-right: 10px;
            line-height: 20px;
            a {
                color: #999;
                &:hover {
                    color: #31BBAC;
                }
            }

        }
    }
    /* 搜索关键词样式 */
    .key-words {
        position: absolute;
        z-index: 1000;
        width: 462px;
        box-sizing: border-box;
        padding: 10px 10px;
        background-color: #f8f8f8;
        border: 1px solid #E5E5E5;
        border-top: none;
        box-shadow: 0 3px 5px 0 rgba(0,0,0,.1);
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        dd {
            color: #999;
            line-height: 30px;
            a {
                color: #333;
                &:hover {
                    color: #31BBAC;
                }
            }
        }
    }
}
</style>
