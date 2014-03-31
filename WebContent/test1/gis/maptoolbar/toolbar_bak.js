/*****
	ҳ�湤��������
	div  ��ʾ�˵�div
	opt.imgUrl ����ҳ����Ը�Ŀ¼λ��
	opt.mapUrl ����iframe�еĵ�ͼʱ��Ϊiframe ��id
	opt.menu true ��Ӳ˵���Ĭ��false
*****/

function Maptoolbar(div,opt){
	var me = this;
	this.container = $j("<div></div>");
	this._opt = opt;
	var imgUrl = this._opt.imgUrl;
	var mapUrl = window.parent.module.map;
	if(mapUrl){
		window.getMapApp = mapUrl.getMapApp;
		//debugger;
	}else{
		mapUrl = window;
	}
	
	if(div){
		$j(div).append(this.container);
	}else{
		$j("#bodydiv").prepend(this.container);
	}
	this.container.css({
		position:"relative",
		overflow:"hidden",
		top:"0px",
		left:"0px",
		width:'100%',
		height:31,
		zIndex:1
	}); 
	//alert("window.parent.Map :"+);//module  zt
	var table = $j("<table cellpadding=0 cellspacing=0 ></table>").css({
		height:"31",
		width:"100%",
		background:"url('"+imgUrl+"lib/maptoolbar/images/PGIS-10.jpg')"
		
	}).appendTo(this.container);
	var tr = $j("<tr></tr>").appendTo(table);
	//
	$j("<td width='5'></td>").appendTo(tr);
	var td = $j("<td ></td>").appendTo(tr);
	//�Ŵ�
	
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-11.jpg" width="59" height="31" style="margin-top:-5px;margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)"  />').bind("click",function(){mapUrl.activateRecZoomIn()}).appendTo(td);
	//��С
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-12.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.activateRecZoomOut()}).appendTo(td);
	//����
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-13.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.deactivate()}).appendTo(td);
	//ȫͼ
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-14.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.fullExtent()}).appendTo(td);
	//���
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-15.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.activateMeaturePolyline()}).appendTo(td);
	//����
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-16.jpg" width="72" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.activateMeaturePolygon()}).appendTo(td);
	//ӥ��
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-17.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){			  
		alert(mapUrl.getControl("OverviewMapControl").cp);
		}).appendTo(td);
	//��ӡ
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-19.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.print()}).appendTo(td);
	//���
	$j('<img src="'+imgUrl+'lib/maptoolbar/images/PGIS-21.jpg" width="59" height="31" style="margin-left:5px" onmouseover="movOver(this)" onmouseout="movOver(this)" />').bind("click",function(){mapUrl.clearOverlays()}).appendTo(td);
	//�˵�
	
	if(opt.menu){
		this.menu =  $j("<div></div>");
		this.menu.addClass("menuDiv")
		new Menu(config.MenuUrl, this.menu.get(0));
		$j("<td></td>").append(this.menu).appendTo(tr);
	}
}
function movOver(obj){
	var index=obj.src.indexOf("-b");
	var val=obj.src.lastIndexOf('\.');
	if(index!=-1){
		obj.src=obj.src.replace('-b','');
	}else{
		obj.src=obj.src.substr(0,val)+"-b"+obj.src.substr(val);
	}
	
}