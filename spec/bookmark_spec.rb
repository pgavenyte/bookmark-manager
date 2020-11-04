require 'bookmark'
require 'database_helper'

describe Bookmark do

  describe '#self.all' do
    it "connects to the bookmarks table" do
      expect { Bookmark.all }.to_not raise_error
    end

    it "returns a list of all bookmarks" do
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
      
      bookmark = Bookmark.add(url: "http://www.makersacademy.com", title: "Makers Academy")
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#self.add' do
    it 'adds a new bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'ASOS'
      expect(bookmark.url).to eq 'http://www.asos.com'
    end
  end

  describe '#self.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '#self.update' do
    it 'allows to update a bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.pasos.com', title: 'PASOS')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'PASOS'
      expect(updated_bookmark.url).to eq 'http://www.pasos.com'
    end
  end

  describe '#self.find' do
    it 'finds the bookmark object' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      old_bookmark = Bookmark.find(id: bookmark.id)

      expect(old_bookmark.id).to eq bookmark.id
      expect(old_bookmark.title).to eq 'ASOS'
      expect(old_bookmark.url).to eq 'http://www.asos.com'
    end
  end
end