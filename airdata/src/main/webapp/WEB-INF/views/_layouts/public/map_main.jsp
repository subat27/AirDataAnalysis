<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31c799a3e6c57bcc8d12337698e4159a"></script>
<script>
    const container = document.querySelector('main#public-content.public-content > section#public-main--map > div#map-view');
    const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    container.setAttribute('style', 'width:100%;height:56vh;border-radius:16px;box-shadow: 0 0 16px 0 rgba(0,0,0,0.08);');

    let map = new kakao.maps.Map(container, options);
</script>
