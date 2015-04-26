require 'wikiParse'

RSpec.describe WikiPage, '#pageData' do
	context 'valid page' do
		it 'contains connections' do
			wiki = WikiPage.new('Ithaca_College')
			expect(wiki.connections.length).not_to eq 0
		end
	end
end