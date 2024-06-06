require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_data) do
    {
      id: 1,
      name: "John Doe",
      email: "john.doe@example.com",
      image: "http://example.com/image.jpg",
      favorite_videos: [
        { id: 1, title: "Video 1", url: "http://example.com/video1", thumbnail: "http://example.com/thumb1.jpg" },
        { id: 2, title: "Video 2", url: "http://example.com/video2", thumbnail: "http://example.com/thumb2.jpg" }
      ]
    }
  end

  subject { described_class.new(user_data) }

  it 'initializes with correct attributes' do
    expect(subject.id).to eq(1)
    expect(subject.name).to eq("John Doe")
    expect(subject.email).to eq("john.doe@example.com")
    expect(subject.image).to eq("http://example.com/image.jpg")
    expect(subject.favorite_videos.size).to eq(2)
    expect(subject.favorite_videos.first).to be_a(Video)
  end
end