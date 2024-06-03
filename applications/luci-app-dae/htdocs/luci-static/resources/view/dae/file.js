'use strict';
'require fs';
'require view';
'require ui';

function handleAction(ev) {
	fs.exec_direct('/etc/init.d/dae', [ev])
}

return view.extend({
	load: function() {
		return L.resolveDefault(fs.read_direct('/etc/dae/config.dae'), '');
	},

	render: function(data) {
		return E([
			E('h2', {'name': 'content'}, '%s - %s'.format(_('Dae'), _('Config file'))),
			E('p', {'name': 'content'}, '%s'.format(_('This file is /etc/dae/config.dae.'))),
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

	handleSave: null,
	handleSaveApply: function(ev) {
		let value = ((document.querySelector('textarea').value || '').replace(/\r\n/g, '\n'));
		return fs.write('/etc/dae/config.dae', value)
			.then(function(rc) {
				document.querySelector('textarea').value = value;
				ui.addNotification(null, E('p', _('Changes have been saved.')), 'info');
				handleAction('restart');
			}).catch(function(e) {
				ui.addNotification(null, E('p', _('Unable to save changes: %s').format(e.message)));
			});
	},
	handleReset: null
});
