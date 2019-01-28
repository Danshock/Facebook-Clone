require 'test_helper'

class PostTest < ActiveSupport::TestCase

  # Posts should be ordered in DESC format
  test "order should be most recent first" do
  	assert_equal posts(:most_recent), Post.first
  end
  
end
