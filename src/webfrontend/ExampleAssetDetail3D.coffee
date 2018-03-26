class ExampleAssetDetail3D extends AssetDetail
	getButtonLocaKey: (asset) ->
		console.debug "class extension", asset.value.class_extension
		if asset.value.class_extension != "vector3d.ctm"
			return


		orig = asset.value.versions.original

		console.error "VERSIONS:", asset.value.versions

		if orig.status != "done"
			return

		"example.asset.detail.3D"


	createMarkup: ->
		# console.debug "creatingMarkup", @
		super()

		orig = @asset.value.versions.huge # original

		console.debug "ORIG:", orig

		obj = CUI.dom.element("A-SCENE", embedded: true);
		item = CUI.dom.element("A-ASSET-ITEM", id: "model", src: ez5.getAbsoluteURL(orig.url), color: "#{FFFFFF}");
		obj.appendChild(item);
		ctm = CUI.dom.element("A-ENTITY", id: "mesh", ctm: "src: '#{model}'", position: "0 1.5 -2");
		obj.appendChild(ctm);
		light1 = CUI.dom.element("A-ENTITY", light: "type: point; intensity: 1; distance: 50; decay: 2", position:"5 5 5");
		obj.appendChild(light1);
		light2 = CUI.dom.element("A-ENTITY", light: "type: point; intensity: 1; distance: 50; decay: 2", position:"5 5 -5");
		obj.appendChild(light2);
		light3 = CUI.dom.element("A-ENTITY", light: "type: point; intensity: 1; distance: 50; decay: 2", position:"-5 5 5");
		obj.appendChild(light3);
		sky = CUI.dom.element("A-SKY", color: "#bbbbbb");
		obj.appendChild(sky);

		CUI.dom.append(@outerDiv, obj);

		# lbl = new CUI.Label
		# 	class: "ez5-example-asset-detail-filename"
		# 	text: "360°"

		# CUI.dom.append(@outerDiv, lbl)

ez5.session_ready =>
	scriptNode = CUI.dom.element "SCRIPT",
		src: "https://aframe.io/releases/0.7.1/aframe.min.js"
		src: "https://cdn.rawgit.com/MfN-Berlin/aframe-ctm-model/master/bundle.js"
		type: "text/javascript"
		charset: "utf-8"

	document.head.appendChild(scriptNode)
	AssetBrowser.plugins.registerPlugin(ExampleAssetDetail3D)
