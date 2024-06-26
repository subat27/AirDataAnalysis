<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31c799a3e6c57bcc8d12337698e4159a"></script>
<script>
    const container = document.querySelector('main#page-content--main > section#map.map');
    const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    container.setAttribute('style', 'width:100%;height:560px;');

    let map = new kakao.maps.Map(container, options);
</script>
