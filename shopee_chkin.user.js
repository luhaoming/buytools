// ==UserScript==
// @name         shopee_chkin
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  shopee_autochecking
// @author       Haoming Lu
// @match        https://shopee.tw/shopee-coins/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=shopee.tw
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    setTimeout(function() {
        var buttons = document.getElementsByTagName('button');
        for (var i = 0; i < buttons.length; i++) {
            if (buttons[i].textContent.includes('完成簽到')) {
                buttons[i].click();
                document.title='checkin ok'
                break;
            }
        }
    }, 1000);
})();
