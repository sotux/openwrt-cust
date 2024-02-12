'use strict';
'require view';
'require form';
'require rpc';
'require poll';
'require dom';

var callServiceList = rpc.declare({
	object: 'service',
	method: 'list',
	params: [ 'name' ],
	expect: { '': {} },
	filter: function (data, args, extra) {
		var i, res = data[args.name] || {};
		for (i = 0; (i < extra.length) && (Object.keys(res).length > 0); ++i)
			res = res[extra[i]] || {};
		return res;
	}
});

var CBIVlmcsdStatus = form.DummyValue.extend({
	renderWidget: function() {
		var extra = ['instances', 'instance1'];
		var node = E('div', {}, E('p', {}, E('em', {}, _('Collecting data...'))));
		poll.add(function() {
			return Promise.all([
				callServiceList('kms', extra)
				.then(function(res) {
					return E('p', {}, E('em', {}, res.running
						? _('<b><font color=green>Vlmcsd is running.</font></b>')
						: _('<b><font color=red>Vlmcsd is not running.</font></b>'))
					);
				}),

			]).then(function(res) {
				res = res.filter(function(r) { return r ? 1 : 0 });
				dom.content(node, res);
			});
		});
		return node;
	}
});

// Project code format is tabs, not spaces
return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map('vlmcsd', _('Basic Setting'));

		s = m.section(form.TypedSection);
		s.title = '%s - %s'.format(_('vlmcsd'), _('Running Status'));
		s.anonymous = true;
		s.cfgsections = function() { return [ 'status' ] };

		s.option(CBIVlmcsdStatus);

		s = m.section(form.TypedSection, 'vlmcsd', _('vlmcsd'));
		o = s.option(form.Flag, 'enabled', _('Enable'),
			_('Enable vlmcsd service'));
		o.default = '0';
		o.rmempty = false;

		o = s.option(form.Flag, 'autoactivate', _('Auto activate'),
			_('Active Windows/Office automatically'));
		o.default = '0';
		o.rmempty = false;

		return m.render();
	},
});
