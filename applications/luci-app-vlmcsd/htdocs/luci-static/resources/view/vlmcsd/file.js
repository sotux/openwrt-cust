'use strict';
'require fs';
'require view';
'require ui';

return view.extend({
	load: function() {
		return L.resolveDefault(fs.read_direct('/etc/vlmcsd.ini'), '');
	},

	render: function(data) {
		return E([
			E('h2', {'name': 'content'}, '%s - %s'.format(_('Vlmcsd'), _('configfile'))),
			E('p', {'name': 'content'}, '%s'.format(_('This file is /etc/vlmcsd.ini.'))),
			E('p', {},
				E('textarea', {
					'style': 'width: 100% !important; padding: 5px; font-family: monospace',
					'spellcheck': 'false',
					'wrap': 'off',
					'rows': 25
				}, [ data != null ? data : '' ])
			)
		]);
	},

	handleSave: function(ev) {
		var value = ((document.querySelector('textarea').value || '').replace(/\r\n/g, '\n')) + '\n';
		return fs.write('/etc/vlmcsd.ini', value)
			.then(function(rc) {
				document.querySelector('textarea').value = value;
				ui.addNotification(null, E('p', _('Changes have been saved.')), 'info');
			}).catch(function(e) {
				ui.addNotification(null, E('p', _('Unable to save changes: %s').format(e.message)));
			});
	},
	handleSaveApply: null,
	handleReset: null
});
