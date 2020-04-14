# 蝦皮折扣碼配對工具

蝦皮折扣碼的逛逛搜尋全蝦皮，這個工具讓你只搜尋特定賣符合指定折扣碼的商品。

### 安裝方式
新增一個書籤，名稱任意，內容如下
```
javascript:(function()%7Bvar%20v%3D.1%3Bfunction%20dd(b)%7Bconsole.log(b)%7Dfunction%20getCookie(b)%7Bb%2B%3D%22%3D%22%3Bfor(var%20d%3DdecodeURIComponent(document.cookie).split(%22%3B%22)%2Cc%3D0%3Bc%3Cd.length%3Bc%2B%2B)%7Bfor(var%20a%3Dd%5Bc%5D%3B%22%20%22%3D%3Da.charAt(0)%3B)a%3Da.substring(1)%3Bif(0%3D%3Da.indexOf(b))return%20a.substring(b.length%2Ca.length)%7Dreturn%22%22%7Dvar%20runjs%3D!0%2Cthisurl%3Dwindow.location.href%2Cshopid%2Citemid%3Bif(%2F(%5C-i%5C.%5Cd%2B%5C.%5Cd%2B)%7C(product%5C%2F%5Cd%2B%5C%2F%5Cd%2B)%2F.test(thisurl))%7Bvar%20delimiter%3D%22.%22%3B%2Fproduct%2F.test(thisurl)%26%26(delimiter%3D%22%2F%22)%3Bvar%20tmpshop%3Dthisurl.split(delimiter)%3Bshopid%3Dtmpshop%5Btmpshop.length-2%5D%3Bitemid%3Dtmpshop%5Btmpshop.length-1%5D%3BlocalStorage.myshopid%3Dshopid%3BlocalStorage.myitemid%3Ditemid%3Bthrow%209%3B%7Dif(%2Fvoucher-details%2F.test(location.href))throw%20localStorage.myvvcodeurl%3Dlocation.href%2Cvv%3Dlocation.href.split(%22%2F%22)%2Cvvtmp%3D%7Bvoucher_code%3Avv%5Bvv.length-3%5D%2Cpromotionid%3Avv%5Bvv.length-2%5D%2Csignature%3Avv%5Bvv.length-1%5D%7D%2Csearchurl%3D%22https%3A%2F%2Fshopee.tw%2Fsearch%3FhideRemainingPrice%3Dtrue%26promotionId%3D%22%2Bvvtmp.promotionid%2ClocalStorage.myshopid%26%26(searchurl%3Dsearchurl.replace(%2F%26shop%3D%5Cd%2B%2Fg%2C%22%22)%2Csearchurl%3Dsearchurl%2B%22%26shop%3D%22%2BlocalStorage.myshopid)%2Clocation.href%3Dsearchurl%2Cstopall%3D1%2C%22go%20to%20search%20matched%20products%22%3Bif(%2Fshopee%2F.test(thisurl)%26%26%2Fsearch%2F.test(thisurl)%26%26localStorage.myshopid)throw%20thisurl%3Dthisurl.replace(%2F%26shop%3D%5Cd%2B%2Fg%2C%22%22)%2Cthisurl%3Dthisurl%2B%22%26shop%3D%22%2BlocalStorage.myshopid%2Clocation.href%3Dthisurl%2C9%3Balert(%22%5Cu4f7f%5Cu7528%5Cu65b9%5Cu5f0f%3A%20%5Cu73fe%5Cu5728%5Cu76ee%5Cu6a19%5Cu5546%5Cu5e97%5Cu4efb%5Cu610f%5Cu5546%5Cu54c1%5Cu6309%5Cu4e00%5Cu6b21%2C%20%5Cu518d%5Cu5230%5Cu6298%5Cu6263%5Cu78bc%5Cu7684%5Cu53bb%5Cu901b%5Cu901b%5Cu518d%5Cu6309%5Cu4e00%5Cu6b21%22)%3Bdd(%22something%20error%22)%7D)()
```
### 基本說明
* 折扣碼必須已經是歸戶, 且還沒過期

### 使用方法
* 先到指定賣家任一商品頁按一下書籤工具。
* 進入折扣碼說明頁面，再按一次書籤。
* 工具會自動加上指定店家代號加上折扣碼編號，方便搜尋



