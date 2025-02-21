'use strict';
'require dom';
'require fs';
'require poll';
'require uci';
'require view';

return view.extend({
	render: function() {
		let css = `
			#log_textarea {
				padding: 10px;
				text-align: left;
			}
			#log_textarea pre {
				padding: .5rem;
				word-break: break-all;
				margin: 0;
				overflow: auto;
				white-space: pre;
				height: 600px;
			}
			.description {
				background-color: #33ccff;
			}`;

		let log_textarea = E('div', { 'id': 'log_textarea' },
			_('Collecting data...')
		);

		let log_path = '/var/log/dae.log';

		poll.add(L.bind(function() {
			return fs.read_direct(log_path, 'text')
			.then(function(res) {
				let log = E('pre', { 'wrap': 'pre' }, [
					res.trim() || _('Log is clean.')
				]);

				dom.content(log_textarea, log);
				log.scrollTop=log.scrollHeight; // scroll to bottom
			}).catch(function(err) {
				let log;

				if (err.toString().includes('NotFoundError'))
					log = E('pre', { 'wrap': 'pre' }, [
						_('Log file does not exist.')
					]);
				else
					log = E('pre', { 'wrap': 'pre' }, [
						_('Unknown error: %s').format(err)
					]);

				dom.content(log_textarea, log);
			});
		}));

		return E([
			E('style', [ css ]),
			E('div', {'class': 'cbi-map'}, [
				E('div', {'class': 'cbi-section'}, [
					log_textarea,
					E('div', {'style': 'text-align:right'},
					E('small', {}, _('Refresh every %d seconds.').format(L.env.pollinterval))
					)
				])
			])
		]);
	},

	handleSaveApply: null,
	handleSave: null,
	handleReset: null
});
