async function domomo(o){payload="doAction=reg&"+o+"&gift_code=",res=await fetch("https://www.momoshop.com.tw/ajax/promoMech.jsp",{credentials:"include",headers:{"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0",Accept:"application/json, text/javascript, */*","Accept-Language":"zh-TW,zh;q=0.8,en-US;q=0.5,en;q=0.3","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8","X-Requested-With":"XMLHttpRequest",Pragma:"no-cache","Cache-Control":"no-cache"},referrer:"https://www.momoshop.com.tw/edm/cmmedm.jsp?npn=1vEUj8hdxkxl&n=1&s1xb7e5w&mdiv=1000700000-webxs-gomission",body:payload,method:"POST",mode:"cors"}),res.ok&&console.log(await res.json())}function doit(){console.log("doit"),domomo("m_promo_no=M20200401004&dt_promo_no=D20200401001"),domomo("m_promo_no=M20200413005&dt_promo_no=D20200413001")}function main(){stime=stimetxt.match(/.{2}/g),now=new Date,timer=new Date(now.getFullYear(),now.getMonth(),now.getDate(),stime[0],stime[1],stime[2]||0,0)-now,setTimeout(doit,timer)||doit()}var stimetxt=prompt("starttime","240001");main();