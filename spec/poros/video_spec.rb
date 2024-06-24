require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video_data) do
    { id: 1, title: "Video 1", url: "http://example.com/video1", thumbnail: "http://example.com/thumb1.jpg" }
  end

  subject { described_class.new(video_data) }

  it 'initializes with correct attributes' do
    expect(subject.id).to eq(1)
    expect(subject.title).to eq("Video 1")
    expect(subject.url).to eq("http://example.com/video1")
    # expect(subject.thumbnail).to eq("http://example.com/thumb1.jpg")
  end
end