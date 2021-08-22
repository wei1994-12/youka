// module.exports={
//     publicPath: process.env.NODE_ENV === 'production' ? 'https://admin.pythl.com/' : './',
//     outputDir: 'dist',
//     assetsDir: 'static',
//     chainWebpack:config=>{
//       config.plugins.delete("prefetch")
//       //删除index.html开头的带有prefetch属性的link，不要异步下载暂时不需要的页面组件文件
//     },
//     devServer: {
//       proxy: {
//         '/': { //今后，当前项目中凡是以/开头的请求都归当前代理服务器代为发送。
//           target: 'https://api.pythl.com',
//           changeOrigin: true, //允许跨域
//           pathRewrite:{  // 路径重写，
//             '^/api': ''  // 替换target中的请求地址，也就是说以后你在请求https://xxxxxx/dictionary/data_dictionary_front.json这个地址的时候直接写成/api即可。
//           }
//         }
//       }
//     }
//   }