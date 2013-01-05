<!DOCTYPE html>
<meta charset=utf-8>
<title>2013 年似乎依然有效购票信息</title>
<script type=text/javascript>
(function() {
    var getPhoneNumber = function(division) {
        switch (division) {
            case '成':
                return '96006';
            case '西':
                return '96688';
            case '未知':
                return '车站归属路局未知，参见<a href=http://www.12306.cn/mormhweb/kyyyz/>客运营业站站点</a>';
            default:
                return '95105105';
        }
    }
    window.addEventListener('load', function() {
        var boarding = document.getElementById('boarding');
        boarding.addEventListener('keypress', function(evt) {
            if (evt.keyCode == 13) {
                var xhr = new XMLHttpRequest();
                xhr.open('GET', '/info?sn=' + encodeURIComponent(boarding.value), true);
                xhr.onload = function(evt) {
                    var info = JSON.parse(xhr.responseText);
                    var summary = '没有该车站的信息，车站名称请以<a href=http://www.12306.cn/mormhweb/zxdt/tlxw_tdbtz53.html>各站互联网起售时间公布</a>为准'
                    if (info['t']) {
                        summary = '<ul><li>';
                        summary += 11 > (new Date()).getHours()
                            ? '今日 11:00 起发售 ' + (new Date(Date.now() + 19 * 86400* 1000)).toLocaleDateString() + ' 始发 C/D/G 车票'
                            : '明日 11:00 起发售 ' + (new Date(Date.now() + 20 * 86400* 1000)).toLocaleDateString() + ' 始发 C/D/G 车票';
                        summary += '<li>';
                        summary += (parseInt(info['t'])) > (new Date()).getHours()
                            ? '今日 ' + info['t'] + ':00 起发售 ' + (new Date(Date.now() + 19 * 86400* 1000)).toLocaleDateString() + ' 始发其它车票'
                            : '明日 ' + info['t'] + ':00 起发售 ' + (new Date(Date.now() + 20 * 86400* 1000)).toLocaleDateString() + ' 始发其它车票';
                        summary += '<li>购票电话：' + getPhoneNumber(info['d']) + '<li>购票网站：<a href=http://www.12306.cn/mormhweb/kyfw/>铁路客户服务中心</a></ul>';
                    }
                    document.getElementById('summary').innerHTML = summary;
                }
                xhr.send(null);
                evt.preventDefault();
            }
        }, false);
        var detail = '';    
        count = 10;//Math.ceil(((new Date(2012, 0, 13)) - Date.now()) / 86400000);
        if (count > 1) {
            for (var i = 1; i < count; i++) {
                tmp = [];
                tmp.push('<tr><td>');
                tmp.push((new Date(Date.now() + i * 86400* 1000)).toLocaleDateString());
                tmp.push('</td><td>');
                tmp.push((new Date(Date.now() + (i + 19) * 86400* 1000)).toLocaleDateString());
                tmp.push('</td></tr>');
                detail += tmp.join('');
            }
        }
        document.getElementById('detail').innerHTML = detail;
    }, false);
})();
</script>
<input id=boarding type=text placeholder=请输入乘车站名称查询放票时间>
<div id=summary></div>
<table>
    <thead>
        <tr><th>售票日期（电话、网站）</th><th>乘车日期</th></tr>
    </thead>
    <tbody id=detail>
    </tbody>
</table>
