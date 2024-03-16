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
		var extra = ['instances', 'dae'];
		var node = E('div', {}, E('p', {}, E('em', {}, _('Collecting data...'))));
		poll.add(function() {
			return Promise.all([
				callServiceList('dae', extra)
				.then(function(res) {
					return E('p', {}, E('em', {}, res.running
						? _('<b><font color=green>Dae is running.</font></b>')
						: _('<b><font color=red>Dae is not running.</font></b>'))
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

		m = new form.Map('dae', _('Basic Setting'));

		s = m.section(form.TypedSection);
		s.title = '%s - %s'.format(_('Dae'), _('Running Status'));
		s.anonymous = true;
		s.cfgsections = function() { return [ 'status' ] };

		s.option(CBIVlmcsdStatus);

		s = m.section(form.TypedSection, 'dae', _('Dae'));
		s.anonymous = true;
		o = s.option(form.Flag, 'enabled', _('Enable'),
			_('Enable dae service'));
		o.default = '0';
		o.rmempty = false;

		o = s.option(form.ListValue, 'geodb', _('Geo DB'));
		o.value('loyalsoldier', _('Loyalsoldier'));
		o.value('v2fly', _('V2fly'));
		o.default = 'loyalsoldier';

		o = s.option(form.Value, 'log_maxbackups', _('Log max backups'),
			_('Dae log max backups'));
		o.default = 1;
		o.rmempty = false;
		o.datatype = 'uinteger';

		o = s.option(form.Value, 'log_maxsize', _('Log max size(MB)'),
			_('Dae log max size'));
		o.default = 1;
		o.rmempty = false;
		o.datatype = 'uinteger';

		return m.render();
	},
});
