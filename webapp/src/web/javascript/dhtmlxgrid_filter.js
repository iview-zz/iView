
//v.2.1 build 90226

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
dhtmlXGridObject.prototype.filterBy=function(column, value, preserve){
	this._filters_ready();
	if (this.isTreeGrid()) 
		return this.filterTreeBy(column, value, preserve);
	if (this._f_rowsBuffer){
		if (!preserve){
			this.rowsBuffer=dhtmlxArray([].concat(this._f_rowsBuffer));
			if (this._fake)
				this._fake.rowsBuffer=this.rowsBuffer
		}
	}
	else
		this._f_rowsBuffer=[].concat(this.rowsBuffer);
	if (!this.rowsBuffer.length)
		return;
	var d=true;
	this.dma(true)
	if (typeof(column)=="object"){
 		for (var j=0;j<value.length;j++)
			this._filterA(column[j],value[j]);
	}
	else
		this._filterA(column,value);this.dma(false)
		if (this.pagingOn && this.rowsBuffer.length/this.rowsBufferOutSize < this.currentPage)
			this.changePage(0);
		this._reset_view();
		this.callEvent("onGridReconstructed",[])
};
		dhtmlXGridObject.prototype._filterA=function(column,value){if (value=="")return;var d=true;if (typeof(value)=="function") d=false;else value=(value||"").toString().toLowerCase();if (!this.rowsBuffer.length)return;for (var i=this.rowsBuffer.length-1;i>=0;i--)if (d?(this._get_cell_value(this.rowsBuffer[i],column).toString().toLowerCase().indexOf(value)==-1):(!value(this._get_cell_value(this.rowsBuffer[i],column),this.rowsBuffer[i].idd)))
 this.rowsBuffer.splice(i,1)};dhtmlXGridObject.prototype.getFilterElement=function(index){if (!this.filters)return;for (var i=0;i < this.filters.length;i++){if (this.filters[i][1]==index)return (this.filters[i][0].combo||this.filters[i][0])};return null};dhtmlXGridObject.prototype.collectValues=function(column){var value=this.callEvent("onCollectValues",[column]);if (value!==true)return value;if (this.isTreeGrid()) return this.collectTreeValues(column);this.dma(true)
 this._build_m_order();column=this._m_order?this._m_order[column]:column;var c={};var f=[];var col=this._f_rowsBuffer||this.rowsBuffer;for (var i=0;i<col.length;i++){var val=this._get_cell_value(col[i],column);if (val && (!col[i]._childIndexes || col[i]._childIndexes[column]!=col[i]._childIndexes[column-1])) c[val]=true};this.dma(false)
 
 var vals=this.combos[column];for (d in c)if (c[d]===true)f.push(vals?(vals.get(d)||d):d);return f.sort()};dhtmlXGridObject.prototype._build_m_order=function(){if (this._c_order){this._m_order=[]
 for (var i=0;i < this._c_order.length;i++){this._m_order[this._c_order[i]]=i}}};dhtmlXGridObject.prototype.filterByAll=function(){var a=[];var b=[];this._build_m_order();for (var i=0;i<this.filters.length;i++){var ind=this._m_order?this._m_order[this.filters[i][1]]:this.filters[i][1];b.push(ind);var val=this.filters[i][0]._filter?this.filters[i][0]._filter():this.filters[i][0].value;var vals;if (typeof val != "function" && (vals=this.combos[ind])){ind=vals.values._dhx_find(val);val=(ind==-1)?val:vals.keys[ind]};a.push(val)};if (!this.callEvent("onFilterStart",[b,a])) return;this.filterBy(b,a);if (this._cssEven)this._fixAlterCss();this.callEvent("onFilterEnd",[this.filters])};dhtmlXGridObject.prototype.makeFilter=function(id,column,preserve){if (!this.filters)this.filters=[];if (typeof(id)!="object")
 id=document.getElementById(id);if(!id)return;var self=this;if (!id.style.width)id.style.width = "90%";if (id.tagName=='SELECT'){this.filters.push([id,column]);this._loadSelectOptins(id,column);id.onchange=function(){self.filterByAll()};if(_isIE)id.style.marginTop="1px";this.attachEvent("onEditCell",function(stage,a,ind){this._build_m_order();if (stage==2 && this.filters && ( this._m_order?(ind==this._m_order[column]):(ind==column) ))
 this._loadSelectOptins(id,column);return true})}else if (id.tagName=='INPUT'){this.filters.push([id,column]);id.value='';id.onkeydown=function(){if (this._timer)window.clearTimeout(this._timer);this._timer=window.setTimeout(function(){self.filterByAll()},500)}}else if (id.tagName=='DIV' && id.className=="combo"){this.filters.push([id,column]);id.style.padding="0px";id.style.margin="0px";if (!window.dhx_globalImgPath)window.dhx_globalImgPath=this.imgURL;var z=new dhtmlXCombo(id,"_filter","90%");z.filterSelfA=z.filterSelf;z.filterSelf=function(){if (this.getSelectedIndex()==0) this.setComboText("");this.filterSelfA.apply(this,arguments);this.optionsArr[0].hide(false)};z.enableFilteringMode(true);id.combo=z;id.value="";this._loadComboOptins(id,column);z.attachEvent("onChange",function(){id.value=z.getSelectedValue();self.filterByAll()})};if (id.parentNode)id.parentNode.className+=" filter";this._filters_ready()};dhtmlXGridObject.prototype.findCell=function(value, c_ind, first){var res = new Array();value=value.toString().toLowerCase();if (!this.rowsBuffer.length)return res;for (var i = (c_ind||0);i < this._cCount;i++){if (this._h2)this._h2.forEachChild(0,function(el){if (this._get_cell_value(el.buff,i).toString().toLowerCase().indexOf(value) != -1){res.push([el.id,i]);if (first)return res}},this)
 else
 for (var j=0;j < this.rowsBuffer.length;j++)if (this._get_cell_value(this.rowsBuffer[j],i).toString().toLowerCase().indexOf(value) != -1){res.push([this.rowsBuffer[j].idd,i]);if (first)return res};if (typeof (c_ind)!= "undefined")
 return res};return res};dhtmlXGridObject.prototype.makeSearch=function(id,column){if (typeof(id)!="object")
 id=document.getElementById(id);if(!id)return;var self=this;if (id.tagName=='INPUT'){id.onkeypress=function(){if (this._timer)window.clearTimeout(this._timer);this._timer=window.setTimeout(function(){if (id.value=="")return;var z=self.findCell(id.value,column,true);if (z.length){if (self._h2)self.openItem(z[0][0]);self.setSelectedRow(z[0][0])
 }},500)}};if (id.parentNode)id.parentNode.className+=" filter"};dhtmlXGridObject.prototype._loadSelectOptins=function(t,c){var l=this.collectValues(c);t.innerHTML="";t.options[0]=new Option("","");var f=this._filter_tr?this._filter_tr[c]:null;for (var i=0;i<l.length;i++)t.options[t.options.length]=new Option(f?f(l[i]):l[i],l[i])};dhtmlXGridObject.prototype.setSelectFilterLabel=function(ind,fun){if (!this._filter_tr)this._filter_tr=[];this._filter_tr[ind]=fun};dhtmlXGridObject.prototype._loadComboOptins=function(t,c){var l=this.collectValues(c);t.combo.clearAll();t.combo.render(false);t.combo.addOption("","&nbsp;");for (var i=0;i<l.length;i++)t.combo.addOption(l[i],l[i]);t.combo.render(true)};dhtmlXGridObject.prototype.refreshFilters=function(){if (this.filters)for (var i=0;i<this.filters.length;i++){switch(this.filters[i][0].tagName.toLowerCase()){case "input":
 break;case "select":
 this._loadSelectOptins.apply(this,this.filters[i]);break;case "div":
 this._loadComboOptins.apply(this,this.filters[i]);break}}};dhtmlXGridObject.prototype._filters_ready=function(fl,code){this.attachEvent("onXLE",this.refreshFilters);this.attachEvent("onClearAll",function(){this._f_rowsBuffer=null;if (!this.obj.rows.length)this.filters=[]});if (window.dhtmlXCombo)this.attachEvent("onScroll",dhtmlXCombo.prototype.closeAll);this._filters_ready=function(){}};dhtmlXGridObject.prototype._in_header_text_filter=function(t,i){t.innerHTML="<input type='text' style='width:90%;font-size:8pt;font-family:Tahoma;-moz-user-select:text;'>";t.onclick=t.onmousedown = function(e){(e||event).cancelBubble=true;return true};t.onselectstart=function(){return (event.cancelBubble=true)};this.makeFilter(t.firstChild,i)};dhtmlXGridObject.prototype._in_header_text_filter_inc=function(t,i){t.innerHTML="<input type='text' style='width:90%;font-size:8pt;font-family:Tahoma;-moz-user-select:text;'>";t.onclick=t.onmousedown = function(e){(e||event).cancelBubble=true;return true};t.onselectstart=function(){return (event.cancelBubble=true)};this.makeFilter(t.firstChild,i);t.firstChild._filter=function(){return function(val){return (val.toString().toLowerCase().indexOf(t.firstChild.value.toLowerCase())==0)}};this._filters_ready()};dhtmlXGridObject.prototype._in_header_select_filter=function(t,i){t.innerHTML="<select style='width:90%;font-size:8pt;font-family:Tahoma;'></select>";t.onclick=function(e){(e||event).cancelBubble=true;return false};this.makeFilter(t.firstChild,i)};dhtmlXGridObject.prototype._in_header_select_filter_strict=function(t,i){t.innerHTML="<select style='width:90%;font-size:8pt;font-family:Tahoma;'></select>";t.onclick=function(e){(e||event).cancelBubble=true;return false};this.makeFilter(t.firstChild,i);var cs=this.combos;t.firstChild._filter=function(){var vn;if (cs[i])vn=cs[i].keys[cs[i].values._dhx_find(t.firstChild.value)];else 
 vn=t.firstChild.value.toLowerCase()
 return function(val){if (t.firstChild.value.toLowerCase()== "") return true;return (val.toString().toLowerCase()==vn)}};this._filters_ready()};dhtmlXGridObject.prototype._in_header_combo_filter=function(t,i){t.innerHTML="<div style='width:100%;padding-left:2px;overflow:hidden;font-size:8pt;font-family:Tahoma;-moz-user-select:text;' class='combo'></div>";t.onselectstart=function(){return (event.cancelBubble=true)};t.onclick=t.onmousedown=function(e){(e||event).cancelBubble=true;return true};this.makeFilter(t.firstChild,i)};dhtmlXGridObject.prototype._in_header_text_search=function(t,i){t.innerHTML="<input type='text' style='width:90%;font-size:8pt;font-family:Tahoma;-moz-user-select:text;'>";t.onclick= t.onmousedown = function(e){(e||event).cancelBubble=true;return true};t.onselectstart=function(){return (event.cancelBubble=true)};this.makeSearch(t.firstChild,i)};dhtmlXGridObject.prototype._in_header_numeric_filter=function(t,i){this._in_header_text_filter.call(this,t,i);t.firstChild._filter=function(){var v=this.value;var r;var op="==";var num=parseFloat(v.replace("=",""));var num2=null;if (v){if (v.indexOf("..")!=-1){v=v.split("..");num=parseFloat(v[0]);num2=parseFloat(v[1]);return function(v){if (v>=num && v<=num2)return true;return false}};r=v.match(/>=|>|<=|</)
 if (r){op=r[0];num=parseFloat(v.replace(op,""))};return Function("v"," if (v "+op+" "+num+" )return true;return false;")}}};dhtmlXGridObject.prototype._in_header_master_checkbox=function(t,i,c){t.innerHTML=c[0]+"<input type='checkbox' />"+c[1];var self=this;t.firstChild.onclick=function(e){self._build_m_order();var j=self._m_order?self._m_order[i]:i;var val=this.checked?1:0;self.forEachRow(function(id){var c=this.cells(id,j);if (c.isCheckbox()) c.setValue(val)});(e||event).cancelBubble=true}};dhtmlXGridObject.prototype._in_header_stat_total=function(t,i,c){var calck=function(){var summ=0;for (var j=0;j<this.rowsBuffer.length;j++){var v=parseFloat(this._get_cell_value(this.rowsBuffer[j],i));summ+=isNaN(v)?0:v};return this._maskArr[i]?this._aplNF(summ,i):(Math.round(summ*100)/100)};this._stat_in_header(t,calck,i,c,c)};dhtmlXGridObject.prototype._in_header_stat_multi_total=function(t,i,c){var cols=c[1].split(":");c[1]="";for(var k = 0;k < cols.length;k++){cols[k]=parseInt(cols[k])};var calck=function(){var summ=0;for (var j=0;j<this.rowsBuffer.length;j++){var v = 1;for(var k = 0;k < cols.length;k++){v *= parseFloat(this._get_cell_value(this.rowsBuffer[j],cols[k]))
 };summ+=isNaN(v)?0:v};return this._maskArr[i]?this._aplNF(summ,i):(Math.round(summ*100)/100)};var track=[];for(var i = 0;i < cols.length;i++){track[cols[i]]=true};this._stat_in_header(t,calck,track,c,c)};dhtmlXGridObject.prototype._in_header_stat_max=function(t,i,c){var calck=function(){var summ=-999999999;if (this.getRowsNum()==0) return "&nbsp;";for (var j=0;j<this.rowsBuffer.length;j++)summ=Math.max(summ,parseFloat(this._get_cell_value(this.rowsBuffer[j],i)));return this._maskArr[i]?this._aplNF(summ,i):summ};this._stat_in_header(t,calck,i,c)};dhtmlXGridObject.prototype._in_header_stat_min=function(t,i,c){var calck=function(){var summ=999999999;if (this.getRowsNum()==0) return "&nbsp;";for (var j=0;j<this.rowsBuffer.length;j++)summ=Math.min(summ,parseFloat(this._get_cell_value(this.rowsBuffer[j],i)));return this._maskArr[i]?this._aplNF(summ,i):summ};this._stat_in_header(t,calck,i,c)};dhtmlXGridObject.prototype._in_header_stat_average=function(t,i,c){var calck=function(){var summ=0;var count=0;if (this.getRowsNum()==0) return "&nbsp;";for (var j=0;j<this.rowsBuffer.length;j++){var v=parseFloat(this._get_cell_value(this.rowsBuffer[j],i));summ+=isNaN(v)?0:v;count++};return this._maskArr[i]?this._aplNF(summ/count,i):(Math.round(summ/count*100)/100)};this._stat_in_header(t,calck,i,c)};dhtmlXGridObject.prototype._in_header_stat_count=function(t,i,c){var calck=function(){return this.getRowsNum()};this._stat_in_header(t,calck,i,c)};dhtmlXGridObject.prototype._stat_in_header=function(t,calck,i,c){var that=this;var f=function(){this.dma(true)
 t.innerHTML=(c[0]?c[0]:"")+calck.call(this)+(c[1]?c[1]:"");this.dma(false)
 this.callEvent("onStatReady",[])
 };if (!this._stat_events){this._stat_events=[];this.attachEvent("onClearAll",function(){if (!this.hdr.rows[1]){for (var i=0;i<this._stat_events.length;i++)for (var j=0;j < 4;j++)this.detachEvent(this._stat_events[i][j]);this._stat_events=[]}})
 };this._stat_events.push([
 this.attachEvent("onGridReconstructed",f),
 this.attachEvent("onXLE",f),
 this.attachEvent("onFilterEnd",f),
 this.attachEvent("onEditCell",function(stage,id,ind){if (stage==2 && ( ind==i || ( i && i[ind])) ) f.call(this);return true})]);t.innerHTML=""};//(c)dhtmlx ltd. www.dhtmlx.com
//v.2.1 build 90226

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
