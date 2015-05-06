require 'wikiParse'

RSpec.describe WikiPage, '#pageData' do
	context 'valid page' do
		validWiki = WikiPage.new('Ithaca_College')
		it 'contains connections' do
			expect(validWiki.connections.length).not_to eq 0
		end

		it 'hasn\'t been seen' do
			expect(validWiki.seen).to eq false
		end

		it 'has been seen after calling set seen w/ true' do
			validWiki.setSeen(true)
			expect(validWiki.seen).to eq true
		end
	end
end