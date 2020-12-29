(function(){

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu">' +
			'<table>' +
				'<thead>' +
					'<tr>' +
						'{{#head}}<td>{{content}}</td>{{/head}}' +
					'</tr>' +
				'</thead>'+
				'<tbody>' +
					'{{#rows}}' +
						'<tr>' +
							'{{#cols}}<td>{{{content}}}</td>{{/cols}}' +
						'</tr>' +
					'{{/rows}}' +
				'</tbody>' +
			'</table>' +
		'</div>'
	;

	window.tqrp_MENU       = {};
	tqrp_MENU.ResourceName = 'tqrp_menu_list';
	tqrp_MENU.opened       = {};
	tqrp_MENU.focus        = [];
	tqrp_MENU.data         = {};

	tqrp_MENU.open = function(namespace, name, data) {

		if (typeof tqrp_MENU.opened[namespace] == 'undefined') {
			tqrp_MENU.opened[namespace] = {};
		}

		if (typeof tqrp_MENU.opened[namespace][name] != 'undefined') {
			tqrp_MENU.close(namespace, name);
		}

		data._namespace = namespace;
		data._name      = name;

		tqrp_MENU.opened[namespace][name] = data;

		tqrp_MENU.focus.push({
			namespace: namespace,
			name     : name
		});
		
		tqrp_MENU.render();
	};

	tqrp_MENU.close = function(namespace, name) {
		delete tqrp_MENU.opened[namespace][name];

		for (let i=0; i<tqrp_MENU.focus.length; i++) {
			if (tqrp_MENU.focus[i].namespace == namespace && tqrp_MENU.focus[i].name == name) {
				tqrp_MENU.focus.splice(i, 1);
				break;
			}
		}

		tqrp_MENU.render();
	};

	tqrp_MENU.render = function() {

		let menuContainer       = document.getElementById('menus');
		let focused             = tqrp_MENU.getFocused();
		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for (let namespace in tqrp_MENU.opened) {
			
			if (typeof tqrp_MENU.data[namespace] == 'undefined') {
				tqrp_MENU.data[namespace] = {};
			}

			for (let name in tqrp_MENU.opened[namespace]) {

				tqrp_MENU.data[namespace][name] = [];

				let menuData = tqrp_MENU.opened[namespace][name];
				let view = {
					_namespace: menuData._namespace,
					_name     : menuData._name,
					head      : [],
					rows      : []
				};

				for (let i=0; i<menuData.head.length; i++) {
					let item = {content: menuData.head[i]};
					view.head.push(item);
				}

				for (let i=0; i<menuData.rows.length; i++) {
					let row  = menuData.rows[i];
					let data = row.data;

					tqrp_MENU.data[namespace][name].push(data);

					view.rows.push({cols: []});

					for (let j=0; j<row.cols.length; j++) {

						let col     = menuData.rows[i].cols[j];
						let regex   = /\{\{(.*?)\|(.*?)\}\}/g;
						let matches = [];
						let match;

						while ((match = regex.exec(col)) != null) {
							matches.push(match);
						}

						for (let k=0; k<matches.length; k++) {
							col = col.replace('{{' + matches[k][1] + '|' + matches[k][2] + '}}', '<button data-id="' + i + '" data-namespace="' + namespace + '" data-name="' + name + '" data-value="' + matches[k][2] +'">' + matches[k][1] + '</button>');
						}

						view.rows[i].cols.push({data: data, content: col});
					}
				}

				let menu = $(Mustache.render(MenuTpl, view));

				menu.find('button[data-namespace][data-name]').click(function() {
					tqrp_MENU.submit($(this).data('namespace'), $(this).data('name'), {
						data : tqrp_MENU.data[$(this).data('namespace')][$(this).data('name')][parseInt($(this).data('id'))],
						value: $(this).data('value')
					});
				});

				menu.hide();

				menuContainer.appendChild(menu[0]);
			}
		}

		if (typeof focused != 'undefined') {
			$('#menu_' + focused.namespace + '_' + focused.name).show();
		}

		$(menuContainer).show();
	};

	tqrp_MENU.submit = function(namespace, name, data){
		$.post('http://' + tqrp_MENU.ResourceName + '/menu_submit', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			data      : data.data,
			value     : data.value
		}));
	};

	tqrp_MENU.cancel = function(namespace, name){
		$.post('http://' + tqrp_MENU.ResourceName + '/menu_cancel', JSON.stringify({
			_namespace: namespace,
			_name     : name
		}));
	};

	tqrp_MENU.getFocused = function(){
		return tqrp_MENU.focus[tqrp_MENU.focus.length - 1];
	};

	window.onData = (data) => {
		switch(data.action){
			case 'openMenu' : {
				tqrp_MENU.open(data.namespace, data.name, data.data);
				break;
			}

			case 'closeMenu' : {
				tqrp_MENU.close(data.namespace, data.name);
				break;
			}
		}
	};

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

	document.onkeyup = function(data) {
		if(data.which == 27) {
			let focused = tqrp_MENU.getFocused();
			tqrp_MENU.cancel(focused.namespace, focused.name);
		}
	};

})();